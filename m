From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [PATCH] ASoC: samsung dma - prepare dma in
 start/resume trigger path
Date: Fri, 24 Aug 2012 00:52:10 -0700
Message-ID: <CAEUnVG58NPNKuf_PRyBEegYnH95dkTN81PGZGYxDt41jhH2uaQ@mail.gmail.com>
References: <1345755069-9512-1-git-send-email-dgreid@chromium.org>
 <00df01cd81cb$e21d2f00$a6578d00$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 by alsa0.perex.cz (Postfix) with ESMTP id B8768265CFE
 for <alsa-devel@alsa-project.org>; Fri, 24 Aug 2012 09:52:31 +0200 (CEST)
Received: by weyx10 with SMTP id x10so786238wey.38
 for <alsa-devel@alsa-project.org>; Fri, 24 Aug 2012 00:52:31 -0700 (PDT)
In-Reply-To: <00df01cd81cb$e21d2f00$a6578d00$@com>
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
Cc: alsa-devel@alsa-project.org, kgene.kim@samsung.com, alim.akhtar@samsung.com, jassi.brar@samsung.com, padma.v@samsung.com, broonie@opensource.wolfsonmicro.com, ben-linux@fluff.org, olofj@chromium.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 24, 2012 at 12:41 AM, Sangbeom Kim <sbkim73@samsung.com> wrote:
> Hi!
>
> On Thu, Aug 24, 2012 at 5:51 AM, Dylan Reid wrote:
>> On suspend all dma transactions are terminated (by the stop/suspend
>> trigger calling ops->stop), they need to be set up again during resume.
>> Move the prepare op to the start/resume/unpause trigger path so that dma
>> and audio will restart on resume/unpause.
> Do you mean that currently, suspend/resume can't be supported?

Yes. Currently, if I suspend while playing, after resume it won't work
until I close and reopen the device.  the call to snd_pcm_resume is
not indicating an error, but a write error comes from snd_pcm_write a
little later.

The suspend trigger calls ops->stop, which in turn sends
DMA_TERMINATE_ALL to the pl330.  I think this causes resume's call to
ops->trigger to fail because there is nothing enqueued, but I'm pretty
new to this system.

Thanks for the help!

Dylan

>
> Thanks,
> Sangbeom.
>
