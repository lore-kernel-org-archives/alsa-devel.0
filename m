From: Jussi Laako <jussi@sonarnerd.net>
Subject: Re: [PATCH] pcm: add new 32-bit DSD sample format
Date: Fri, 21 Nov 2014 11:11:22 +0200
Message-ID: <546F01BA.8080204@sonarnerd.net>
References: <1410332428-16571-1-git-send-email-gtmkramer@xs4all.nl>	
 <546CF486.7010009@sonarnerd.net> <s5hy4r6xkfu.wl-tiwai@suse.de>
 <1416501288.2996.1.camel@xs4all.nl> <546E3BDA.2040601@sonarnerd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [83.145.240.118])
 by alsa0.perex.cz (Postfix) with ESMTP id A78312661B9
 for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2014 10:11:22 +0100 (CET)
In-Reply-To: <546E3BDA.2040601@sonarnerd.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jurgen Kramer <gtmkramer@xs4all.nl>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I sent out two patches that make the XMOS implementation work correctly 
for me.

While doing the change, I spotted another bug in 
snd_pcm_format_little_endian() where it was claiming the _LE formats to 
be big-endian ones. I fixed this too. Having this bug may have 
accidentally made some software work correctly if they do byte reversal 
based on snd_pcm_format_little_endian() instead of the sample format type...


Best regards,

	- Jussi
