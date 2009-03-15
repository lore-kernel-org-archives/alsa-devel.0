From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [RFC/PATCH] pxa2xx_ac97 and gpio reset line
Date: Sun, 15 Mar 2009 13:36:48 +0100
Message-ID: <87hc1vezdr.fsf@free.fr>
References: <87iqn6f97x.fsf@free.fr>
	<4C46CDB4-EF69-4B6F-929E-FCBE644A7FA5@sirena.org.uk>
	<87bpsb6dt1.fsf@free.fr> <20090308193138.GB18035@sirena.org.uk>
	<20090308194456.GC18035@sirena.org.uk> <878wn723si.fsf@free.fr>
	<20090314224648.GB6523@sirena.org.uk> <87d4cjghrp.fsf@free.fr>
	<20090315112638.GA7439@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C4A02438E
	for <alsa-devel@alsa-project.org>; Sun, 15 Mar 2009 13:36:55 +0100 (CET)
In-Reply-To: <20090315112638.GA7439@sirena.org.uk> (Mark Brown's message of
	"Sun\, 15 Mar 2009 11\:26\:40 +0000")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@sirena.org.uk> writes:

> Could you change this to provide an explicit way of specifying that (eg,
> with -1 as the GPIO)?
Sure.

>  There are other things we might want platform data for in future - passing
> data to the AC97 codec, for example - so we can't rely on people not
> specifying platform data for anything.
I don't understand the "anything". What should be done if pdata is passed with
reset_gpio = 0 then ?

Should this be considered as the default case and transformed into 113 ? That
sounds a bit buggy, because if someone changes his code to include platform_data
support, they'll have to init platform_data anyway, and fill in reset_gpio
field.

Should this be handled like a casual gpio (ie. gpio 99) ?


--
Robert
