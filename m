From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH 1/2] ASoC: fsl_ssi: Remove an outdated
 comment
Date: Wed, 5 Apr 2017 14:21:51 -0500
Message-ID: <ef690ee9-612f-2867-d6cb-5c3520d22fc3@tabi.org>
References: <1491410411-6053-1-git-send-email-fabio.estevam@nxp.com>
 <fb6f24af-00c8-0421-32bd-868b28a59989@tabi.org>
 <CAOMZO5BWHWarOTvHbtYu0U3vhT9gJx623MyxB9W+feGv2yAvvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id 524F7266943
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 21:21:54 +0200 (CEST)
In-Reply-To: <CAOMZO5BWHWarOTvHbtYu0U3vhT9gJx623MyxB9W+feGv2yAvvA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 04/05/2017 02:20 PM, Fabio Estevam wrote:
> I have sent a v2 that keeps this part, but after thinking more about
> it the "codec driver decide what rates are supported" part applies
> only to SSI slave mode,
> so IMHO we could just remove the entire comment.

Then why not remove FSLSSI_I2S_RATES altogether?
