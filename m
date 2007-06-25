From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: at91 SoC Modifications
Date: Mon, 25 Jun 2007 23:43:17 +0100
Message-ID: <1182811398.3079.13.camel@localhost.localdomain>
References: <61c0054e0706201421x3725f809g80822d32d78d216e@mail.gmail.com>
	<61c0054e0706251309lf60afabi86ab192e10a0635@mail.gmail.com>
	<61c0054e0706251347l6938fed0ra0a8474e1cb73a79@mail.gmail.com>
	<61c0054e0706251451j3ecd30d7oab6636dd5883f6e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C7DD243C6
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Jun 2007 00:43:19 +0200 (CEST)
In-Reply-To: <61c0054e0706251451j3ecd30d7oab6636dd5883f6e9@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Kavan <pkavan@gmail.com>
Cc: alsa-devel@alsa-project.org, Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2007-06-25 at 16:51 -0500, Paul Kavan wrote:

> I want to look through the SoC code to where the SSC is
> activated/reset so I can try to determine what is happening. I know
> the SSC works well with this codec and want to figure out what I need
> to do to modify the code to make it happen with ALSA as well. I hate
> the idea of going back to the drawing board and trying to write my
> driver so that it uses the PDC, but the ALSA SoC is simply not working
> well enough yet with the at91sam9260. 

Have you compared the difference between you polling driver SSC + codec
settings to the SoC driver after trigger() ?

Any differences may indicate a reason for capture not working.

Also, please make sure that there is only 1 master driving each BCLK/LRC
and that it's input clock source is running. Another thing to check is
that SSC capture is set up to run async to SSC playback.

Liam 
