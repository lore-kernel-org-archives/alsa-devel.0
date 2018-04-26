From: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v6 01/13] Documentation: soundwire: Add more
	documentation
Date: Thu, 26 Apr 2018 18:49:57 +0530
Message-ID: <1524748809-21860-2-git-send-email-vkoul@kernel.org>
References: <1524748809-21860-1-git-send-email-vkoul@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 191DD26779A
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 15:15:35 +0200 (CEST)
In-Reply-To: <1524748809-21860-1-git-send-email-vkoul@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Vinod Koul <vkoul@kernel.org>, broonie@kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Sanyog Kale <sanyog.r.kale@intel.com>

This adds documentation for error handling, locking and streams.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 .../driver-api/soundwire/error_handling.rst        |  65 ++++
 Documentation/driver-api/soundwire/index.rst       |   3 +
 Documentation/driver-api/soundwire/locking.rst     | 106 ++++++
 Documentation/driver-api/soundwire/stream.rst      | 372 +++++++++++++++++++++
 4 files changed, 546 insertions(+)
 create mode 100644 Documentation/driver-api/soundwire/error_handling.rst
 create mode 100644 Documentation/driver-api/soundwire/locking.rst
 create mode 100644 Documentation/driver-api/soundwire/stream.rst

diff --git a/Documentation/driver-api/soundwire/error_handling.rst b/Documentation/driver-api/soundwire/error_handling.rst
new file mode 100644
index 000000000000..aa3a0a23a066
--- /dev/null
+++ b/Documentation/driver-api/soundwire/error_handling.rst
@@ -0,0 +1,65 @@
+========================
+SoundWire Error Handling
+========================
+
+The SoundWire PHY was designed with care and errors on the bus are going to
+be very unlikely, and if they happen it should be limited to single bit
+errors. Examples of this design can be found in the synchronization
+mechanism (sync loss after two errors) and short CRCs used for the Bulk
+Register Access.
+
+The errors can be detected with multiple mechanisms:
+
+1. Bus clash or parity errors: This mechanism relies on low-level detectors
+   that are independent of the payload and usages, and they cover both control
+   and audio data. The current implementation only logs such errors.
+   Improvements could be invalidating an entire programming sequence and
+   restarting from a known position. In the case of such errors outside of a
+   control/command sequence, there is no concealment or recovery for audio
+   data enabled by the SoundWire protocol, the location of the error will also
+   impact its audibility (most-significant bits will be more impacted in PCM),
+   and after a number of such errors are detected the bus might be reset. Note
+   that bus clashes due to programming errors (two streams using the same bit
+   slots) or electrical issues during the transmit/receive transition cannot
+   be distinguished, although a recurring bus clash when audio is enabled is a
+   indication of a bus allocation issue. The interrupt mechanism can also help
+   identify Slaves which detected a Bus Clash or a Parity Error, but they may
+   not be responsible for the errors so resetting them individually is not a
+   viable recovery strategy.
+
+2. Command status: Each command is associated with a status, which only
+   covers transmission of the data between devices. The ACK status indicates
+   that the command was received and will be executed by the end of the
+   current frame. A NAK indicates that the command was in error and will not
+   be applied. In case of a bad programming (command sent to non-existent
+   Slave or to a non-implemented register) or electrical issue, no response
+   signals the command was ignored. Some Master implementations allow for a
+   command to be retransmitted several times.  If the retransmission fails,
+   backtracking and restarting the entire programming sequence might be a
+   solution. Alternatively some implementations might directly issue a bus
+   reset and re-enumerate all devices.
+
+3. Timeouts: In a number of cases such as ChannelPrepare or
+   ClockStopPrepare, the bus driver is supposed to poll a register field until
+   it transitions to a NotFinished value of zero. The MIPI SoundWire spec 1.1
+   does not define timeouts but the MIPI SoundWire DisCo document adds
+   recommendation on timeouts. If such configurations do not complete, the
+   driver will return a -ETIMEOUT. Such timeouts are symptoms of a faulty
+   Slave device and are likely impossible to recover from.
+
+Errors during global reconfiguration sequences are extremely difficult to
+handle:
+
+1. BankSwitch: An error during the last command issuing a BankSwitch is
+   difficult to backtrack from. Retransmitting the Bank Switch command may be
+   possible in a single segment setup, but this can lead to synchronization
+   problems when enabling multiple bus segments (a command with side effects
+   such as frame reconfiguration would be handled at different times). A global
+   hard-reset might be the best solution.
+
+Note that SoundWire does not provide a mechanism to detect illegal values
+written in valid registers. In a number of cases the standard even mentions
+that the Slave might behave in implementation-defined ways. The bus
+implementation does not provide a recovery mechanism for such errors, Slave
+or Master driver implementers are responsible for writing valid values in
+valid registers and implement additional range checking if needed.
diff --git a/Documentation/driver-api/soundwire/index.rst b/Documentation/driver-api/soundwire/index.rst
index 647e94654752..6db026028f27 100644
--- a/Documentation/driver-api/soundwire/index.rst
+++ b/Documentation/driver-api/soundwire/index.rst
@@ -6,6 +6,9 @@ SoundWire Documentation
    :maxdepth: 1
 
    summary
