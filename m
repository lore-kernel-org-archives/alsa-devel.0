From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v3 03/11] ASoC: fsl_ssi: Refine all comments
Date: Fri, 15 Dec 2017 22:10:58 -0800
Message-ID: <CAGoOwPR3BQY9VNyi5qgQH-tdY3WPNyRhfiC26hLQabQQejGBRw@mail.gmail.com>
References: <1513207108-30430-1-git-send-email-nicoleotsuka@gmail.com>
 <1513207108-30430-4-git-send-email-nicoleotsuka@gmail.com>
 <aad404d3-fa61-3c49-6265-04fc3b256bc6@tabi.org>
 <CAGoOwPSqf4oKB=gZdD8=W=q9y=CcpjYyUuWkmfm7dQc+P6QDmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f51.google.com (mail-it0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A2DA266B0F
 for <alsa-devel@alsa-project.org>; Sat, 16 Dec 2017 07:11:00 +0100 (CET)
Received: by mail-it0-f51.google.com with SMTP id m11so534495iti.1
 for <alsa-devel@alsa-project.org>; Fri, 15 Dec 2017 22:11:00 -0800 (PST)
In-Reply-To: <CAGoOwPSqf4oKB=gZdD8=W=q9y=CcpjYyUuWkmfm7dQc+P6QDmw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>
Cc: alsa-devel@alsa-project.org, kernel@pengutronix.de, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, caleb@crome.org, mail@maciej.szmigiero.name, Mark Brown <broonie@kernel.org>, arnaud.mouiche@invoxia.com, lukma@denx.de, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Hi,

I am outside so can't use mutt. Sorry for that.

This comment is going to be replaced in the 2nd set anyway because the
whole function will be replaced.

And please point out all comments that you think I need to rework. I am
totally fine to do that. I don't think every single one is bad. And this
patch has to go in as it also adds a lot of new comments.

Thank you for your effort
Nicolin

On Dec 15, 2017 20:43, "Timur Tabi" <timur@tabi.org> wrote:

On 12/13/17 5:18 PM, Nicolin Chen wrote:

> -        * We are running on a SoC which does not support online SSI
> -        * reconfiguration, so we have to enable all necessary flags at
> once
> -        * even if we do not use them later (capture and playback
> configuration)
> +        * Online configuration is not supported
> +        * Enable or Disable all necessary bits at once
>

This is an example of a bad change, IMHO.  The original was written in
elegant prose.  The new version is just two short sentences.
