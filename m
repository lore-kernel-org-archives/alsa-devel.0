From: Fabio Estevam <festevam@gmail.com>
Subject: Re: iMX6UL EVK with kernel 4.6
Date: Sun, 1 May 2016 10:50:16 -0300
Message-ID: <CAOMZO5C9Gk=HVM_aiGQkmT3YbBuGVNYOpkCcS9jmQUyhhJJJzQ@mail.gmail.com>
References: <50f27095-3304-03fa-7209-3f05baccb346@jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f172.google.com (mail-ig0-f172.google.com
 [209.85.213.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 735162604DF
 for <alsa-devel@alsa-project.org>; Sun,  1 May 2016 15:50:17 +0200 (CEST)
Received: by mail-ig0-f172.google.com with SMTP id u10so63647509igr.1
 for <alsa-devel@alsa-project.org>; Sun, 01 May 2016 06:50:17 -0700 (PDT)
In-Reply-To: <50f27095-3304-03fa-7209-3f05baccb346@jikos.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: brain@jikos.cz
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Zidan Wang <zidan.wang@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>
List-Id: alsa-devel@alsa-project.org

Hi Petr,

On Sat, Apr 30, 2016 at 8:18 AM, Petr Kulhavy <brain@jikos.cz> wrote:
> Hi,
>
> I'm trying to run the latest mainline kernel 4.6 on the iMX6UL EVK. The
> board mostly works and the only problem is audio.
> Even though the sound card is detected and the ALSA mixer can be controlled
> there is no MCLK coming out of the SAI2 interface.
> All the related peripherals in the DTS (pinmux, SAI2, sound card, codec)
> seem to be set-up correctly, I also tried out various things like disabling
> the ASRC, but without success and I'm slowly running out of ideas.

Is the MCLK IOMUX setup correctly?

Can you share all your changes to get audio working with 4.6-rc on imx6ul-evk?

I am also interested in getting this functional.
