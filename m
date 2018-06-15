From: noman pouigt <variksla@gmail.com>
Subject: Re: Slow SPI reads in ALSA causing mic recording error
Date: Thu, 14 Jun 2018 21:57:53 -0700
Message-ID: <CAES_P+87w5LtP6avbbzq3qtXE2j8P5C1XW1cx4GvZ27piOqrNg@mail.gmail.com>
References: <CAES_P+96hMOrbtVekpUC6dJg8Znmq9a8VSVU7hNAA5XG00eYjg@mail.gmail.com>
 <20180614104223.GA9660@sirena.org.uk>
 <CAES_P+_BSYr9yENYdU+O55p=boQQQA6HxTwqrca167jKO-k3rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f42.google.com (mail-pg0-f42.google.com [74.125.83.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A7452673CC
 for <alsa-devel@alsa-project.org>; Fri, 15 Jun 2018 06:57:55 +0200 (CEST)
Received: by mail-pg0-f42.google.com with SMTP id z1-v6so3888663pgv.12
 for <alsa-devel@alsa-project.org>; Thu, 14 Jun 2018 21:57:55 -0700 (PDT)
In-Reply-To: <CAES_P+_BSYr9yENYdU+O55p=boQQQA6HxTwqrca167jKO-k3rw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, vkoul@kernel.org
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 14, 2018 at 5:48 PM, noman pouigt <variksla@gmail.com> wrote:
> On Thu, Jun 14, 2018 at 3:42 AM, Mark Brown <broonie@kernel.org> wrote:

On further debugging I found that I am getting xruns which explains the problem.

I am getting xrun in elapsed callback and ALSA is sending kill_fasync
to userspace
and userspace is calling prepare and trigger callback again.

I think I can check XRUN condition in prepare callback  and send
userspace a error
to let them know that XRUN happened.

>> On Thu, Jun 14, 2018 at 02:12:35AM -0700, noman pouigt wrote:
>>
>>> I have also used high priority workqueues but that didn't
>>> help either. Wondering if I can get some pointers to debug this?
>>> also if there any alsa-utility which can simulate closely audio flinger?
>>
>> You probably just need to ensure that you've got more than one period
>> so there's always one ready, increase min_periods or possibly make the
>> individual periods bigger.  It's normally going to be very hard to get
>> everything scheduled reliably if there's no margin for error, ensuring
>> there's some grace in case things run over will tend to be more robust.
>
> Thanks, but can you kindly explain how userspace application read which
> is happening via pcm_read (mmap) affects kernel SPI workqueue thread doing
> SPI read in a while loop i.e. causing SPI reads to get delayed?
>
> In kernel, we have two workqueues:
> 1. First to do SPI reads after trigger callback trigger and call
> elapsed callback
> once SoC gets more than period size.
> 2. Second to handle interrupts from DSP.
>
> First workqueue SPI reads is getting delayed based on the what application is
> reading data. In case of tinycap, we don't see much time difference
> between SPI reads
> but with AudioFlinger we see lot of time difference between consecutive SPI
> reads? How can application affect kernel threads and cause this delay?
>
> Please let me know where is this dependency coming from?
