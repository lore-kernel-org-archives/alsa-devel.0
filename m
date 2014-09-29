From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Dice notification issue between ALSA/FFADO
Date: Tue, 30 Sep 2014 08:29:07 +0900
Message-ID: <5429EB43.7@sakamocchi.jp>
References: <1411919903-10981-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 7AB002606A9
 for <alsa-devel@alsa-project.org>; Tue, 30 Sep 2014 01:29:14 +0200 (CEST)
In-Reply-To: <1411919903-10981-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Dear ALSA and FFADO developers,

My aim of the patchsets is to allow ALSA PCM applications to drive Dice
based devices via ALSA PCM interface. As long as I know, 41 models can
be available newly. You can see the list of supported models in the
end of this message.

I have a theory that kernel drivers should not disturb userspace
drivers. Actually, ALSA FireWire drivers don't disturb userspace
driver (i.e. FFADO), therefore userspace driver can handle device, as
long as ALSA FireWire drivers use no streaming resources.

But Dice has its own notification mechanism. Due to this mechanism, I
cannot apply the theory to ALSA Dice driver. As long as I investigate,
jackd with firewire backend has an issue due to this.

I try to explain the background, and show a workaround. If any
questions, please contact to me.



Short description about Dice notification:
1.Dice driver reserve 4 byte region of address on OHCI 1394 host
controller.
2.Then the driver register the address to device.
3.When status change occurs, typically status of clock changes, the device
  transfer 4 byte message to OHCI 1394 host controller.
4.The driver receive the message via handler.

The notification seems to be used for model-specific operations, too.

This is an actual example of this mechanism (TC Electronic Impact Twin):
...
(Registration)
[ 2482.253649] firewire_ohci 0000:02:00.0: AT spd 2 tl 2a, ffc1 ->
ffc0, ack_pending , Lk req, ffffe0000000 10,2
[ 2482.255067] firewire_ohci 0000:02:00.0: AR spd 2 tl 2a, ffc0 ->
ffc1, ack_complete, Lk resp 8,0
...
(Change clock)
[ 2482.268583] firewire_ohci 0000:02:00.0: AT spd 2 tl 31, ffc1 ->
ffc0, ack_pending , QW req, ffffe0000074 = 0000040c
[ 2482.270024] firewire_ohci 0000:02:00.0: AR spd 2 tl 31, ffc0 ->
ffc1, ack_complete, W resp
...
(Notification)
[ 2482.278385] firewire_ohci 0000:02:00.0: AR spd 2 tl 08, ffc0 ->
ffc1, ack_complete, QW req, 000100000000 = 00000023
...

Dice devices can have one address for this purpose, and Linux FireWire
subsystem allows one handler to handle messages to one address space.
Therefore ALSA Dice driver and userspace driver (i.e. FFADO) must share
the message transferred to the address.

Currently ALSA Dice driver keeps an address space on OHCI 1394 host
controller and handle the message. ALSA Dice driver allows ALSA HeDep
applications to receive the message via ALSA HwDep interface. So far,
this specification causes no problems because there is no devices
which both previous ALSA Dice driver and FFADO support.

But this patchset allows ALSA Dice driver to handle devices which
FFADO also supports. Furthermore, ALSA Dice driver is designed just for
streaming and any functionalities to control device's DSP is expected
in userspace. In these reasons, ALSA Dice driver and FFADO need to be
used in the same time.



As long as I investigate, in FFADO, codes to register an address are
in Dice::Device::lock(). The execution path from FFADO library API is:

Dice::Device::lock()
<-DeviceManager::initStreaming()
  <-libffado: ffado_streaming_init()

When ALSA Dice driver is loaded, this execution path fails because
the device already has an address for notification.

04916443999: Debug (ieee1394service.cpp)[ 730] lockCompareSwap64:
after = 0x000000000100C1FF
04916444035: Warning (dice_avdevice.cpp)[1188] lock: Could not
register ourselves as device owner, unexpected register value:
0xFFC1000100000000
04916444040: Warning (devicemanager.cpp)[ 787] initStreaming: Could
not lock device, skipping device (0x11fac90)!

Fortunately, ffado-dbus-server don't follow this execution path,
thus ALSA Dice driver and ffado-dbus-server/ffado-mixer can be
available in the same time.

But jackd with firewire backend follows this execution path. When
ALSA Dice driver is loaded, jackd outputs this error.

This means that the device to which ALSA Driver registers an address
is skipped from device list which libffado can handle. When users
connect one Dice based device, jackd fails because there are no recognized
devices.

04916444076: Debug (ffado.cpp)[ 198] ffado_streaming_prepare: Preparing...
04916444083: Debug (StreamProcessorManager.cpp)[ 409] prepare:
Preparing...
04916444097: Debug (StreamProcessorManager.cpp)[ 443] prepare: Prepare
Receive processors...
04916444101: Debug (StreamProcessorManager.cpp)[ 457] prepare: Prepare
Transmit processors...
04916444105: Fatal (StreamProcessorManager.cpp)[ 473] prepare: No
stream processors registered, can't do anything useful
04916444109: Fatal (devicemanager.cpp)[ 823] prepareStreaming: Could
not prepare streaming...
04916444112: Fatal (ffado.cpp)[ 201] ffado_streaming_prepare: Could
not prepare the streaming system

When users still use jackd with firewire backend, they need to unload
ALSA Dice driver:
 $ modprobe -r snd-dice

When ALSA Dice driver is detached, it unregister the address in the
device. Then jackd with firewire backend can be available again.



Supported devices:
TC Electronic
	Desktop Konnekt 6
	Konnekt Live
	Impact Twin
	Konnekt 8/24D
	Studio Konnekt 48
PreSonus
	FireStudio 26x26/Mobile/Project/Tube/LightPipe
	StudioLive 1602/1642/2442
	FireStation
Mackie
	Onyx Blackbird
	Onyx i-series (latter models)
Focusrite
	Saffire Pro 14/24/24 DSP/26/40/56
M-Audio
	Profire 610/2626
Alessis
	IO 24/26
	MultiMix 12/16
Weiss
	ADC2
	Vesta
	Mineva
	AFI 1
	TAG DAC 1
	INT 202
	DAC 202
	Flex 5000
DnR
	Axus FireWire I/O card 16x16
Lexicon
	I-ONIX FW 810S
Allen and Heath
	Zed R16
Midas
	Venice F32


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
