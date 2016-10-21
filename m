From: Hardik Shah <hardik.t.shah@intel.com>
Subject: [RFC 03/14] SoundWire: Add error handling and locking documentation
Date: Fri, 21 Oct 2016 18:11:01 +0530
Message-ID: <1477053673-16021-4-git-send-email-hardik.t.shah@intel.com>
References: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: tiwai@suse.de, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, lgirdwood@gmail.com, plai@codeaurora.org, patches.audio@intel.com, Hardik Shah <hardik.t.shah@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

This patch adds following documentation:
    1. Bus driver locking mechanism.
    2. Bus driver error handling.

Signed-off-by: Hardik Shah <hardik.t.shah@intel.com>
Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 Documentation/sound/alsa/sdw/error_handling.txt |   71 +++++++++++++++++++++++
 Documentation/sound/alsa/sdw/locking.txt        |   64 ++++++++++++++++++++
 2 files changed, 135 insertions(+)
 create mode 100644 Documentation/sound/alsa/sdw/error_handling.txt
 create mode 100644 Documentation/sound/alsa/sdw/locking.txt

diff --git a/Documentation/sound/alsa/sdw/error_handling.txt b/Documentation/sound/alsa/sdw/error_handling.txt
new file mode 100644
index 0000000..9441cfa
--- /dev/null
+++ b/Documentation/sound/alsa/sdw/error_handling.txt
@@ -0,0 +1,71 @@
+The SoundWire PHY was designed with care and errors on the bus are going
+to be very unlikely, and if they happen they should be limited to single
+bit errors. Examples of this design can be found in the the
+synchronization mechanism (sync loss after two errors) and short CRCs
+used for the Bulk Register Access.
+
+The errors can be detected with multiple mechanisms:
+
+1. Bus clash or parity errors: This mechanism relies on low-level
+detectors that are independent of the payload and usages, and they
+cover both control and audio data. The current implementation only logs
+such errors. Improvements could consist in invalidating an entire
+programming sequence and restarting from a known position. In the case
+of such errors happening outside of a control/command sequence, there is
+no concealment or recovery for audio data enabled by the SoundWire
+protocol, the location of the error will also impact its audibility
+(most-significant bits will be more impacted in PCM), and after a number
+of such errors are detected the bus might be reset. Note that bus
+clashes due to programming errors (two streams using the same bit slots)
+or electrical issues during the transmit/receive transition cannot be
+distinguished, although a recurring bus clash when audio is enabled is a
+clear hint of a bus allocation issue. The interrupt mechanism can also
+help identify Slaves which detected a Bus Clash or a Parity Error, but
+they may not be responsible for the errors so resetting them
+individually is not a viable recovery strategy.
+
+2. Command status: Each command is associated with a status, which only
+covers transmission of the data between devices. The ACK status
+indicates that the command was received and will be executed by the end
+of the current frame. A NAK indicates that the command was in error and
+will not be applied. In case of a bad programming (command sent to
+non-existent Slave or to a non-implemented register) or electrical
+issue, no response signals the command was ignored. Some Master
+implementations allow for a command to be retransmitted several times.
+If the retransmission fails, backtracking and restarting the entire
+programming sequence might be a solution. Alternatively some
+implementations might directly issue a bus reset and re-enumerate all
+devices.
+
+3. Timeouts: In a number of cases such as ChannelPrepare or
+ClockStopPrepare, the bus driver is supposed to poll a register field
+until it transitions to a NotFinished value of zero. The MIPI SoundWire
+spec 1.1 does not define timeouts but the MIPI SoundWire DisCo document
+adds recommendation on timeouts. If such configurations do not complete,
+the driver will return a -ETIMEOUT. Such timeouts are symptoms of a
+faulty Slave device and are likely impossible to recover from.
+
+
+Errors during global reconfiguration sequences are extremely difficult
+to handle:
+
+1. BankSwitch: An error during the last command issuing a BankSwitch is
+difficult to backtrack from. Retransmitting the Bank Switch command
+may be possible in a single segment setup, but this can lead to
+synchronization problems when enabling multiple bus segments (a command
+with side effects such as frame reconfiguration would be handled at
+different times). A global hard-reset might be the best solution.
+
+2. ClockStop: If one Slave is not capable of engaging the clock stop and
+the system still needs to suspend, the priority might be to suspend
+anyway and reset the bus on startup. This would prevent any active
+standby/always-on activity but would not impact power targets.
+
+Note that SoundWire does not provide a detection mechanism for writing
+illegal values in valid registers. In a number of cases the standard
+even mentions that the Slave might behave in implementation-defined
+registers. The bus driver implementation does not provide a recovery
+mechanism for such errors, Slave or Master driver implementers are
+responsible for writing valid values in valid registers and implement
+additional range checking if needed.
+
diff --git a/Documentation/sound/alsa/sdw/locking.txt b/Documentation/sound/alsa/sdw/locking.txt
new file mode 100644
index 0000000..650162f
--- /dev/null
+++ b/Documentation/sound/alsa/sdw/locking.txt
@@ -0,0 +1,64 @@
+This document explains locking mechanism of the SoundWire bus driver.
+Following types of lock are used in SoundWire bus driver.
+
+1. Core lock
+2. Master lock
+3. Stream lock
+4. Message lock
+
+1. Core lock: Global SoundWire bus driver lock. Core lock is used to
+serialize each of the following operation(s) within SoundWire bus
+driver.
+	- Addition and removal of Master.
+	- Acquire "Master lock" of each Master associated with the
+	  aggregated stream.
+
+
+2. Master lock: SoundWire bus instance lock. Master lock is used to
+serialize each of the following operation(s) within SoundWire bus
+instance.
+	- Addition and removal of Slave(s).
+	- Prepare and enable, disable and de-prepare.
+
+
+3. Stream lock: SoundWire stream lock. Stream lock is used to serialize
+access of stream data structure for a SoundWire stream.
+
+
+4. Message lock: SoundWire message transfer lock. This lock is used to
+serialize the message transfers(read/write) within the SoundWire bus
+instance.
+
+
+Lock Hierarchy
+==============
+
+- Core lock is the parent of Master and Stream lock.
+- Master lock is parent of Message lock.
+- Master and Stream locks are independent of each other.
+
+Example
+=======
+
+Below example shows how locks are acquired during prepare and enable
+operation for aggregated stream. In this example, stream 1 is associated
+with Master 1 and Master 2.
+
+1. Acquire Core lock.
+2. Acquire Master 1 lock.
+3. Acquire Master 2 lock.
+4. Release Core lock.
+
+5. Prepare operation.
+	5.1 Acquire Message lock.
+	5.2 Transfer message on bus (Single message transfer example).
+	5.3 Release Message lock.
+6. Enable operation.
+	6.1 Acquire Message lock.
+	6.2 Transfer message on bus (Single message transfer example).
+	6.3 Release Message lock.
+
+7. Acquire Core lock.
+8. Release Master 1 lock.
+9. Release Master 2 lock.
+10. Release Core lock.
-- 
1.7.9.5
