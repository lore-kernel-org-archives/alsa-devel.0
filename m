From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2 14/16] ASoC: fsl_ssi: Remove cpu_dai_drv
 from fsl_ssi structure
Date: Sun, 14 Jan 2018 16:13:06 -0800
Message-ID: <20180115001305.GD2925@Asurada-CZ80>
References: <1515652995-15996-1-git-send-email-nicoleotsuka@gmail.com>
 <1515652995-15996-15-git-send-email-nicoleotsuka@gmail.com>
 <4626cd37-c84c-6187-51ae-73fa419b801e@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
 [209.85.192.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 700FE266CFE
 for <alsa-devel@alsa-project.org>; Mon, 15 Jan 2018 01:13:10 +0100 (CET)
Received: by mail-pf0-f196.google.com with SMTP id e76so7255859pfk.1
 for <alsa-devel@alsa-project.org>; Sun, 14 Jan 2018 16:13:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4626cd37-c84c-6187-51ae-73fa419b801e@maciej.szmigiero.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: alsa-devel@alsa-project.org, kernel@pengutronix.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, caleb@crome.org, timur@tabi.org, broonie@kernel.org, arnaud.mouiche@invoxia.com, lukma@denx.de, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 14, 2018 at 11:42:59PM +0100, Maciej S. Szmigiero wrote:
> On 11.01.2018 07:43, Nicolin Chen wrote:
> > The cpu_dai_drv is only used for symmetric_rates. So this patch replaces
> > it with a synchronous boolean flag.
> 
> You make cpu_dai_drv common to all SSI instances instead of per-instance.
> 
> What if you have multiple SSIs in the system with different
> symmetric_{rates,samplebits,channels} settings?

Good catch...it should maintain each cpu_dai_drv separately. Thanks!
