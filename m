From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: More CS4630, secondary CODEC output.
Date: Thu, 01 Aug 2002 11:39:37 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D4901D9.7040409@cucumelo.org>
References: <3D41D4DC.60004@cucumelo.org> <s5h1y9ic3xs.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from cucumelo.org (as1-4-7.bn.g.bonet.se [194.236.61.89])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id MAA04205
	for <alsa-devel@alsa-project.org>; Thu, 1 Aug 2002 12:29:40 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
>
>
>I merged your codes into the cvs.
>The codes are almost identical except for small bugfixes,
>re-indentation, and replacement of debug printing.
>
-:)

>
>To be sure, the old dsp image is still chosen unless
>CONFIG_SND_CS46XX_NEW_DSP is set to yes.
>For compiling the new dsp image, please remove the comments in
>alsa-driver/pci/cs46xx/Makefile.
>
With the new PCM multi channel support, I believe  there no way
to have the support for the old image,  to many changes in cs46xx_lib.c now
hardly depends on the new stuff.
So if we want to still support the old code i think the only way is to 
create
a new directory  alsa-driver/pci/cs46xx_old/_new, having to independent
cs46xx drivers.
But I hope that in some near future we can discard the old cs46xx.
Of course that we must be sure it work at least so good as before with all
known CS46xx soundcards before discarding anything.

>Please send patches againt cvs if you modify the driver more, so that
>I can commit it soon.
>
Well, i got some more work to do. I will try fixup my new code changes 
so it follows
the coding-style used by ALSA, and then become mergable with current CVS.
(and you dont have to do all thoose indentation fixes again)

Regards

/Benny



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
