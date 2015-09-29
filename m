From: Fabio Estevam <festevam@gmail.com>
Subject: Re: speaker-test error using sgtl5000 and imx27
Date: Tue, 29 Sep 2015 13:11:58 -0300
Message-ID: <CAOMZO5AexyD4tdLKzK7SFYvz=-29g3uGwYyL6smoW+YcRbaung@mail.gmail.com>
References: <039601d0ef9b$d40a0460$7c1e0d20$@digger.ch>
 <560A9F92.4070605@digger.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f174.google.com (mail-ig0-f174.google.com
 [209.85.213.174])
 by alsa0.perex.cz (Postfix) with ESMTP id B787A2657E5
 for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2015 18:11:59 +0200 (CEST)
Received: by igcpb10 with SMTP id pb10so83850811igc.1
 for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2015 09:11:58 -0700 (PDT)
In-Reply-To: <560A9F92.4070605@digger.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexandre Schnegg <aschnegg@digger.ch>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, =?UTF-8?B?RXJpYyBCw6luYXJk?= <eric@eukrea.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 29, 2015 at 11:26 AM, Alexandre Schnegg <aschnegg@digger.ch> wrote:
> Hello,
>
> After a few researches, it seems to me that the problem come from the DMA.
> The SSI is set up correctly and waits for data from the DMA, but the DMA
> doesn't not seem to to do his job.
>
> Does anyone can confirm me that the module imx_pcm_dma is working properly
> with Freescale imx27 and mainline kernel?
>
> Anyone has got an audio codec working with the Freescale  imx27 and mainline
> kernel?

I don't have access to my mx27pdk at the moment. I am adding Eric on
Cc in case he could test audio on the imx27-eukrea board.

Regards,

Fabio Estevam
