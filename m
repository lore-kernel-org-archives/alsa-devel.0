From: Padma Venkat <padma.kvr@gmail.com>
Subject: Re: [PATCH] ASoC: samsung: Fix non-DT use of I2S
	controller
Date: Fri, 12 Dec 2014 08:53:50 +0530
Message-ID: <CAAgF-BcEzKMvuiP8jepsrg4k4uxhLXRfzj6jAuEaQ=kVc=5cjA@mail.gmail.com>
References: <1417809427-5126-1-git-send-email-broonie@kernel.org>
 <CAAgF-Bfv5OaDYu2Ti=9CCoZ9k-1ZhOG-KRfgXJYanKpLWp9ffQ@mail.gmail.com>
 <20141208121200.GV11764@sirena.org.uk>
 <CAAgF-BfCQ8sfT-dH8+yNUrPA=qPChv6G_8bX0qHnkj-Phb=zhw@mail.gmail.com>
 <20141210131937.GR11764@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f182.google.com (mail-yk0-f182.google.com
 [209.85.160.182])
 by alsa0.perex.cz (Postfix) with ESMTP id C177726063F
 for <alsa-devel@alsa-project.org>; Fri, 12 Dec 2014 04:23:51 +0100 (CET)
Received: by mail-yk0-f182.google.com with SMTP id 131so2772970ykp.41
 for <alsa-devel@alsa-project.org>; Thu, 11 Dec 2014 19:23:50 -0800 (PST)
In-Reply-To: <20141210131937.GR11764@sirena.org.uk>
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

On 12/10/14, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Dec 09, 2014 at 09:33:00AM +0530, Padma Venkat wrote:
>> On 12/8/14, Mark Brown <broonie@kernel.org> wrote:
>
>> > OK, though I presume that's wrong too (otherwise it should be v4).
>
>> Yes. It does not have secondary dai, internal DMA, reset control. It
>> has only 5.1ch support. Register offsets are similar to i2sv3_regs. So
>> I think one V4 dai type with name "samsung,s3c64xx-i2s" is required.
>
> OK, then can you or someone else with access to the documentation please
> provide that?

OK. I will post a patch next week.

>

Thanks
Padma
