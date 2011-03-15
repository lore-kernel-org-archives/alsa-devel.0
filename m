From: Magnus Olsson <magnus.olsson@axis.com>
Subject: Re: Dsnoop-plugin buffer sizes
Date: Tue, 15 Mar 2011 10:51:27 +0100
Message-ID: <A612847CFE53224C91B23E3A5B48BAC749EE00FA23@xmail3.se.axis.com>
References: <A612847CFE53224C91B23E3A5B48BAC749EE00F801@xmail3.se.axis.com>
	<alpine.LNX.2.00.1103141107030.4805@eeebox2.perex-int.cz>
	<A612847CFE53224C91B23E3A5B48BAC749EE00F816@xmail3.se.axis.com>
	<alpine.LNX.2.00.1103141143380.4805@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anubis.se.axis.com (anubis.se.axis.com [195.60.68.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 48478103803
	for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2011 10:51:31 +0100 (CET)
In-Reply-To: <alpine.LNX.2.00.1103141143380.4805@eeebox2.perex-int.cz>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Jaroslav Kysela [mailto:perex@perex.cz]
> Sent: den 14 mars 2011 11:53
> To: Magnus Olsson
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] Dsnoop-plugin buffer sizes
> 
> Also, you may try to force the buffer size to 8000 for dsnoop (use
> period_size 2000, periods 4) in your dmix slave configuration, for
> example:
> 
>  	type dmix
>  	slave {
>  		period_size 2000
>  		periods 4
>  	}
> 
> If this works, it's probably a bug in the driver.


Ah, yes, I traced down the issue in the PCM driver. It assumed params_periods()*params_period_bytes() == params_buffer_bytes() without an integer constraint on number of periods. 

Thanks!

> 
>  					Jaroslav
> 
> -----
> Jaroslav Kysela <perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, Red Hat, Inc.
