From: stan <ghjeold_i_mwee@cox.net>
Subject: Re: No sound on MacBook 3.1
Date: Wed, 25 Jun 2008 10:05:27 -0700
Message-ID: <48627AD7.4070109@cox.net>
References: <1214384314.21257.12.camel@blackadder.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao105.cox.net (fed1rmmtao105.cox.net [68.230.241.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F45524356
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Jun 2008 19:05:29 +0200 (CEST)
In-Reply-To: <1214384314.21257.12.camel@blackadder.site>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marco Vermeulen <vermeulen.mp@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Marco Vermeulen wrote:
> Hi there,
>
> I hope that someone can help me, as I've tried everything conceivable to
> get sound working on my Macbook 3.1. I've visited many a forum, and
> eventually came across this list. My last hope :)
>
> I purchased a Macbook 3.1 earlier this year. On installing Linux, I
> haven't been able to get any sound going. I've tried several
> distributions: Ubuntu Hardy, Fedora 8/9, and now openSuse. I came across
> a script that uploads local relevant information to a paste bin, so
> here's a link:
> http://pastebin.ca/1055610
>
> Please help, I'm desperate to get this going on my machine!
> Thanks & Regards,
> Marco.
>
>   
It looks like you should have sound.  Alsa is recognizing your card and 
loading the driver.

You could upgrade to alsa 1.0.17.RC2 to see if that helps.
You could try sending parameters to the driver load (3-stack, 6-stack, 
etc.) to see if that helps.

Also try aplay -D plughw:0,0  some.wav to see if there is any sound.

Are you running any sound servers?  They can interfere if the rest of 
the system isn't compatible with them.

Maybe someone else here knows exactly what is wrong.
