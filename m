From: "Bryan Wu" <cooloney@kernel.org>
Subject: Re: [PATCH 1/1] ASoC Blackfin: fix bug - Audio Latency
	on AD1981 with MMAP enabled
Date: Sat, 27 Sep 2008 21:40:58 +0800
Message-ID: <386072610809270640jc80a554n8807b58f2b10f000@mail.gmail.com>
References: <1222505889-22287-1-git-send-email-cooloney@kernel.org>
	<20080927093316.GB3330@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f17.google.com (mail-gx0-f17.google.com
	[209.85.217.17]) by alsa0.perex.cz (Postfix) with ESMTP id 420F6243AE
	for <alsa-devel@alsa-project.org>;
	Sat, 27 Sep 2008 15:41:00 +0200 (CEST)
Received: by gxk10 with SMTP id 10so10749505gxk.8
	for <alsa-devel@alsa-project.org>; Sat, 27 Sep 2008 06:40:59 -0700 (PDT)
In-Reply-To: <20080927093316.GB3330@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bryan Wu <cooloney@kernel.org>, alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Sep 27, 2008 at 5:33 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Sat, Sep 27, 2008 at 04:58:09PM +0800, Bryan Wu wrote:
>> From: Cliff Cai <cliff.cai@analog.com>
>
>> With MMAP enabled (DMA mode) on the AD1981, there is +/- 250ms of delay between
>> writing data to alsa and audio starts coming out of the AD1981.
>>
>> Copy more data to local buffer before starting DMA
>
>> Signed-off-by: Cliff Cai <cliff.cai@analog.com>
>> Signed-off-by: Bryan Wu <cooloney@kernel.org>
>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>
> but
>
>> + *
>> + * Revision history
>> + *      6th June 2008 Initial version
>> + *      25th Sep 2008 fix latency when enable mmap
>>   */
>
> it'd be good to drop the in-code changelogs - we're already tracking the
> history of the code with git and they're likely to end up providing an
> inaccurate history due to people not updating them (this applies to most
> of the Blackfin code).  There were in-code changelogs in ASoC in the past
> from the time it was out of tree but they shouldn't be required now.
>

OK, I will submit a new patch by moving the changelogs to git log.

Thanks
-Bryan