+   stream
+   error_handling
+   locking
 
 .. only::  subproject
 
diff --git a/Documentation/driver-api/soundwire/locking.rst b/Documentation/driver-api/soundwire/locking.rst
new file mode 100644
index 000000000000..253f73555255
--- /dev/null
+++ b/Documentation/driver-api/soundwire/locking.rst
@@ -0,0 +1,106 @@
+=================
+SoundWire Locking
+=================
+
+This document explains locking mechanism of the SoundWire Bus. Bus uses
+following locks in order to avoid race conditions in Bus operations on
+shared resources.
+
+  - Bus lock
+
+  - Message lock
+
+Bus lock
+========
+
+SoundWire Bus lock is a mutex and is part of Bus data structure
+(sdw_bus) which is used for every Bus instance. This lock is used to
+serialize each of the following operations(s) within SoundWire Bus instance.
+
+  - Addition and removal of Slave(s), changing Slave status.
+
+  - Prepare, Enable, Disable and De-prepare stream operations.
+
+  - Access of Stream data structure.
+
+Message lock
+============
+
+SoundWire message transfer lock. This mutex is part of
+Bus data structure (sdw_bus). This lock is used to serialize the message
+transfers (read/write) within a SoundWire Bus instance.
+
+Below examples show how locks are acquired.
+
+Example 1
+---------
+
+Message transfer.
+
+  1. For every message transfer
+
+     a. Acquire Message lock.
+
+     b. Transfer message (Read/Write) to Slave1 or broadcast message on
+        Bus in case of bank switch.
+
+     c. Release Message lock ::
+
+	+----------+                    +---------+
+	|          |                    |         |
+	|   Bus    |                    | Master  |
+	|          |                    | Driver  |
+	|          |                    |         |
+	+----+-----+                    +----+----+
+	     |                               |
+	     |     bus->ops->xfer_msg()      |
+	     <-------------------------------+   a. Acquire Message lock
+	     |                               |   b. Transfer message
+	     |                               |
+	     +------------------------------->   c. Release Message lock
+	     |    return success/error       |   d. Return success/error
+	     |                               |
+	     +                               +
+
+Example 2
+---------
+
+Prepare operation.
+
+  1. Acquire lock for Bus instance associated with Master 1.
+
+  2. For every message transfer in Prepare operation
+
+     a. Acquire Message lock.
+
+     b. Transfer message (Read/Write) to Slave1 or broadcast message on
+        Bus in case of bank switch.
+
+     c. Release Message lock.
+
+  3. Release lock for Bus instance associated with Master 1 ::
+
+	+----------+                    +---------+
+	|          |                    |         |
+	|   Bus    |                    | Master  |
+	|          |                    | Driver  |
+	|          |                    |         |
+	+----+-----+                    +----+----+
+	     |                               |
+	     |    sdw_prepare_stream()       |
+	     <-------------------------------+   1. Acquire bus lock
+	     |                               |   2. Perform stream prepare
+	     |                               |
+	     |                               |
+	     |     bus->ops->xfer_msg()      |
+	     <-------------------------------+   a. Acquire Message lock
+	     |                               |   b. Transfer message
+	     |                               |
+	     +------------------------------->   c. Release Message lock
+	     |    return success/error       |   d. Return success/error
+	     |                               |
+	     |                               |
+	     |    return success/error       |   3. Release bus lock
+	     +------------------------------->   4. Return success/error
+	     |                               |
+	     +                               +
diff --git a/Documentation/driver-api/soundwire/stream.rst b/Documentation/driver-api/soundwire/stream.rst
new file mode 100644
index 000000000000..29121aa55fb9
--- /dev/null
+++ b/Documentation/driver-api/soundwire/stream.rst
@@ -0,0 +1,372 @@
+=========================
+Audio Stream in SoundWire
+=========================
+
+An audio stream is a logical or virtual connection created between
+
+  (1) System memory buffer(s) and Codec(s)
+
+  (2) DSP memory buffer(s) and Codec(s)
+
+  (3) FIFO(s) and Codec(s)
+
+  (4) Codec(s) and Codec(s)
+
+which is typically driven by a DMA(s) channel through the data link. An
+audio stream contains one or more channels of data. All channels within
+stream must have same sample rate and same sample size.
+
+Assume a stream with two channels (Left & Right) is opened using SoundWire
+interface. Below are some ways a stream can be represented in SoundWire.
+
+Stream Sample in memory (System memory, DSP memory or FIFOs) ::
+
+	-------------------------
+	| L | R | L | R | L | R |
+	-------------------------
+
+Example 1: Stereo Stream with L and R channels is rendered from Master to
+Slave. Both Master and Slave is using single port. ::
+
+	+---------------+                    Clock Signal  +---------------+
+	|    Master     +----------------------------------+     Slave     |
+	|   Interface   |                                  |   Interface   |
+	|               |                                  |       1       |
+	|               |                     Data Signal  |               |
+	|    L  +  R    +----------------------------------+    L  +  R    |
+	|     (Data)    |     Data Direction               |     (Data)    |
+	+---------------+  +----------------------->       +---------------+
+
+
+Example 2: Stereo Stream with L and R channels is captured from Slave to
+Master. Both Master and Slave is using single port. ::
+
+
+	+---------------+                    Clock Signal  +---------------+
+	|    Master     +----------------------------------+     Slave     |
+	|   Interface   |                                  |   Interface   |
+	|               |                                  |       1       |
+	|               |                     Data Signal  |               |
+	|    L  +  R    +----------------------------------+    L  +  R    |
+	|     (Data)    |     Data Direction               |     (Data)    |
+	+---------------+  <-----------------------+       +---------------+
+
+
+Example 3: Stereo Stream with L and R channels is rendered by Master. Each
+of the L and R channel is received by two different Slaves. Master and both
+Slaves are using single port. ::
+
+	+---------------+                    Clock Signal  +---------------+
+	|    Master     +---------+------------------------+     Slave     |
+	|   Interface   |         |                        |   Interface   |
+	|               |         |                        |       1       |
+	|               |         |           Data Signal  |               |
+	|    L  +  R    +---+------------------------------+       L       |
+	|     (Data)    |   |     |    Data Direction      |     (Data)    |
+	+---------------+   |     |   +------------->      +---------------+
+	                    |     |
+	                    |     |
+	                    |     |                        +---------------+
+	                    |     +----------------------> |     Slave     |
+	                    |                              |   Interface   |
+	                    |                              |       2       |
+	                    |                              |               |
+	                    +----------------------------> |       R       |
+	                                                   |     (Data)    |
+	                                                   +---------------+
+
+
+Example 4: Stereo Stream with L and R channel is rendered by two different
+Ports of the Master and is received by only single Port of the Slave
+interface. ::
+
+	+--------------------+
+	|                    |
+	|     +--------------+                             +----------------+
+	|     |             ||                             |                |
+	|     |  Data Port  ||  L Channel                  |                |
+	|     |      1      |------------+                 |                |
+	|     |  L Channel  ||           |                 +-----+----+     |
+	|     |   (Data)    ||           |   L + R Channel ||    Data |     |
+	| Master  +----------+           | +---+---------> ||    Port |     |
+	| Interface          |           |                 ||     1   |     |
+	|     +--------------+           |                 ||         |     |
+	|     |             ||           |                 +----------+     |
+	|     |  Data Port  |------------+                 |                |
+	|     |      2      ||  R Channel                  |     Slave      |
+	|     |  R Channel  ||                             |   Interface    |
+	|     |   (Data)    ||                             |       1        |
+	|     +--------------+         Clock Signal        |     L  +  R    |
+	|                    +---------------------------> |      (Data)    |
+	+--------------------+                             |                |
+							   +----------------+
+
+SoundWire Stream Management flow
+================================
+
+Stream definitions
+------------------
+
+  (1) Current stream: This is classified as the stream on which operation has
+      to be performed like prepare, enable, disable, de-prepare etc.
+
+  (2) Active stream: This is classified as the stream which is already active
+      on Bus other than current stream. There can be multiple active streams
+      on the Bus.
+
+SoundWire Bus manages stream operations for each stream getting
+rendered/captured on the SoundWire Bus. This section explains Bus operations
+done for each of the stream allocated/released on Bus. Following are the
+stream states maintained by the Bus for each of the audio stream.
+
+
+SoundWire stream states
+-----------------------
+
+Below shows the SoundWire stream states and state transition diagram. ::
+
+	+-----------+     +------------+     +----------+     +----------+
+	| ALLOCATED +---->| CONFIGURED +---->| PREPARED +---->| ENABLED  |
+	|   STATE   |     |    STATE   |     |  STATE   |     |  STATE   |
+	+-----------+     +------------+     +----------+     +----+-----+
+	                                                           ^
+	                                                           |
+	                                                           |
+	                                                           v
+	         +----------+           +------------+        +----+-----+
+	         | RELEASED |<----------+ DEPREPARED |<-------+ DISABLED |
+	         |  STATE   |           |   STATE    |        |  STATE   |
+	         +----------+           +------------+        +----------+
+
+NOTE: State transition between prepare and deprepare is supported in Spec
+but not in the software (subsystem)
+
+NOTE2: Stream state transition checks need to be handled by caller
+framework, for example ALSA/ASoC. No checks for stream transition exist in
+SoundWire subsystem.
+
+Stream State Operations
+-----------------------
+
+Below section explains the operations done by the Bus on Master(s) and
+Slave(s) as part of stream state transitions.
+
+SDW_STREAM_ALLOCATED
+~~~~~~~~~~~~~~~~~~~~
+
+Allocation state for stream. This is the entry state
+of the stream. Operations performed before entering in this state:
+
+  (1) A stream runtime is allocated for the stream. This stream
+      runtime is used as a reference for all the operations performed
+      on the stream.
+
+  (2) The resources required for holding stream runtime information are
+      allocated and initialized. This holds all stream related information
+      such as stream type (PCM/PDM) and parameters, Master and Slave
+      interface associated with the stream, stream state etc.
+
+After all above operations are successful, stream state is set to
+``SDW_STREAM_ALLOCATED``.
+
+Bus implements below API for allocate a stream which needs to be called once
+per stream. From ASoC DPCM framework, this stream state maybe linked to
+.startup() operation.
+
+  .. code-block:: c
+  int sdw_alloc_stream(char * stream_name);
+
+
+SDW_STREAM_CONFIGURED
+~~~~~~~~~~~~~~~~~~~~~
+
+Configuration state of stream. Operations performed before entering in
+this state:
+
+  (1) The resources allocated for stream information in SDW_STREAM_ALLOCATED
+      state are updated here. This includes stream parameters, Master(s)
+      and Slave(s) runtime information associated with current stream.
+
+  (2) All the Master(s) and Slave(s) associated with current stream provide
+      the port information to Bus which includes port numbers allocated by
+      Master(s) and Slave(s) for current stream and their channel mask.
+
+After all above operations are successful, stream state is set to
+``SDW_STREAM_CONFIGURED``.
+
+Bus implements below APIs for CONFIG state which needs to be called by
+the respective Master(s) and Slave(s) associated with stream. These APIs can
+only be invoked once by respective Master(s) and Slave(s). From ASoC DPCM
+framework, this stream state is linked to .hw_params() operation.
+
+  .. code-block:: c
+  int sdw_stream_add_master(struct sdw_bus * bus,
+		struct sdw_stream_config * stream_config,
+		struct sdw_ports_config * ports_config,
+		struct sdw_stream_runtime * stream);
+
+  int sdw_stream_add_slave(struct sdw_slave * slave,
+		struct sdw_stream_config * stream_config,
+		struct sdw_ports_config * ports_config,
+		struct sdw_stream_runtime * stream);
+
+
+SDW_STREAM_PREPARED
+~~~~~~~~~~~~~~~~~~~
+
+Prepare state of stream. Operations performed before entering in this state:
+
+  (1) Bus parameters such as bandwidth, frame shape, clock frequency,
+      are computed based on current stream as well as already active
+      stream(s) on Bus. Re-computation is required to accommodate current
+      stream on the Bus.
+
+  (2) Transport and port parameters of all Master(s) and Slave(s) port(s) are
+      computed for the current as well as already active stream based on frame
+      shape and clock frequency computed in step 1.
+
+  (3) Computed Bus and transport parameters are programmed in Master(s) and
+      Slave(s) registers. The banked registers programming is done on the
+      alternate bank (bank currently unused). Port(s) are enabled for the
+      already active stream(s) on the alternate bank (bank currently unused).
+      This is done in order to not disrupt already active stream(s).
+
+  (4) Once all the values are programmed, Bus initiates switch to alternate
+      bank where all new values programmed gets into effect.
+
+  (5) Ports of Master(s) and Slave(s) for current stream are prepared by
+      programming PrepareCtrl register.
+
+After all above operations are successful, stream state is set to
+``SDW_STREAM_PREPARED``.
+
+Bus implements below API for PREPARE state which needs to be called once per
+stream. From ASoC DPCM framework, this stream state is linked to
+.prepare() operation.
+
+  .. code-block:: c
+  int sdw_prepare_stream(struct sdw_stream_runtime * stream);
+
+
+SDW_STREAM_ENABLED
+~~~~~~~~~~~~~~~~~~
+
+Enable state of stream. The data port(s) are enabled upon entering this state.
+Operations performed before entering in this state:
+
+  (1) All the values computed in SDW_STREAM_PREPARED state are programmed
+      in alternate bank (bank currently unused). It includes programming of
+      already active stream(s) as well.
+
+  (2) All the Master(s) and Slave(s) port(s) for the current stream are
+      enabled on alternate bank (bank currently unused) by programming
+      ChannelEn register.
+
+  (3) Once all the values are programmed, Bus initiates switch to alternate
+      bank where all new values programmed gets into effect and port(s)
+      associated with current stream are enabled.
+
+After all above operations are successful, stream state is set to
+``SDW_STREAM_ENABLED``.
+
+Bus implements below API for ENABLE state which needs to be called once per
+stream. From ASoC DPCM framework, this stream state is linked to
+.trigger() start operation.
+
+  .. code-block:: c
+  int sdw_enable_stream(struct sdw_stream_runtime * stream);
+
+SDW_STREAM_DISABLED
+~~~~~~~~~~~~~~~~~~~
+
+Disable state of stream. The data port(s) are disabled upon exiting this state.
+Operations performed before entering in this state:
+
+  (1) All the Master(s) and Slave(s) port(s) for the current stream are
+      disabled on alternate bank (bank currently unused) by programming
+      ChannelEn register.
+
+  (2) All the current configuration of Bus and active stream(s) are programmed
+      into alternate bank (bank currently unused).
+
+  (3) Once all the values are programmed, Bus initiates switch to alternate
+      bank where all new values programmed gets into effect and port(s) associated
+      with current stream are disabled.
+
+After all above operations are successful, stream state is set to
+``SDW_STREAM_DISABLED``.
+
+Bus implements below API for DISABLED state which needs to be called once
+per stream. From ASoC DPCM framework, this stream state is linked to
+.trigger() stop operation.
+
+  .. code-block:: c
+  int sdw_disable_stream(struct sdw_stream_runtime * stream);
+
+
+SDW_STREAM_DEPREPARED
+~~~~~~~~~~~~~~~~~~~~~
+
+De-prepare state of stream. Operations performed before entering in this
+state:
+
+  (1) All the port(s) of Master(s) and Slave(s) for current stream are
+      de-prepared by programming PrepareCtrl register.
+
+  (2) The payload bandwidth of current stream is reduced from the total
+      bandwidth requirement of bus and new parameters calculated and
+      applied by performing bank switch etc.
+
+After all above operations are successful, stream state is set to
+``SDW_STREAM_DEPREPARED``.
+
+Bus implements below API for DEPREPARED state which needs to be called once
+per stream. From ASoC DPCM framework, this stream state is linked to
+.trigger() stop operation.
+
+  .. code-block:: c
+  int sdw_deprepare_stream(struct sdw_stream_runtime * stream);
+
+
+SDW_STREAM_RELEASED
+~~~~~~~~~~~~~~~~~~~
+
+Release state of stream. Operations performed before entering in this state:
+
+  (1) Release port resources for all Master(s) and Slave(s) port(s)
+      associated with current stream.
+
+  (2) Release Master(s) and Slave(s) runtime resources associated with
+      current stream.
+
+  (3) Release stream runtime resources associated with current stream.
+
+After all above operations are successful, stream state is set to
+``SDW_STREAM_RELEASED``.
+
+Bus implements below APIs for RELEASE state which needs to be called by
+all the Master(s) and Slave(s) associated with stream. From ASoC DPCM
+framework, this stream state is linked to .hw_free() operation.
+
+  .. code-block:: c
+  int sdw_stream_remove_master(struct sdw_bus * bus,
+		struct sdw_stream_runtime * stream);
+  int sdw_stream_remove_slave(struct sdw_slave * slave,
+		struct sdw_stream_runtime * stream);
+
+
+The .shutdown() ASoC DPCM operation calls below Bus API to release
+stream assigned as part of ALLOCATED state.
+
+In .shutdown() the data structure maintaining stream state are freed up.
+
+  .. code-block:: c
+  void sdw_release_stream(struct sdw_stream_runtime * stream);
+
+Not Supported
+=============
+
+1. A single port with multiple channels supported cannot be used between two
+streams or across stream. For example a port with 4 channels cannot be used
+to handle 2 independent stereo streams even though it's possible in theory
+in SoundWire.
-- 
2.7.4
