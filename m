From: Peter von Konigsmark <petervk@tpg.com.au>
Subject: ALSA on Alienware M17x
Date: Sun, 06 Dec 2009 12:44:11 +1100
Message-ID: <4B1B0C6B.9080803@tpg.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail13.tpgi.com.au (mail13.tpgi.com.au [203.12.160.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 51BE72434E
	for <alsa-devel@alsa-project.org>; Sun,  6 Dec 2009 02:44:17 +0100 (CET)
References: s5h1vmqski0.wl%tiwai@suse.de
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, adam@randalflagg.net
List-Id: alsa-devel@alsa-project.org

Hi Adam,

I've got an Alienware M17X running Ubuntu 9.10 I've been having trouble 
getting sound working too, although its now running fine.

I added the following lines to alsa-base.conf:
options snd-hda-intel model=intel enable=1 index=0
options snd-hda-intel enable_msi=1
alias snd-card-0 snd-hda-intel
alias sound-slot-0 snd-hda-intel

As you said, model=intel got the sound coming through the speakers, but 
not the headphone.  For me sound doesn't come through the first 
headphone jack, but it does for the second.  Have you tried that?

Hope this helps.

Cheers,
Pete
