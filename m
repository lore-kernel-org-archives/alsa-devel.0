From: robert.devanna@nospammail.net
Subject: After kernel upgrade to v ~~> 4.1.0, no audio output
 unless UNPLUG/RE-PLUGIN of audio jack on card; OK with earlier kernels
Date: Sun, 05 Jul 2015 13:39:08 -0700
Message-ID: <1436128748.1442900.315748449.28688C30@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 9F32E260462
 for <alsa-devel@alsa-project.org>; Sun,  5 Jul 2015 22:39:09 +0200 (CEST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id 35738202F9
 for <alsa-devel@alsa-project.org>; Sun,  5 Jul 2015 16:39:09 -0400 (EDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I run Opensuse 13.2/64.

My audio system has been / is ALSA, not PulseAudio.

I have installed

	rpm -qa | grep -i alsa
		alsa-utils-1.0.29-143.1.x86_64
		alsa-plugins-jack-1.0.29-99.1.x86_64
		alsa-firmware-1.0.29-33.1.noarch
		alsa-devel-1.0.29-218.1.x86_64
		alsa-plugins-1.0.29-99.1.x86_64
		alsa-1.0.29-218.1.x86_64
		alsa-oss-1.0.28-51.1.x86_64
		alsa-docs-1.0.29-218.1.noarch

It's run fine for ages.  In the past week -- after a bunch of zypper (distro packages) upgrades, and no I don't know which one specifically -- I now have an audio problem.

When I boot my machine there's no audio output.

Every alsa/sound diagnostic I ran said everything's OK.

Took me awhile to figure out that simply UNPLUGGING the audio jack from the mobo socket, then replugging it in fixes the audio -- immediately.

Chatting in #irc, suggestion was to check kernel version dependency.

I'm currently on latest stable kernel 4.1.X.

	uname -rm
		4.1.1-1.ga46abf6-desktop x86_64

I am absolutely sure that this was NOT a problem in the 4.0.X kernel branch.
I am pretty-darn-sure that this was NOT a problem in earlier 4.1.X branch.

Unfortunately, I only had access to

	4.1.1-1.1.ga46abf6
	4.1.0-3.g5ee367d

and

	3.16.7-21.1.x86_64

no longer any earlier 4.1.X or 4.0.X kernels.

Testing each of those

	4.1.1-1.1.ga46abf6  --> FAILs
	4.1.0-3.g5ee367d    --> FAILs
	3.16.7-21.1.x86_64  --> WORKs

so at least from 3.16.7 -> 4.1.0 there's a kernel dependency.  Again, I'm pretty certain that this was NOT a problem with earlier 4.1.X and 4.0.X kernels; just can't prove it.

As instructed in IRC, I DL'd and exec'd the 'alsa-info.sh' script.

I ran the script in 2 cases:

	[1] boot to console, kernel 4.1.1-1.1.ga46abf6, no audio output
	[2] boot to console, kernel 4.1.1-1.1.ga46abf6, unplug & replug, OK audio output

First, the DIFF between the two shows there IS a change on UNPLUG/REPLUG of the jack,

DIFF:
------------------------------------------
--- alsa-info.txt.BEFORE	2015-07-05 12:32:44.973554471 -0700
+++ alsa-info.txt.AFTER	2015-07-05 12:34:01.935900433 -0700
@@ -3,7 +3,7 @@
 !!ALSA Information Script v 0.4.64
 !!################################
 
-!!Script ran on: Sun Jul  5 19:32:43 UTC 2015
+!!Script ran on: Sun Jul  5 19:34:00 UTC 2015
 
 
 !!Linux Distribution
@@ -332,7 +332,7 @@
   Pin-ctls: 0x40: OUT
   Unsolicited: tag=01, enabled=1
   Power states:  D0 D1 D2 D3
-  Power: setting=D3, actual=D3
+  Power: setting=D0, actual=D0
   Connection: 1
      0x16
 Node 0x1d [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
@@ -602,7 +602,7 @@
 crw-rw---- 1 root audio 116,  6 Jul  5 12:31 /dev/snd/hwC0D0
 crw-rw---- 1 root audio 116, 10 Jul  5 12:31 /dev/snd/hwC2D0
 crw-rw---- 1 root audio 116,  4 Jul  5 12:31 /dev/snd/pcmC0D0c
-crw-rw---- 1 root audio 116,  3 Jul  5 12:32 /dev/snd/pcmC0D0p
+crw-rw---- 1 root audio 116,  3 Jul  5 12:33 /dev/snd/pcmC0D0p
 crw-rw---- 1 root audio 116,  5 Jul  5 12:31 /dev/snd/pcmC0D3p
 crw-rw---- 1 root audio 116, 12 Jul  5 12:31 /dev/snd/pcmC1D0c
 crw-rw---- 1 root audio 116,  8 Jul  5 12:31 /dev/snd/pcmC2D3p
------------------------------------------

Since the output's too big for the list, apparently, I pastebin'd the full script output 

	[1] -> http://pastebin.com/jUyTRrFG
	[2] -> http://pastebin.com/4V8YCguV

- Rob
