From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v3 00/11] ASoC: fsl_ssi: Clean up - coding
	style level
Date: Fri, 15 Dec 2017 22:56:36 -0800
Message-ID: <CAGoOwPRN8pf2D72E342F+nqcL1quYg4Y3tbr09rU3OW6hypN2w@mail.gmail.com>
References: <1513207108-30430-1-git-send-email-nicoleotsuka@gmail.com>
 <19ce4850-5561-45b1-3c16-1dd5591ab88a@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f51.google.com (mail-it0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id A08ED266B0F
 for <alsa-devel@alsa-project.org>; Sat, 16 Dec 2017 07:56:38 +0100 (CET)
Received: by mail-it0-f51.google.com with SMTP id o130so600690itg.0
 for <alsa-devel@alsa-project.org>; Fri, 15 Dec 2017 22:56:38 -0800 (PST)
In-Reply-To: <19ce4850-5561-45b1-3c16-1dd5591ab88a@tabi.org>
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

Hello Mark,

Can you please take the first two patches since Timur acked? For the rest
ones, we probably still need some discussion.

Thanks
Nicolin


On Dec 15, 2017 20:53, "Timur Tabi" <timur@tabi.org> wrote:

On 12/13/17 5:18 PM, Nicolin Chen wrote:

> Additionally, in order to fix/work-around hardware bugs and design
> flaws, the driver made a lot of compromise so now its program flow
> looks very complicated and it's getting hard to maintain or update.
>
> So I am going to clean up the driver on both coding style level and
> program flow level.
>

I'm okay with everything except patch #3.




On Dec 15, 2017 20:53, "Timur Tabi" <timur@tabi.org> wrote:

On 12/13/17 5:18 PM, Nicolin Chen wrote:

> Additionally, in order to fix/work-around hardware bugs and design
> flaws, the driver made a lot of compromise so now its program flow
> looks very complicated and it's getting hard to maintain or update.
>
> So I am going to clean up the driver on both coding style level and
> program flow level.
>

I'm okay with everything except patch #3.
