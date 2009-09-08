From: Susan Cragin <susancragin@earthlink.net>
Subject: Update to problem with Creative X-fi mixer problems
Date: Tue, 8 Sep 2009 11:52:44 -0400 (GMT-04:00)
Message-ID: <23911658.1252425165056.JavaMail.root@elwamui-lapwing.atl.sa.earthlink.net>
Reply-To: Susan Cragin <susancragin@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from elasmtp-kukur.atl.sa.earthlink.net
	(elasmtp-kukur.atl.sa.earthlink.net [209.86.89.65])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FAF3245B9
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Sep 2009 17:52:46 +0200 (CEST)
Received: from [209.86.224.38] (helo=elwamui-lapwing.atl.sa.earthlink.net)
	by elasmtp-kukur.atl.sa.earthlink.net with esmtpa (Exim 4.67)
	(envelope-from <susancragin@earthlink.net>) id 1Ml2zt-0006GH-9s
	for alsa-devel@alsa-project.org; Tue, 08 Sep 2009 11:52:45 -0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I saw that someone was going to try to get all the mixer controls to work properly. 

I updated and opened alsamixer this morning, and found that both the incoming/recording controls were there!

(I should have quit while I was ahead.)

Then I re-booted and recompiled wine and opened winecfg and found that oss could find the proper mixer but alsa did not. 

(The oss mixer is listed as Creative CA0110-IBG)

ALSA lib pcm_dmix.c:1008:(snd_pcm_dmix_open) unable to open slave
ALSA lib pcm_dsnoop.c:593:(snd_pcm_dsnoop_open) unable to open slave
fixme:mixer:ALSA_MixerInit No master control found on HD-Audio Generic, disabling mixer

susan@ubuntu:~$ alsamixer
No mixer elems found
