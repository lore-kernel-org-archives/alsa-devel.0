From: "Jordan Breeding" <jordan.breeding@inet.com>
Subject: Questions regarding cs46xx support
Date: Fri, 3 May 2002 12:04:50 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <HAEOIKGLLLDPLCHFOMMOMEBPCAAA.jordan.breeding@inet.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from zeke.inet.com (zeke.inet.com [199.171.211.198])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA02725
	for <alsa-devel@alsa-project.org>; Fri, 3 May 2002 19:07:16 +0200
Received: from tex.inetint.com (tex [172.16.99.35])
	by zeke.inet.com (8.12.1/8.12.1) with ESMTP id g43H70Ha023958
	for <alsa-devel@alsa-project.org>; Fri, 3 May 2002 12:07:03 -0500 (CDT)
Received: from harpo.inetint.com (localhost [127.0.0.1])
	by tex.inetint.com (8.12.1/8.12.1) with ESMTP id g43H6A5a020005
	for <alsa-devel@alsa-project.org>; Fri, 3 May 2002 12:06:13 -0500 (CDT)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
Cc: Jordan Breeding <jordan.breeding@attbi.com>
List-Id: alsa-devel@alsa-project.org

Hello,

  I have a SBLive! currently and love the support in for it in alsa
including the fact that it has multi open on /dev/dsp so that if I run esd
for an app that needs it I can still run xmms in regular oss mode or with
alsa drivers and not worry about the fact that esd is also using /dev/dsp.
I do not like however the actual sound that my SBLive! produces (I never
have) and am thinking of going back to using a Turtle Beach Santa Cruz
(based on the cs46xx).  At one point I got to use one of these cards and was
very impressed with the sound quality in Windows and Linux, but at the time
alsa wasn't available as an in kernel driver (2.5.x) and the oss drivers in
the kernel didn't support multi open on /dev/dsp for the cs46xx, so my
question is do the newest alsa drivers for this card (Santa Cruz - cs46xx)
support multi open through both alsa and oss emulation on /dev/dsp?  Thanks
for any information.  Please Cc: me as I am not on the list.

Jordan Breeding


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
