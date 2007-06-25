From: "Paul Kavan" <pkavan@gmail.com>
Subject: Re: at91 SoC Modifications
Date: Mon, 25 Jun 2007 16:51:08 -0500
Message-ID: <61c0054e0706251451j3ecd30d7oab6636dd5883f6e9@mail.gmail.com>
References: <61c0054e0706201421x3725f809g80822d32d78d216e@mail.gmail.com>
	<61c0054e0706251309lf60afabi86ab192e10a0635@mail.gmail.com>
	<61c0054e0706251347l6938fed0ra0a8474e1cb73a79@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.184])
	by alsa0.perex.cz (Postfix) with ESMTP id DE403243C2
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Jun 2007 23:51:08 +0200 (CEST)
Received: by mu-out-0910.google.com with SMTP id w8so1775381mue
	for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2007 14:51:08 -0700 (PDT)
In-Reply-To: <61c0054e0706251347l6938fed0ra0a8474e1cb73a79@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Frank Mandarino <fmandarino@endrelia.com>, Liam Girdwood <lg@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Well, I have fanned out all 6 SSC lines to the codec now and have them
configured individually to create the desired effect. However, it is still
buggy. TF0 now does not activate properly when in capture mode. I get the
same type of waveform I received when I was using TF0 to attempt capture.
Nothing seems to work correctly except playback....and only when I have TF0
sent to the codec's frame receive and send pins.....

I want to look through the SoC code to where the SSC is activated/reset so I
can try to determine what is happening. I know the SSC works well with this
codec and want to figure out what I need to do to modify the code to make it
happen with ALSA as well. I hate the idea of going back to the drawing board
and trying to write my driver so that it uses the PDC, but the ALSA SoC is
simply not working well enough yet with the at91sam9260.

Does anyone know where I can find this code at?

Thanks.

Paul

-- 
***************************************
Paul David Kavan
Project Engineer
GRH Electronics, Inc.
402-734-4900
pkavan@gmail.com
***************************************
