From: kiran padwal <kiran.padwal21@gmail.com>
Subject: Re: [PATCH] ASoC: ak4642: Make of_device_id array const
Date: Sat, 26 Jul 2014 13:23:35 +0530
Message-ID: <CA+neC=Pj2_L9yBiE2yp0UhL6wodLmJAeri4vc_UTCi=sEw2nLA@mail.gmail.com>
References: <1406203117-2767-1-git-send-email-kiran.padwal21@gmail.com>
 <20140725172126.GA24306@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f54.google.com (mail-oi0-f54.google.com
 [209.85.218.54])
 by alsa0.perex.cz (Postfix) with ESMTP id B37F72625E0
 for <alsa-devel@alsa-project.org>; Sat, 26 Jul 2014 09:53:36 +0200 (CEST)
Received: by mail-oi0-f54.google.com with SMTP id i138so4180512oig.41
 for <alsa-devel@alsa-project.org>; Sat, 26 Jul 2014 00:53:35 -0700 (PDT)
In-Reply-To: <20140725172126.GA24306@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, tiwai@suse.de, linux-kernel@vger.kernel.org, s.hauer@pengutronix.de, Liam Girdwood <lgirdwood@gmail.com>, Li.Xiubo@freescale.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 25, 2014 at 10:51 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Jul 24, 2014 at 05:28:36PM +0530, Kiran Padwal wrote:
>> Make of_device_id array const, because all OF functions handle it as const
>
> ...and reverted because it fails to build.

sorry for that...I miss one thing...I will resubmit the patch.
Thanks.
