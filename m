From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [PATCH] ASoC: samsung dma - prepare dma in
 start/resume trigger path
Date: Fri, 24 Aug 2012 10:29:01 -0700
Message-ID: <CAEUnVG5WKsxML8L-ZUo_sNupjZYa11qFY4fPOX2SpUzLPFLWkg@mail.gmail.com>
References: <1345755069-9512-1-git-send-email-dgreid@chromium.org>
 <00df01cd81cb$e21d2f00$a6578d00$@com>
 <CAEUnVG58NPNKuf_PRyBEegYnH95dkTN81PGZGYxDt41jhH2uaQ@mail.gmail.com>
 <00f001cd81e0$2ed8ccf0$8c8a66d0$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 77E42265DDF
 for <alsa-devel@alsa-project.org>; Fri, 24 Aug 2012 19:29:23 +0200 (CEST)
Received: by wibhq4 with SMTP id hq4so901680wib.2
 for <alsa-devel@alsa-project.org>; Fri, 24 Aug 2012 10:29:23 -0700 (PDT)
In-Reply-To: <00f001cd81e0$2ed8ccf0$8c8a66d0$@com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sangbeom Kim <sbkim73@samsung.com>
Cc: alsa-devel@alsa-project.org, kgene.kim@samsung.com, alim.akhtar@samsung.com, padma.v@samsung.com, broonie@opensource.wolfsonmicro.com, ben-linux@fluff.org, olofj@chromium.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 24, 2012 at 3:06 AM, Sangbeom Kim <sbkim73@samsung.com> wrote:
> On Thu, Aug 24, 2012 at 4:52 PM, Dylan Reid wrote:
>> Yes. Currently, if I suspend while playing, after resume it won't work
>> until I close and reopen the device.  the call to snd_pcm_resume is
>> not indicating an error, but a write error comes from snd_pcm_write a
>> little later.
>
> Ok,
> Please let me know your test environment.

I'm using a 5250 evaluation board with a max98095 codec.

>
> Thanks,
> Sangbeom.
>
