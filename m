From: gt bradley <gt.bradley@gmail.com>
Subject: PS3 - Surround sound on SPDIF set-up
Date: Mon, 02 Jul 2007 19:17:35 -0700
Message-ID: <4689B1BF.2050709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C3F710383F
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Jul 2007 04:13:41 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so2470371wag
	for <alsa-devel@alsa-project.org>; Mon, 02 Jul 2007 19:13:40 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
I've been beating my had against this for several weeks now.  (started
with fedora 6, tried adding in the plugings etc (version 1.0.12) -- also
tried upgrading to the current 1.0.14 version, without success (couldn't
produce surround-sound on teh spdif output).  I have now switched to
fedorea 7 and was able to have rythmbox play surround sound via spdif,
but have since lost that ability.  (but I'm convinced the hardware and
low-level drivers support it).  In order to limit the number of moving
parts, I have reduced to just trying to get speaker-test to play on all
6 speakers.

from pirut &
I have alsa-lib 1.0.14-0.4.rc3.fc7.ppc(64) and
alsa-utils 1.0.14-0.7.rc2.fc7.ppc

The default install has no asound.conf file.  (attempts to create a
"better" one didn't improve the situation).

I do not see a file matching the ps3 device in etc/alsa/cards nor
etc/alsa/pcm, but I have not found any documentation on adding entries
to the above directories.


[root@ps3 pcm0p]# cat /proc/asound/card0/pcm0p/info
card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: SPDIF
name: SPDIF
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1


[root@ps3 ~]# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: PS3 [PS3], device 0: SPDIF [SPDIF]
 Subdevices: 1/1
 Subdevice #0: subdevice #0
[root@ps3 ~]# aplay -L
null
   Discard all samples (playback) or generate zero samples (capture)
[root@ps3 ~]# amixer
[root@ps3 ~]# amixer scontrols
[root@ps3 ~]# speaker-test -c 6

speaker-test 1.0.14rc2

Playback device is default
Stream parameters are 48000Hz, S16_BE, 6 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 4096 to 8192
Period size range from 256 to 256
Using max buffer size 8192
Periods = 4
was set period_size = 256
was set buffer_size = 8192
 0 - Front Left
 4 - Center
 1 - Front Right
 3 - Rear Right
 2 - Rear Left
 5 - LFE
Time per period = 17.821324

* above test only produces sound on channels 0 & 1.

xmms produces no sound and emits the following:
** WARNING **: alsa_setup_mixer(): Failed to find mixer element: PCM

Is it possible to get some help/pointers in the right direction?
thanks
GT*
*
