From: Guy Stalnaker <jstalnak@wisc.edu>
Subject: Issues with HP DV4 laptop sound after Ubuntu Jaunty
	9.04 upgrade
Date: Sat, 02 May 2009 23:57:42 -0500
Message-ID: <49FD2446.7040001@wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from agogare.doit.wisc.edu (agogare.doit.wisc.edu [144.92.197.211])
	by alsa0.perex.cz (Postfix) with ESMTP id C02C6245F8
	for <alsa-devel@alsa-project.org>;
	Sun,  3 May 2009 06:57:52 +0200 (CEST)
Received: from avs-daemon.smtpauth2.wiscmail.wisc.edu by
	smtpauth2.wiscmail.wisc.edu
	(Sun Java(tm) System Messaging Server 7.0-5.01 32bit (built Feb 19
	2009)) id <0KJ100704XSFWZ00@smtpauth2.wiscmail.wisc.edu> for
	alsa-devel@alsa-project.org; Sat, 02 May 2009 23:57:51 -0500 (CDT)
Received: from [173.98.170.102]
	(173-98-170-102.pools.spcsdns.net [173.98.170.102])
	by smtpauth2.wiscmail.wisc.edu
	(Sun Java(tm) System Messaging Server 7.0-5.01 32bit (built Feb 19
	2009))
	with ESMTPSA id <0KJ10071AXSBU500@smtpauth2.wiscmail.wisc.edu> for
	alsa-devel@alsa-project.org; Sat, 02 May 2009 23:57:49 -0500 (CDT)
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

Hello again.

I was able to get my internal speakers working for my HP Pavilion Dv4
laptop by following the advice I found in the alsa-devel archives.  That
advice seems to have worked for quit a few people who found it by a post
I made to the Ubuntu Forums.

But now, after I have upgraded my Ubuntu from version 8.10 (when sound
worked) to version 9.04, sound no longer works correctly.  I have some
detailed information about the sequencing and the specific error.
Attached is an alsa-info.txt output.

Here's what I'm seeing (extracts from dmesg/kernel logs):

Apr 29 15:13:17 Harlindon kernel: [   19.937190] HDA Intel 0000:00:14.2:
PCI INT A -> GSI 16 (level, low) -> IRQ 16
Apr 29 15:13:17 Harlindon kernel: [   19.937270] HDA Intel 0000:00:14.2:
setting latency timer to 64

Apr 30 09:37:09 Harlindon kernel: [   19.941675] HDA Intel 0000:00:14.2:
PCI INT A -> GSI 16 (level, low) -> IRQ 16
Apr 30 09:37:09 Harlindon kernel: [   19.941750] HDA Intel 0000:00:14.2:
setting latency timer to 64

May  1 16:06:01 Harlindon kernel: [   19.852324] HDA Intel 0000:00:14.2:
PCI INT A -> GSI 16 (level, low) -> IRQ 16
May  1 16:06:01 Harlindon kernel: [   19.852398] HDA Intel 0000:00:14.2:
setting latency timer to 64

May  1 16:13:43 Harlindon kernel: [   20.950985] HDA Intel 0000:00:14.2:
PCI INT A -> GSI 16 (level, low) -> IRQ 16
May  1 16:13:43 Harlindon kernel: [   20.951060] HDA Intel 0000:00:14.2:
setting latency timer to 64

Commit Log for Fri May  1 16:41:58 2009 [Upgrade to Ubuntu Jaunty 9.04]

May  1 17:11:05 Harlindon kernel: [   20.318416] hda-intel: unable to
grab IRQ 0, disabling device
May  1 17:11:05 Harlindon kernel: [   20.318517] HDA Intel: probe of
0000:00:14.2 failed with error -16

May  1 17:14:18 Harlindon kernel: [   22.977762] hda-intel: unable to
grab IRQ 0, disabling device
May  1 17:14:18 Harlindon kernel: [   22.977828] HDA Intel: probe of
0000:00:14.2 failed with error -16

May  1 17:18:49 Harlindon kernel: [   21.105013] HDA Intel 0000:00:14.2:
PCI INT A -> GSI 16 (level, low) -> IRQ 16
May  1 17:18:49 Harlindon kernel: [   21.105087] HDA Intel 0000:00:14.2:
setting latency timer to 64

May  1 21:15:14 Harlindon kernel: [   19.776991] HDA Intel 0000:00:14.2:
PCI INT A -> GSI 16 (level, low) -> IRQ 16
May  1 21:15:14 Harlindon kernel: [   19.777893] HDA Intel 0000:00:14.2:
setting latency timer to 64

May  2 09:22:01 Harlindon kernel: [   20.540543] HDA Intel 0000:00:14.2:
PCI INT A -> GSI 16 (level, low) -> IRQ 16
May  2 09:22:01 Harlindon kernel: [   20.540619] HDA Intel 0000:00:14.2:
setting latency timer to 64

May  2 09:26:04 Harlindon kernel: [   19.819578] hda-intel: unable to
grab IRQ 0, disabling device
May  2 09:26:04 Harlindon kernel: [   19.819677] HDA Intel: probe of
0000:00:14.2 failed with error -16

May  2 10:37:28 Harlindon kernel: [   20.175934] hda-intel: unable to
grab IRQ 0, disabling device
May  2 10:37:28 Harlindon kernel: [   20.175999] HDA Intel: probe of
0000:00:14.2 failed with error -16

May  2 13:26:27 Harlindon kernel: [   20.610591] HDA Intel 0000:00:14.2:
PCI INT A -> GSI 16 (level, low) -> IRQ 16
May  2 13:26:27 Harlindon kernel: [   20.610666] HDA Intel 0000:00:14.2:
setting latency timer to 64

May  2 16:57:23 Harlindon kernel: [   19.885497] hda-intel: unable to
grab IRQ 0, disabling device
May  2 16:57:23 Harlindon kernel: [   19.885575] HDA Intel: probe of
0000:00:14.2 failed with error -16

May  2 18:20:18 Harlindon kernel: [   22.605977] hda-intel: unable to
grab IRQ 0, disabling device
May  2 18:20:18 Harlindon kernel: [   22.606042] HDA Intel: probe of
0000:00:14.2 failed with error -16

What is damned peculiar is that is has sometimes worked (as you can see
above).  I can find no pattern however.  I HAVE downloaded an compiled
the latest alsa-driver-snapshot.  That last reboot has the same unable
to grab irq error.

Any suggestions are greatly appreciated.

-- 
Guy Stalnaker, I^2@DOIT, 1210 West Dayton Street, Room 3209 CSS, Madison
WI 53719-1220, jstalnak@wisc.edu, work 608.263.8035, cell 608.235.4718,
fax 608.265.6681, page page-guy@watchdog.doit.wisc.edu
