From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: AC97 codec mixer control question
Date: Tue, 18 Apr 2006 14:38:14 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0604181432390.9432@tm8103.perex-int.cz>
References: <20060411220808.13530.qmail@web86911.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B9CD71A9
	for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2006 14:38:15 +0200 (MEST)
In-Reply-To: <20060411220808.13530.qmail@web86911.mail.ukl.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adam Ward <adamward2005@yahoo.co.uk>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 11 Apr 2006, Adam Ward wrote:

> AC97_ENUM_DOUBLE(AC97_REC_SEL,8,0,8,std_rec_sel)
> 
> SO, Linphone asks for "Mic" and sets 0x0000, but my
> codec, AK4650, needs 0x0200 to select the mic, which
> actually corresponds to "Video".

AK4650 Record Source register seems to be incompatible with
the original AC97 specification. You have to implement
special code for this codec. You should create a new
AC97_SCAP_AKRECSEL define. Perhaps, other AK codecs are
"broken" in this way as well.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
