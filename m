From: Seungwhan Youn <claude.youn@gmail.com>
Subject: Re: [PATCH 2/5] ASoC: S3C64XX: Add ADC source clock
	setting
Date: Sat, 7 Aug 2010 02:00:27 +0900
Message-ID: <AANLkTikyv-y65kFm5+VDNNX0JGHiJeFuVUKRBL483gwX@mail.gmail.com>
References: <1281053592-3311-1-git-send-email-sw.youn@samsung.com>
	<1281054064-4730-1-git-send-email-sw.youn@samsung.com>
	<20100806102619.GC398@rakim.wolfsonmicro.main>
	<AANLkTin=X3YsTA_cR5ocAML2vLC14HCzbi-qvFhPQz8z@mail.gmail.com>
	<20100806164928.GI31326@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5CEDF1037F9
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 19:00:28 +0200 (CEST)
Received: by wyb42 with SMTP id 42so7903326wyb.38
	for <alsa-devel@alsa-project.org>; Fri, 06 Aug 2010 10:00:28 -0700 (PDT)
In-Reply-To: <20100806164928.GI31326@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Seungwhan Youn <sw.youn@samsung.com>, alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 7, 2010 at 1:49 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Sat, Aug 07, 2010 at 01:28:47AM +0900, Seungwhan Youn wrote:
>> On Fri, Aug 6, 2010 at 7:26 PM, Mark Brown
>
>> > This isn't a patch for S3C64xx, this is a patch for the SMDK boards.
>
>> Can I go-ahead this ADC_MCLK patches? or will you have a plan to
>> handle this also?
>
> Not really much point if we do the clocking properly - it changes over
> to specifying the clock to via set_sysclk() so there's a code change
> implied.
>

I see. Thank you Mark. ;-)

Claude
