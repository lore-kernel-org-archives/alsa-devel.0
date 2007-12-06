From: Andy Shevchenko <andy@smile.org.ua>
Subject: Re: [PATCH] Initial support of the Mitac 8252D
	(based	on ALC883)
Date: Thu, 6 Dec 2007 16:29:58 +0200
Message-ID: <20071206142958.GC24527@serv.smile.org.ua>
References: <20071206094612.GB24527@serv.smile.org.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from serv.smile.org.ua (serv.smile.org.ua [193.178.237.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 1EF47103854
	for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2007 15:48:37 +0100 (CET)
Resent-Message-ID: <20071206144832.GD24527@serv.smile.org.ua>
Resent-To: alsa-devel@alsa-project.org
Content-Disposition: inline
In-Reply-To: <20071206094612.GB24527@serv.smile.org.ua>
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

Hi Andy Shevchenko!

 On Thu, Dec 06, 2007 at 11:46:12AM +0200, Andy Shevchenko wrote next:

> The attached patch adds initial support of the Mitac 8252D
> (http://www.mitac-mtc.com.tw/English/products/8252Dspec.htm).
> 
> Working:
>  - Front speakers (volume + mute)
>  - Center/LFE speakers (volume + mute)
>  - HP out (with Front Volume)
>  - HP individual mute switch
>  - HP Jack sense
>  - Front Mic and its volume
> 
> Not tested:
>  - external mic and its volume
> 
> Not working while now:
>  - Mic Jack sense
> 
> Questionable:
>  - is Mic have Jack sense?
>  - one or two Mic volume controls?
>  - CD/Line-in: presense in the mixer

Additional info here.

All jacks are connected to the one Jack sense input pin via different
impedances (1:2:4 scale). However p.50 of the datasheet says 'The ALC883
does not support hardware impedance detect.'
Due to above the Mic and S/PDIF sense couldn't be evaluated.

Also, the laptop has S/PDIF jack. And specifications are included the 5.1
outputs.

-- 
With best regards,
Andy Shevchenko.      mailto: andy@smile.org.ua
