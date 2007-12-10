From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Capturing from Line and Mic simultaneously
Date: Mon, 10 Dec 2007 09:28:01 -0800
Message-ID: <1197307681.4985.39.camel@razman.gruemaster.com>
References: <b6251a620712100820g3cf819l51879e1b3bbe3419@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 4DD4A24474
	for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2007 18:28:05 +0100 (CET)
In-Reply-To: <b6251a620712100820g3cf819l51879e1b3bbe3419@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Christophe Osuna <christophe.osuna@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This really depends on the driver, I would think.  Some drivers are
setup for single input at a time, as the most common usage model is for
voice conferencing.   But i can see where this would be useful from a
recording studio perspective.  The trick would be to have the recording
program enable the correct capture pathways, which can be driver
independent.  It also can be a hardware limitation, like with some sound
chips on the HDA-Intel bus.  Some of them may have multiple paths for
input through pin reassignment, but only 1-2 ADC's. for actual capture.

If you let us know exactly what hardware you have, the developer(s) for
that system may be able to better answer.

Tobin


On Mon, 2007-12-10 at 17:20 +0100, Christophe Osuna wrote:

> Hi,
> 
> I would like to capture sound from the Line and Mic inputs
> simultaneously. The sound chip seems capable to do so: inside
> alsamixer, in the "Capture" tab I can select up to three subdevices,
> and from the "Playback" tab I can set the input source one to "Mic"
> and the input source two to "Line" (and three to whatever).
> 
> When trying to use several output ports at the same time I use four,
> six or eight channels. I tried the same thing for input (i.e. use four
> channels) but that failed. I guess I have to use subdevices but I have
> no idea on how to start working with them.
> 
> Could anyone:
>  * tell me if ALSA is limited to two capture channels, and in that
> case what should be done;
>  * point me to some documentation showing what to do, or give me some
> general hints
> 
> Thanks.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis  


Win98 is called Win98 because 98 bugs have been added since the last version
