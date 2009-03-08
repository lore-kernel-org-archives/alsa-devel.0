From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [RFC/PATCH] pxa2xx_ac97 and gpio reset line
Date: Sun, 8 Mar 2009 19:31:39 +0000
Message-ID: <20090308193138.GB18035@sirena.org.uk>
References: <87iqn6f97x.fsf@free.fr>
	<4C46CDB4-EF69-4B6F-929E-FCBE644A7FA5@sirena.org.uk>
	<87bpsb6dt1.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 184F1103807
	for <alsa-devel@alsa-project.org>; Sun,  8 Mar 2009 20:31:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87bpsb6dt1.fsf@free.fr>
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

On Sun, Mar 08, 2009 at 07:59:38PM +0100, Robert Jarzmik wrote:

> Would you like me to help you with this platform data. This GPIO thing is
> breaking mioa701 GSM chip (not damaging this time :)), so would you like me to
> cook up the platform data passed to pxa2xx-ac97, and amend my patch accordingly

I've not done anything with this.  I wasn't really intending to do the
platform data bit myself, the driver should just default to using the
standard setting when no platform data is supplied.

> PS: passing that platform data is easy, I should have done it right from the

Well, yes.

> start. I can't see how I missed the simple platform_data in pxa2xx_ac97 probe
> function ... grrr... Must be the belgian food I tried.

Note that at present ASoC does not use the platform device for the AC97
controller at all, it just starts talking to the hardware.  That's the
bit I was intending to deal with.
