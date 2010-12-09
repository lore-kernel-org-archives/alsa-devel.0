From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH] ASoC: WM8580: Fix R8 initial value
Date: Thu, 9 Dec 2010 20:50:36 +0900
Message-ID: <AANLkTinvs39b3NjpX-wHMJp5kOQmYy=ByPAF-Jst8tLo@mail.gmail.com>
References: <1291885672-7198-1-git-send-email-jassi.brar@samsung.com>
	<20101209110015.GB4548@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f42.google.com (mail-bw0-f42.google.com
	[209.85.214.42])
	by alsa0.perex.cz (Postfix) with ESMTP id 30ED8103C8C
	for <alsa-devel@alsa-project.org>; Thu,  9 Dec 2010 12:50:37 +0100 (CET)
Received: by bwz13 with SMTP id 13so2573372bwz.29
	for <alsa-devel@alsa-project.org>; Thu, 09 Dec 2010 03:50:36 -0800 (PST)
In-Reply-To: <20101209110015.GB4548@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, kgene.kim@samsung.com, Jassi Brar <jassi.brar@samsung.com>, sbkim73@samsung.com, sw.youn@samsung.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 9, 2010 at 8:00 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Dec 09, 2010 at 06:07:52PM +0900, Jassi Brar wrote:
>> From: Seungwhan Youn <sw.youn@samsung.com>
>>
>> Acc to WM8580 manual, the default value for R8 is 0x10, not 0x1c.
>>
>> Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
>> ---
>
> You really should include your signoff in patches when sending ones
> written by other people to say that you're certifying that the patch is
> legally OK to submit - that's what the signoff stuff is about, it's
> about saying that you take responsibility for the patch.

Ok, will take care in future.
Thanks.
