From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: dsnoop, dshare and dmix plugins
Date: 19 Mar 2003 12:51:51 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1048107111.8198.45.camel@cmn37.Stanford.EDU>
References: <Pine.LNX.4.44.0303191801460.1351-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from cm-mail.stanford.edu (cm-mail.Stanford.EDU [171.64.197.135])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA25674
	for <alsa-devel@alsa-project.org>; Wed, 19 Mar 2003 21:52:33 +0100
In-Reply-To: <Pine.LNX.4.44.0303191801460.1351-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> Sure. First example is for the dmix plugin and ice1712 (10 playback 
> channels - last two are S/PDIF, so this configuration allows sharing of 
> the S/PDIF jack):
> 
> pcm.dmix_spdif {
>         type dmix
>         ipc_key 5678293

Hmm, sorry for my ignorance, but what does this number mean and where
does it come from? (BTW, thanks for the examples!)

-- Fernando




-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
