From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: fsl_ssi: Remove an outdated
	comment
Date: Wed, 5 Apr 2017 16:20:49 -0300
Message-ID: <CAOMZO5BWHWarOTvHbtYu0U3vhT9gJx623MyxB9W+feGv2yAvvA@mail.gmail.com>
References: <1491410411-6053-1-git-send-email-fabio.estevam@nxp.com>
 <fb6f24af-00c8-0421-32bd-868b28a59989@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
 [209.85.218.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D5D5266943
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 21:20:50 +0200 (CEST)
Received: by mail-oi0-f68.google.com with SMTP id b187so3623708oif.3
 for <alsa-devel@alsa-project.org>; Wed, 05 Apr 2017 12:20:50 -0700 (PDT)
In-Reply-To: <fb6f24af-00c8-0421-32bd-868b28a59989@tabi.org>
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 5, 2017 at 3:26 PM, Timur Tabi <timur@tabi.org> wrote:
> On 04/05/2017 11:40 AM, Fabio Estevam wrote:
>> Therefore, we tell
>> - * ALSA that we support all rates and let the codec driver decide what
>> rates
>> - * are really supported.
>
> This part is still true, though, isn't it?

I have sent a v2 that keeps this part, but after thinking more about
it the "codec driver decide what rates are supported" part applies
only to SSI slave mode,
so IMHO we could just remove the entire comment.
