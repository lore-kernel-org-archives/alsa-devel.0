From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Adding controls
Date: Sun, 26 Mar 2006 00:05:25 +0000
Message-ID: <1143331525.10201.9.camel@localhost.localdomain>
References: <1142984360.9284.33.camel@localhost.localdomain>
	 <1142985518.4532.193.camel@mindpipe>
	 <1143059773.9254.3.camel@localhost.localdomain>
	 <1143060946.9254.5.camel@localhost.localdomain>
	 <s5hek0tjy2y.wl%tiwai@suse.de>
	 <1143307500.9313.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp1.homechoice.co.uk (sc-outsmtp1.homechoice.co.uk [81.1.65.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id A952E168
	for <alsa-devel@alsa-project.org>; Sun, 26 Mar 2006 01:05:29 +0100 (MET)
In-Reply-To: <1143307500.9313.6.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I think I have found one of the reasons why my code was failing...

This: struct snd_ctl_elem_info

and similar types referred to in the documentation (the how to write a
driver docs) doesn't actually exist...

snd_ctl_elem_info_t does exist as does sndrv_ctl_elem_info 

If I knew how docbook worked I'd post a patch :)



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
