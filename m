From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [RFC/PATCH] pxa2xx_ac97 and gpio reset line
Date: Sun, 15 Mar 2009 12:52:39 +0000
Message-ID: <9D6BA91B-5FD3-4EE4-ACAD-21C144198AA5@sirena.org.uk>
References: <87iqn6f97x.fsf@free.fr>
	<4C46CDB4-EF69-4B6F-929E-FCBE644A7FA5@sirena.org.uk>
	<87bpsb6dt1.fsf@free.fr> <20090308193138.GB18035@sirena.org.uk>
	<20090308194456.GC18035@sirena.org.uk> <878wn723si.fsf@free.fr>
	<20090314224648.GB6523@sirena.org.uk> <87d4cjghrp.fsf@free.fr>
	<20090315112638.GA7439@sirena.org.uk> <87hc1vezdr.fsf@free.fr>
	(sfid-20090315_123658_187304_71FC41E7)
Mime-Version: 1.0 (iPhone Mail 5H11)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E80B12414F
	for <alsa-devel@alsa-project.org>; Sun, 15 Mar 2009 13:51:54 +0100 (CET)
In-Reply-To: <87hc1vezdr.fsf@free.fr> (sfid-20090315_123658_187304_71FC41E7)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 15 Mar 2009, at 12:36, Robert Jarzmik <robert.jarzmik@free.fr> wrote:

> I don't understand the "anything". What should be done if pdata is  
> passed with
> reset_gpio = 0 then ?
>
> Should this be considered as the default case and transformed into  
> 113 ? That
> sounds a bit buggy, because if someone changes his code to include  
> platform_data
> support, they'll have to init platform_data anyway, and fill in  
> reset_gpio
> field.

Yes, that's what I'm asking for. I don't want to make it mandatory  
because only PXA27x is affected (might be worth naming the field for  
that actually) and the driver will already be implementing a default  
behaviour.

> Should this be handled like a casual gpio (ie. gpio 99) ?

I'm not sure what you mean by a casual GPIO?
