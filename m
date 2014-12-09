From: Padma Venkat <padma.kvr@gmail.com>
Subject: Re: [PATCH] ASoC: samsung: Fix non-DT use of I2S
	controller
Date: Tue, 9 Dec 2014 09:33:00 +0530
Message-ID: <CAAgF-BfCQ8sfT-dH8+yNUrPA=qPChv6G_8bX0qHnkj-Phb=zhw@mail.gmail.com>
References: <1417809427-5126-1-git-send-email-broonie@kernel.org>
 <CAAgF-Bfv5OaDYu2Ti=9CCoZ9k-1ZhOG-KRfgXJYanKpLWp9ffQ@mail.gmail.com>
 <20141208121200.GV11764@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f53.google.com (mail-yh0-f53.google.com
 [209.85.213.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 87A872605D7
 for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2014 05:03:01 +0100 (CET)
Received: by mail-yh0-f53.google.com with SMTP id i57so2942308yha.40
 for <alsa-devel@alsa-project.org>; Mon, 08 Dec 2014 20:03:00 -0800 (PST)
In-Reply-To: <20141208121200.GV11764@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Padmavathi Venna <padma.v@samsung.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 12/8/14, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Dec 08, 2014 at 10:21:52AM +0530, Padma Venkat wrote:
>> On 12/6/14, Mark Brown <broonie@kernel.org> wrote:
>
>> > +	}, {
>> > +		.name		= "samsung-i2sv4",
>> > +		.driver_data	= (kernel_ulong_t)&i2sv5_dai_type_i2s1,
>
>> I think here you need to use i2sv5_dai_type because
>> i2sv5_dai_type_i2s1 is introduced for exynos7 on which the i2s1 is of
>> type v5 but with slightly modified bit offsets.
>
> OK, though I presume that's wrong too (otherwise it should be v4).
>
Yes. It does not have secondary dai, internal DMA, reset control. It
has only 5.1ch support. Register offsets are similar to i2sv3_regs. So
I think one V4 dai type with name "samsung,s3c64xx-i2s" is required.

Thanks
Padma
