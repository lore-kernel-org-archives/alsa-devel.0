From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: ASoC merge
Date: Tue, 20 Nov 2007 09:59:15 -0500
Message-ID: <9e4733910711200659o84d6eebud65150e542b938ba@mail.gmail.com>
References: <1195550746-6892-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by alsa0.perex.cz (Postfix) with ESMTP id B236F24A22
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 15:59:20 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so2706064wag
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 06:59:16 -0800 (PST)
In-Reply-To: <1195550746-6892-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, liam.girdwood@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/20/07, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> The following patch series merges some of the outstanding changes in the
> linux-2.6-asoc tree.  It updates the core and existing drivers and adds
> some of the new drivers currently in the tree.

In asoc v2 soc-core is changed from being a platform driver into
subsys_initcall(asoc_bus_init); Is this change going in anytime soon?
subsys call is the right way, the alsa core is not a platform device.
This will bring asoc into alignment with i2c which already uses
subsys_initcall.


> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>


-- 
Jon Smirl
jonsmirl@gmail.com
