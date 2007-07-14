From: "Ash Willis" <ashwillis@programmer.net>
Subject: Re: [PATCH] Fix request_irq error handling
Date: Sat, 14 Jul 2007 14:22:14 -0500
Message-ID: <20070714192214.A1A101BF28D@ws1-1.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webmail-outgoing.us4.outblaze.com
	(webmail-outgoing.us4.outblaze.com [205.158.62.67])
	by alsa0.perex.cz (Postfix) with ESMTP id 43EF41038A3
	for <alsa-devel@alsa-project.org>;
	Sat, 14 Jul 2007 21:30:53 +0200 (CEST)
Received: from unknown (unknown [192.168.8.90])
	by webmail-outgoing.us4.outblaze.com (Postfix) with QMQP id
	D954D180012E
	for <alsa-devel@alsa-project.org>; Sat, 14 Jul 2007 19:22:14 +0000 (GMT)
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
To: Ash Willis <ashwillis@programmer.net>, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hah, um, ignore me. It seems that my c needs some work ;)
In if(some_expression), I always though it is true if the expression is > 0, not
!= 0. 
If anything, that was a CodingStyle patch because it lets us see exactly what
we're getting from request_irq but I can see that it is totally unnecessary :)

> ----- Original Message -----
> From: "Ash Willis" <ashwillis@programmer.net>
> To: alsa-devel@alsa-project.org
> Subject: [alsa-devel] [PATCH] Fix request_irq error handling
> Date: Sat, 14 Jul 2007 02:29:19 -0500
> 
> 
> request_irq returns 0 on success and a negative code on failure.
> Many ALSA drivers incorrectly check for failure by testing for a
> positive code instead of a negative one.
> 
> Signed-Off-By: Ash Willis <ashwillis@programmer.net>
> 
> 
> --
> We've Got Your Name at http://www.mail.com!
> Get a FREE E-mail Account Today - Choose From 100+ Domains
> << request_irq_error_handling.patch >>
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

>


-- 
We've Got Your Name at http://www.mail.com!
Get a FREE E-mail Account Today - Choose From 100+ Domains
