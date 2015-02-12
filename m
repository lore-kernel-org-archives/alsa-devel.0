From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Status of ALSA FireWire stack as of Linux 3.19
Date: Thu, 12 Feb 2015 23:20:03 +0900
Message-ID: <54DCB693.7010608@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 055DC2652AD
 for <alsa-devel@alsa-project.org>; Thu, 12 Feb 2015 15:20:07 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "ffado-devel@lists.sf.net" <ffado-devel@lists.sf.net>
List-Id: alsa-devel@alsa-project.org

Dear all,

I'm just a developer, not a maintainer of this stack, but often receive
personal messages from users. I think it helpful to explain about its
status and known issues here, as of Linux 3.19.

== Impovements in 3.19 release
 * ALSA FireWire stack gain a thlottle for MIDI data rate. No devices
   can disorder due to MIDI buffer overflow.

http://mailman.alsa-project.org/pipermail/alsa-devel/2014-November/084652.html
 * ALSA Dice driver becomes to handle more models with 176.4/192.0 kHz
   support and both of playback/capture for PCM/MIDI substreams.
 * ALSA firewire-speakers driver was obsoleted by ALSA OXFW driver to
   handles more models based on OXFW 970/971.
 * As a result, ALSA supports approximately 140 FireWire models in
   comparison to Linux 3.15.


== Model dependent issues
There're some reports about model dependent issues.

 * PreSonus FP10 (former known as FirePod)
   * When ALSA BeBoB driver re-establishes connections, this model
     causes hung-up, then reset automatically. The cause is unknown.

 * Terratek PHASE 88 Rack FW
   * https://github.com/takaswie/snd-firewire-improve/issues/8
   * According to a reporter, when ALSA BeBoB driver establishes
     connections according to CMP, this model transfers no packets. The
     cause is unknown.

 * Behringer XENIX UFX 1604
   * http://sourceforge.net/p/ffado/mailman/message/32846563/
   * When ALSA BeBoB driver communicates, this model sometimes misses to
     transfer responses. The cause is unknown but I guess that this
     model expects vendor-specific command.

 * Echo AudioFire 2
   *
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-August/080379.html
   * At least, firmware version 5.7.3 for this model has a quirk about
     AMDTP processing. It's not compliant to this protocol. Even if
     ALSA Fireworks driver communicates successfully, ALSA FireWire
     stack detects protocol error.

 * Weiss engineering DAC 202
   * According to a reporter, when ALSA Dice driver probes this model
     it's trials are ETIMEDOUT at setting sampling rate. The cause is
     unknown.


== Stack and driver issues
There're still some issues about ALSA FireWire stack and drivers. Most
of them are written in my report:
  https://github.com/takaswie/alsa-firewire-report
  * 9.2 A lack of arrangement for severe latency
  * 9.3 A lack of delay for timestamp processing
  * 9.4 A lack of PCM configuration for virtual surround nodes
  * 9.6 A lack of control elements for ALSA control interface
  * 9.7 A lack of packet sorting
  * 9.9 Various results at bus reset
  * 9.10 A lack of synchronizing several devices on the same bus

  * Sometimes kernel oops at disconnecting devices during streaming.
   * I guess three contexts have somewhat race condition:
     * Application process with snd_pcm_prepare()
     * Isochronous context
     * .remove callback by OHCI 1394 host controller driver


== The other issues
 * PulseAudio 6,0 (not released yet) gain multichannel profiles.
     http://www.freedesktop.org/wiki/Software/PulseAudio/Notes/6.0/
   ALSA FireWire sound devices can be available, while in most case the
   display name is the name of OHCI 3194 host controller.
     https://bugs.launchpad.net/ubuntu/+source/pulseaudio/+bug/1381475
   I've posted RFC patch to pulseaudio-discuss but I think it better to
   touch hardware database which systemd produces.

http://lists.freedesktop.org/archives/pulseaudio-discuss/2015-January/022945.html


== My plan for 3.21 release
 * Some userspace library is under development for developers of mixer
   application.
   * libhinawa

http://mailman.alsa-project.org/pipermail/alsa-devel/2015-January/086969.html
   * alsa-gir
     https://github.com/takaswie/alsa-gir

 * An offload of control functionality from ALSA OXFW driver to
   userspace
   * Currently ALSA OXFW driver includes control functionality in
     kernel side, while this can be implemented in userspace. This
     functionaliy utilizes certailn commands which the other drivers
     can use for the same purpose.
   * Need to discuss about it, later.

 * ALSA BeBoB driver improvement
   * ALSA BeBoB driver's bootup command for M-Audio models depends on
     little-endiannness machine. I need more time to prepare for
     big-endianness machine to test my patch for this issue.
   * Some models expect BridgeCo.-specific command to change sampling
     rate. Currently ALSA BeBoB driver uses commands in AV/C general
     specification. Let's start to replace these comands.


Regards

Takashi Sakamoto
