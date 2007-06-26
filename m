From: Frank Mandarino <fmandarino@endrelia.com>
Subject: Re: at91 SoC Modifications
Date: Tue, 26 Jun 2007 07:53:42 -0400
Message-ID: <4680FE46.1010105@endrelia.com>
References: <61c0054e0706201421x3725f809g80822d32d78d216e@mail.gmail.com>	
	<61c0054e0706251309lf60afabi86ab192e10a0635@mail.gmail.com>	
	<61c0054e0706251347l6938fed0ra0a8474e1cb73a79@mail.gmail.com>
	<61c0054e0706251451j3ecd30d7oab6636dd5883f6e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tomts31-srv.bellnexxia.net (tomts31.bellnexxia.net
	[209.226.175.105])
	by alsa0.perex.cz (Postfix) with ESMTP id 308AC10381D
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Jun 2007 13:53:46 +0200 (CEST)
Received: from toip38-bus.srvr.bell.ca ([67.69.240.39])
	by tomts31-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20070626115344.TCME6499.tomts31-srv.bellnexxia.net@toip38-bus.srvr.bell.ca>
	for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2007 07:53:44 -0400
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Paul Kavan wrote:
> Well, I have fanned out all 6 SSC lines to the codec now and have them
> configured individually to create the desired effect. However, it is
> still buggy. TF0 now does not activate properly when in capture mode. I
> get the same type of waveform I received when I was using TF0 to attempt
> capture. Nothing seems to work correctly except playback....and only
> when I have TF0 sent to the codec's frame receive and send pins.....
> 
> I want to look through the SoC code to where the SSC is activated/reset
> so I can try to determine what is happening. I know the SSC works well
> with this codec and want to figure out what I need to do to modify the
> code to make it happen with ALSA as well. I hate the idea of going back
> to the drawing board and trying to write my driver so that it uses the
> PDC, but the ALSA SoC is simply not working well enough yet with the
> at91sam9260.
> 
> Does anyone know where I can find this code at?

All of the SSC code is contained in sound/soc/at91/at91-ssc.c in
functions at91_ssc_hw_params() and at91_ssc_shutdown().

../fam
-- 
Frank Mandarino                                fmandarino(a)endrelia.com
Endrelia Technologies Inc.
Toronto, Ontario, Canada
