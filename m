From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] ASoC: cs4270: introduce CS4270_I2C_INCR
Date: Wed, 6 May 2009 10:28:49 -0500
Message-ID: <ed82fe3e0905060828ueaf8576v667abfbad50a36ea@mail.gmail.com>
References: <1241515501-6600-1-git-send-email-daniel@caiaq.de>
	<4A005283.50306@freescale.com>
	<20090505151538.GC24556@buzzloop.caiaq.de>
	<20090505180859.GA3953@sirena.org.uk>
	<20090505231924.GA28090@buzzloop.caiaq.de>
	<20090506084434.GA6573@sirena.org.uk>
	<20090506093936.GB31875@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 7217224736
	for <alsa-devel@alsa-project.org>;
	Wed,  6 May 2009 17:29:00 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so124579qwk.56
	for <alsa-devel@alsa-project.org>; Wed, 06 May 2009 08:28:59 -0700 (PDT)
In-Reply-To: <20090506093936.GB31875@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, May 6, 2009 at 4:39 AM, Daniel Mack <daniel@caiaq.de> wrote:

> Hmm, ok. That makes sense. However, the driver uses the equivalent
> function to read the whole register set, so I wanted to keep it in
> sync.

That's because I could never figure out which API I should use for
this.  I just kept trying variants until something worked.

-- 
Timur Tabi
Linux kernel developer at Freescale
