From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v3 03/11] ASoC: fsl_ssi: Refine all comments
Date: Sat, 16 Dec 2017 09:49:33 -0800
Message-ID: <20171216174932.GB3840@Asurada>
References: <1513207108-30430-1-git-send-email-nicoleotsuka@gmail.com>
 <1513207108-30430-4-git-send-email-nicoleotsuka@gmail.com>
 <01a7d97b-7e80-83b2-e850-d513d7dc35aa@tabi.org>
 <CAG5mAdw04U5gpRMqLYOBeujH=t+59WJLFeGe+Qareh-cuWsDvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id A4378266A74
 for <alsa-devel@alsa-project.org>; Sat, 16 Dec 2017 18:49:37 +0100 (CET)
Received: by mail-pg0-f65.google.com with SMTP id j4so7575154pgp.1
 for <alsa-devel@alsa-project.org>; Sat, 16 Dec 2017 09:49:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAG5mAdw04U5gpRMqLYOBeujH=t+59WJLFeGe+Qareh-cuWsDvg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <kernel@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Arnaud Mouiche <arnaud.mouiche@invoxia.com>, lukma@denx.de, Fabio Estevam <fabio.estevam@nxp.com>, mail@maciej.szmigiero.name, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Sat, Dec 16, 2017 at 09:30:14AM -0800, Caleb Crome wrote:

> Having come to work on this driver with very little knowledge about
> kernel programming, and i.MX, I have to agree with Timur. It's an
> amazingly complex driver (with support of so many variants).  By
> eliminating verbose commentary, it's also wiping away a lot of
> knowledge.  The more sparse commentary makes things harder to
> understand for newcomers, or really anybody who isn't already steeped
> in knowledge about the SSI port and linux, and it's interaction with
> DMA.

I never said that I don't agree with Timur. Every change here is
to simplify things. As long as Timur or any reviewer feels one of
new comments is harder to understand, I am totally fine to rework.
I respect everyone's opinion, but I hope everyone can respect my
effort too by telling me which one needs to rework and why?

Thanks
Nicolin
