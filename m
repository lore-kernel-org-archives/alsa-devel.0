From: o-takashi@sakamocchi.jp
Subject: [PATCH 0/8] [RFC] new driver for Echo Audio's Fireworks based devices
Date: Sun,  2 Jun 2013 00:55:50 +0900
Message-ID: <1370102158-24389-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: perex@perex.cz, clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

This driver module is originally developed by Clemens Ladish 2010. But it
includes duplicate codes which current snd-firewire-lib has and lack of
automatical sampling rate/the number of channels arrangement.
http://git.alsa-project.org/?p=alsa-kprivate.git;a=shortlog;h=refs/heads/fireworks

This driver module is based on snd-firewire-lib with my previous patches.

[PATCH v2 0/3] snd-firewire-lib: add handling CMP output connection
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-April/061607.html

[PATCH v2 0/4] snd-firewire-lib: add handling AMDTP receive stream
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-April/061611.html

[PATCH 0/2] snd-firewire-lib: add MIDI stream support
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-June/062610.html

Currently this driver module support just PCM/MIDI kernel streaming via ALSA interfaces.
So there are some issues about this driver.
1.whether adding each PCM devices for analog and digital interface
2.where the codes for device control like volume, routing and etc are
3.card definition files for ALSA applications like PulseAudio

I hope this driver module promote developers to discuss about how to implement
Firewire devices which has many channels and options.

Takashi Sakamoto (8):
  add main file of driver module
  add device specific command
  add control interfaces
  add handling AMDTP stream
  add MIDI interface
  add PCM interface
  add proc interface
  modify Makefile and Kconfig to build this module

 sound/firewire/Kconfig                       |   16 +
 sound/firewire/Makefile                      |    2 +
 sound/firewire/fireworks/Makefile            |    2 +
 sound/firewire/fireworks/fireworks.c         |  488 +++++++++++++++++++++++
 sound/firewire/fireworks/fireworks.h         |  241 ++++++++++++
 sound/firewire/fireworks/fireworks_command.c |  535 +++++++++++++++++++++++++
 sound/firewire/fireworks/fireworks_control.c |  537 ++++++++++++++++++++++++++
 sound/firewire/fireworks/fireworks_midi.c    |  236 +++++++++++
 sound/firewire/fireworks/fireworks_pcm.c     |  530 +++++++++++++++++++++++++
 sound/firewire/fireworks/fireworks_proc.c    |  183 +++++++++
 sound/firewire/fireworks/fireworks_stream.c  |  107 +++++
 11 files changed, 2877 insertions(+)
 create mode 100644 sound/firewire/fireworks/Makefile
 create mode 100644 sound/firewire/fireworks/fireworks.c
 create mode 100644 sound/firewire/fireworks/fireworks.h
 create mode 100644 sound/firewire/fireworks/fireworks_command.c
 create mode 100644 sound/firewire/fireworks/fireworks_control.c
 create mode 100644 sound/firewire/fireworks/fireworks_midi.c
 create mode 100644 sound/firewire/fireworks/fireworks_pcm.c
 create mode 100644 sound/firewire/fireworks/fireworks_proc.c
 create mode 100644 sound/firewire/fireworks/fireworks_stream.c

-- 
1.7.10.4


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite
It's a free troubleshooting tool designed for production
Get down to code-level detail for bottlenecks, with <2% overhead.
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap2
