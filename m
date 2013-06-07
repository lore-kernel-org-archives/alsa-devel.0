From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: sgtl5000: Make device cache only
 when powered off
Date: Fri, 7 Jun 2013 19:12:47 -0300
Message-ID: <CAOMZO5DCHA2wyDbD5tudrURdVqhsq4u3V_bP0hMMp4WbwBhimw@mail.gmail.com>
References: <1370251350-4679-1-git-send-email-broonie@linaro.org>
 <CAOMZO5Bwe49qssZ0-kWtETgrFpA-CoCC7qnCodiWhajUq89jcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f178.google.com (mail-vc0-f178.google.com
 [209.85.220.178])
 by alsa0.perex.cz (Postfix) with ESMTP id A555B2615D1
 for <alsa-devel@alsa-project.org>; Sat,  8 Jun 2013 00:12:48 +0200 (CEST)
Received: by mail-vc0-f178.google.com with SMTP id id13so3142896vcb.9
 for <alsa-devel@alsa-project.org>; Fri, 07 Jun 2013 15:12:47 -0700 (PDT)
In-Reply-To: <CAOMZO5Bwe49qssZ0-kWtETgrFpA-CoCC7qnCodiWhajUq89jcw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Wed, Jun 5, 2013 at 8:04 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Mark,
>
> On Mon, Jun 3, 2013 at 6:22 AM, Mark Brown <broonie@linaro.org> wrote:
>> When the regulators have been disabled mark the device as cache only so
>> that we don't try to interact with the hardware.
>>
>> Signed-off-by: Mark Brown <broonie@linaro.org>
>
> I tried to test your patch, but noticed that even without your patch
> sgtl5000 fails to probe in linux-next 20130605.

Thanks, I managed to test your patch now and it works fine. I needed
to turn on the codec clock sooner in the
arch/arm/mach-imx/mach-imx6q.c.

Regards,

Fabio Estevam
