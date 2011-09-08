From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Remove unused step size from debugfs
 CODEC write function
Date: Thu, 08 Sep 2011 15:19:04 -0700
Message-ID: <1315520347.4126.0.camel@finisterre.wolfsonmicro.main>
References: <1315352411-7108-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<CABS+qY3he3Fqjakx=b8czXvsQozCG3h1ScRLfoNedZg9zYEZkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4B88B24DAC
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Sep 2011 00:19:09 +0200 (CEST)
In-Reply-To: <CABS+qY3he3Fqjakx=b8czXvsQozCG3h1ScRLfoNedZg9zYEZkA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Girdwood, Liam" <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-09-08 at 22:19 +0100, Girdwood, Liam wrote:


> Btw, we should probably remove this from the struct codec_driver if
> there are no other users.

It's used for displaying the register map, it's just write where it's
not needed.
