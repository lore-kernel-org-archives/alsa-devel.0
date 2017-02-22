From: Stephen Wilson <Stephen.Wilson85@live.co.uk>
Subject: Custom USB sound card configuration
Date: Wed, 22 Feb 2017 09:19:30 +0000
Message-ID: <AM5P192MB0116424C0F18E01DC3C0E1B0AC500@AM5P192MB0116.EURP192.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from SNT004-OMC2S33.hotmail.com (snt004-omc2s33.hotmail.com
 [65.55.90.108]) by alsa0.perex.cz (Postfix) with ESMTP id 18D19266B22
 for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2017 10:19:45 +0100 (CET)
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,


I'm developing an application using the pjSip library/framework using the ALSA library as the interface to the PCM audio devices.   The audio device is a USB PIC presenting a single sound card with 4 devices (PIC code is still in development so ignore the examples names) - see output of aplay -l below...


When I launch my pjSip application (and the pjSIP test application) only the first device on my sound card is listed - see below....


My thoughts are that I need a custom card configuration file for my sound card so all four devices are present as specific devices but I cannot work out how to do this from the ALSA Project documentation.  I assume I need a new entry in the /usr/share/alsa/cards/aliases.conf file and an equivalent [example].conf file.  What needs to go into both of these files?


Any help would be greatly appreciated...


Thanks

Steve




[root@##########]# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: ALC662 rev1 Analog [ALC662 rev1 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 1: ALC662 rev1 Digital [ALC662 rev1 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

card 1: Example [Harmony USB Headset Example], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: Example [Harmony USB Headset Example], device 1: USB Audio [USB Audio #1]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: Example [Harmony USB Headset Example], device 2: USB Audio [USB Audio #2]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: Example [Harmony USB Headset Example], device 3: USB Audio [USB Audio #3]
  Subdevices: 1/1
  Subdevice #0: subdevice #0



[root@################]# pjsystest-i686-pc-linux-gnu
09:15:12.615 os_core_unix.c !pjlib 2.5.5 for POSIX initialized
09:15:12.621 sip_endpoint.c  .Creating endpoint instance...
09:15:12.623          pjlib  .select() I/O Queue created (0xa20aa00)
09:15:12.623 sip_endpoint.c  .Module "mod-msg-print" registered
09:15:12.623 sip_transport.  .Transport manager created.
09:15:12.624   pjsua_core.c  .PJSUA state changed: NULL --> CREATED
09:15:12.624 sip_endpoint.c  .Module "mod-pjsua-log" registered
09:15:12.624 sip_endpoint.c  .Module "mod-tsx-layer" registered
09:15:12.624 sip_endpoint.c  .Module "mod-stateful-util" registered
09:15:12.624 sip_endpoint.c  .Module "mod-ua" registered
09:15:12.625 sip_endpoint.c  .Module "mod-100rel" registered
09:15:12.625 sip_endpoint.c  .Module "mod-pjsua" registered
09:15:12.625 sip_endpoint.c  .Module "mod-invite" registered
09:15:12.897     alsa_dev.c  ..ALSA driver found 18 devices
09:15:12.897     alsa_dev.c  ..ALSA initialized
09:15:12.898          pjlib  ..select() I/O Queue created (0xa23b4fc)
WARNING: no real random source present!
09:15:12.910 sip_endpoint.c  .Module "mod-evsub" registered
09:15:12.910 sip_endpoint.c  .Module "mod-presence" registered
09:15:12.910 sip_endpoint.c  .Module "mod-mwi" registered
09:15:12.910 sip_endpoint.c  .Module "mod-refer" registered
09:15:12.910 sip_endpoint.c  .Module "mod-pjsua-pres" registered
09:15:12.910 sip_endpoint.c  .Module "mod-pjsua-im" registered
09:15:12.910 sip_endpoint.c  .Module "mod-pjsua-options" registered
09:15:12.910   pjsua_core.c  .1 SIP worker threads created
09:15:12.910   pjsua_core.c  .pjsua version 2.5.5 for Linux-2.6.34.130/i686/glibc-2.12 initialized
09:15:12.910   pjsua_core.c  .PJSUA state changed: CREATED --> INIT
09:15:12.910   pjsua_core.c  PJSUA state changed: INIT --> STARTING
09:15:12.910 sip_endpoint.c  .Module "mod-unsolicited-mwi" registered
09:15:12.911   pjsua_core.c  .PJSUA state changed: STARTING --> RUNNING
M E N U :
---------
0: Tests
  00: Run test wizard
  01: Device Test
  02: Play Tone
  03: Play WAV File1
  04: Play WAV File2
  05: Record Audio
  06: Latency Test
  07: AEC/AES Test

  09: Exit
1: Options
  10: View Devices
  11: View Settings

Enter the menu number: 10
09:15:13.463      systest.c  Running Audio Device List
Audio Device List
Found 18 devices
  0: ALSA [default:CARD=Intel] (0/1)
  1: ALSA [sysdefault:CARD=Intel] (0/1)
  2: ALSA [front:CARD=Intel,DEV=0] (1/1)
  3: ALSA [surround40:CARD=Intel,DEV=0] (1/1)
  4: ALSA [surround51:CARD=Intel,DEV=0] (1/1)
  5: ALSA [surround71:CARD=Intel,DEV=0] (1/1)
  6: ALSA [iec958:CARD=Intel,DEV=0] (0/1)
  7: ALSA [hdmi:CARD=Intel,DEV=0] (0/1)
  8: ALSA [default:CARD=Example] (1/1)
  9: ALSA [sysdefault:CARD=Example] (1/1)
 10: ALSA [front:CARD=Example,DEV=0] (1/1)
 11: ALSA [surround21:CARD=Example,DEV=0] (1/1)
 12: ALSA [surround40:CARD=Example,DEV=0] (1/1)
 13: ALSA [surround41:CARD=Example,DEV=0] (1/1)
 14: ALSA [surround50:CARD=Example,DEV=0] (1/1)
 15: ALSA [surround51:CARD=Example,DEV=0] (1/1)
 16: ALSA [surround71:CARD=Example,DEV=0] (1/1)
 17: ALSA [iec958:CARD=Example,DEV=0] (1/1)
