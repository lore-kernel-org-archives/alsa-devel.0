From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 3/4] ASoC: pxa2xx-i2s: remove GPIO pin setup
Date: Tue, 3 Feb 2009 17:09:54 +0000
Message-ID: <20090203170952.GI23827@sirena.org.uk>
References: <1233677983-23710-1-git-send-email-philipp.zabel@gmail.com>
	<1233677983-23710-4-git-send-email-philipp.zabel@gmail.com>
	<20090203163223.GE23827@sirena.org.uk>
	<74d0deb30902030856g5a48ef52ge4e3fb0c24040b2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D5CA103879
	for <alsa-devel@alsa-project.org>; Tue,  3 Feb 2009 18:23:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <74d0deb30902030856g5a48ef52ge4e3fb0c24040b2d@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pHilipp Zabel <philipp.zabel@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 03, 2009 at 05:56:24PM +0100, pHilipp Zabel wrote:

> The affected boards are Corgi, Spitz, Poodle, Magician, AMESOM, H5000,
> Mainstone.
> Of those only Spitz, H5000 and Mainstone are missing I2S setup in
> arch/arm/mach-pxa.
> I'll try to get those patches into the PXA tree and then resend this one.

Feel free to merge this as part of the same series/patch.  I'm fine with
the change, we just need to make sure the machines that need to do the
setup are doing it.  There's not much likelyhood of conflicts with this
so either tree is fine for merging.
