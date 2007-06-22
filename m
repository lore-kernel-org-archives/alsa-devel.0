From: Frank Mandarino <fmandarino@endrelia.com>
Subject: Re: at91 SoC Modifications
Date: Fri, 22 Jun 2007 15:00:44 -0400
Message-ID: <467C1C5C.4030700@endrelia.com>
References: <61c0054e0706201421x3725f809g80822d32d78d216e@mail.gmail.com>	
	<61c0054e0706210747gc83f1dx2a6ee8bc5cf346f9@mail.gmail.com>	
	<61c0054e0706220853x5502066ck8765365df9b3abf0@mail.gmail.com>	
	<467BFD95.3080707@endrelia.com>
	<61c0054e0706221023j2801c971ya370e8ff79621f5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tomts33-srv.bellnexxia.net (tomts33.bellnexxia.net
	[209.226.175.107])
	by alsa0.perex.cz (Postfix) with ESMTP id AF6B0243A3
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Jun 2007 21:00:47 +0200 (CEST)
Received: from toip37-bus.srvr.bell.ca ([67.69.240.38])
	by tomts33-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20070622190045.MBFS23566.tomts33-srv.bellnexxia.net@toip37-bus.srvr.bell.ca>
	for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2007 15:00:45 -0400
In-Reply-To: <61c0054e0706221023j2801c971ya370e8ff79621f5e@mail.gmail.com>
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
> 
> 
>     Perhaps it would be useful to see a diagram of the connections between
>     the SSC and codec on your board, including directions. 
> 
> 
> Attached is a quick diagram. As far as the wiring, they only connect
> where you see a node connection....did not have a real circuit program
> handy. Let me know if you have questions on the diagram. I tried to make
> it as clear as possible.
> 
> I have the bitclocks and codec master clock tied together. Also, I have
> the frames tied together.

The diagram is clear except for the signal directions.  I assume that
all signals are outputs from SSC to codec except for RD0 - PCMT.

Could you please provide the settings that you are currently working with?

In particular, I would like to see how RFMR.FSOS is set.  If TF0 is
outputting the frame sync and tied to RF0, then you probably want RF0
configured as an input (RFMR.FSOS = None).

And if RF0 and RK0 are receiving signals on their GPIO lines, you do
need to initialize the GPIO registers in your machine driver.

../fam
-- 
Frank Mandarino                                fmandarino(a)endrelia.com
Endrelia Technologies Inc.
Toronto, Ontario, Canada
