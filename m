From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: asoc multi-component: almost there!
Date: Wed, 28 Jul 2010 15:07:52 +0100
Message-ID: <1280326072.3085.562.camel@odin>
References: <AANLkTimKhtzu-_Sts3AkVmDhc19tOGg4dqMGzdCro=A7@mail.gmail.com>
	<AANLkTikeAObgZsyRN-kWLERaOpICfpnjaidtOUfQhQwz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id ADAEB24476
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Jul 2010 16:07:55 +0200 (CEST)
Received: by wwe15 with SMTP id 15so937690wwe.20
	for <alsa-devel@alsa-project.org>; Wed, 28 Jul 2010 07:07:55 -0700 (PDT)
In-Reply-To: <AANLkTikeAObgZsyRN-kWLERaOpICfpnjaidtOUfQhQwz@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-07-27 at 16:23 -0500, Timur Tabi wrote:
> Is the machine driver required to run last?  The reason I ask is that
> my DMA driver is currently initialized via arch_initcall().  If I
> change that to module_init(), ASOC fails to register any sound cards.

Oh, that one is my fault. I had tried to optimize part of the probe() a
little and have reverted that change now.

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
