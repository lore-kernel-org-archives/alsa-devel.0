From: Daniel Mack <daniel@caiaq.de>
Subject: Re: Status of the Tascam US-122mkII???
Date: Sun, 20 Jun 2010 00:41:02 +0200
Message-ID: <20100619224102.GO17833@buzzloop.caiaq.de>
References: <AANLkTimaehZwC-e1pmbQl-pLNb7gVp2Rt5Ujz4BfduR_@mail.gmail.com>
	<20100619174259.GJ17833@buzzloop.caiaq.de>
	<AANLkTilfDBFqGH41TGF0H855CfCm8fOjGMW7lwH1tXi_@mail.gmail.com>
	<20100619180956.GL17833@buzzloop.caiaq.de>
	<AANLkTikfeTzrOttiyI9BqqD3zHI7NXY8ScyXoY8Ruq8N@mail.gmail.com>
	<20100619185753.GN17833@buzzloop.caiaq.de>
	<4C1D149B.7000802@physik.uni-hamburg.de>
	<AANLkTimJ17dGo6K3Gy8_tlhIezFFY0XDRyj53i8tj1pi@mail.gmail.com>
	<4C1D2662.3060106@physik.uni-hamburg.de>
	<AANLkTil_QpNxgpXEaisHx1Xh-DG7Mi9rCtKjtAmcW_KO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 495F924153
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Jun 2010 00:41:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTil_QpNxgpXEaisHx1Xh-DG7Mi9rCtKjtAmcW_KO@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jordan johnston <triplesquarednine@gmail.com>
Cc: Tobias Hansen <Tobias.Hansen@physik.uni-hamburg.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Jun 19, 2010 at 04:45:08PM -0400, jordan johnston wrote:
> So basically, many people have tried to get this working and
> failed????  no one was able to get it working?
> 
> alright, i might setup a spare partition to give this another shot, as
> i don't want to ruin my current setup that is needed every time
> i got out and play music, or jam(like tonight!). My "Linux VST/live
> input looper" must stay fully operational !
> but i will probably take another shot at it. even though! - in the
> end, i bet i am just going to purchase for FFADO "full-support".
> i would buy HDSP, but it's a little pricey for my laptop.
> I just thought that i would try to take advantage of the situation,
> maybe help debug the driver, but if the implementation of the
> us-122mkII is vastly different than what can you do???

Well, you can assume that audio is transported over dedicated
isochronous endpoints. The question is how audio parameters are set up.
And you can find out by tracing the traffic and see what happens when
you start or stop the stream, when you change the sample rate etc.

> It's too bad
> that companies don't put more effort into supporting linux,
> not that i need to tell you that!

The only thing you can do as a customer and end-user is to pay attention
to the state of Linux support of a new piece of hardware before you buy.

Or waste some weekends and help yourself and maybe lots of others ;)

Daniel
