From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Reasonable sound hardware parameters?
Date: Tue, 29 May 2007 20:17:51 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0705292011350.7894@tm8103.perex-int.cz>
References: <000401c7a10e$71729fe0$5457dfa0$@de>
	<Pine.LNX.4.61.0705281419030.7894@tm8103.perex-int.cz>
	<001501c7a1d7$68709e00$3951da00$@de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 13A5C243C2
	for <alsa-devel@alsa-project.org>;
	Tue, 29 May 2007 20:17:52 +0200 (CEST)
In-Reply-To: <001501c7a1d7$68709e00$3951da00$@de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lorenz Kolb <alsa-dev@lkmail.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 29 May 2007, Lorenz Kolb wrote:

> On Mon, 28 May 2007 Jaroslav, Kysela wrote:
>  
> > On Mon, 28 May 2007, Lorenz Kolb wrote:
> > > Or did we miss something?
> > 
> > Probably not :-) I was speaking about standard PCI architecture in PC.
> > Your design is quite different. Anyway, I wonder for what purpose you
> > need such embedded platform with Linux? Perhaps, I'm too curious ;-)
> 
> You know what happened to the cat because of curiosity? ;-) I know it is 
> not polite to answer with a question, but why not using Linux in 
> embedded platforms? Linux allows full control over the kernel (ok, as 
> long as one complies to the GPL), it is widely spread and offers an 
> enormous amount of client software and even more it is free (of charge, 
> not of cost). And just have a look at companies like AVM. They do have 
> great success using Linux in the embedded field. Unfortunately a 
> multi-media-box (that's at least the goal) will not be multi without 
> audio ;-)

Yes, I know about Linux flexibility, but I'm curious what's special in 
your hardware platform - or what was the reason to design a new platform 
(you mentioned that main CPU is not very powerful). Several PC based 
platforms exist with Geode or VIA processors which has enough I/Os 
integrated including AC97 sound and PCI slots for further expansion..
Maybe size of final product or a special acceleration?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
