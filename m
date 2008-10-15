From: Manuel Naranjo <manuel@aircable.net>
Subject: Re: Possible regression on Sigmatel 9205
Date: Wed, 15 Oct 2008 09:30:19 -0300
Message-ID: <48F5E25B.5000609@aircable.net>
References: <48F4AD76.8010409@aircable.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by alsa0.perex.cz (Postfix) with ESMTP id 66FC5103805
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Oct 2008 14:30:47 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id 30so1174417ugs.24
	for <alsa-devel@alsa-project.org>; Wed, 15 Oct 2008 05:30:29 -0700 (PDT)
In-Reply-To: <48F4AD76.8010409@aircable.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> Hello everyone,
>
> Sorry to interrupt you all, but I had been trying to get the digital mic
> of my Dell Inspiron 1521 for the last 5 days without any sucess.
> .....
> Thanks,
> Manuel
Hello again,

In my quest to discover what the hell is going on I got the STAC9205 
datasheet from Integrated Device Technology (this guys bought the 
techology from sigmatel).

I'm starting to get how the device works, but I have a question, is 
there any special reason why ADC1 MUX isn't been routed? 
(stac9205_mux_nids doesn't show it). As far as I get if you don't route 
this piece then you don't get a route for the INPORT1 MUX.

Anyway, I'll keep reading too see if I can get how this thing works.

Cheers,
Manuel
