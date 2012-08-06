From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: imx-ssi: Fix mono playback
Date: Mon, 6 Aug 2012 16:58:38 -0300
Message-ID: <CAOMZO5B15kcUziVCMBctGdFmx6xkTqby1-cE+arVUJSXosDU-A@mail.gmail.com>
References: <1344281785-22478-1-git-send-email-fabio.estevam@freescale.com>
 <20120806195438.GD16199@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 933C3265DDB
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2012 21:28:53 +0200 (CEST)
Received: by obbeh20 with SMTP id eh20so5760850obb.38
 for <alsa-devel@alsa-project.org>; Mon, 06 Aug 2012 12:58:38 -0700 (PDT)
In-Reply-To: <20120806195438.GD16199@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, kernel@pengutronix.de, gcembed@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 6, 2012 at 4:54 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Aug 06, 2012 at 04:36:25PM -0300, Fabio Estevam wrote:
>> Currently mono playback is played on a faster rate.
>>
>> Adjust channels_min to 2 channels in order to play it back correctly.
>
> This doesn't actually fix mono playback so much as remove support for
> it...

Ok, understood.

Sascha,

Do you know if mono playback used to work previously in imx-ssi?

Regards,

Fabio Estevam
