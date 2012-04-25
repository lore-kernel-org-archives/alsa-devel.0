From: Richard Zhao <linuxzsc@gmail.com>
Subject: Re: [PATCH] ASoC: sgtl5000: Enable VAG when DAC/ADC up
Date: Wed, 25 Apr 2012 10:08:05 +0800
Message-ID: <CANg6MZggQA7_Nm0WijFKDFiReCC0hi5tUFa5YU8CF0+Qkh9NKA@mail.gmail.com>
References: <1333000305-27280-1-git-send-email-shawn.guo@linaro.org>
	<20120329071700.GA18127@zzm-ubuntu>
	<20120329105831.GC3668@opensource.wolfsonmicro.com>
	<20120329140420.GD19506@S2101-09.ap.freescale.net>
	<20120329141019.GQ3668@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id BE1B4104692
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Apr 2012 04:08:06 +0200 (CEST)
Received: by ghbg19 with SMTP id g19so936667ghb.38
	for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2012 19:08:05 -0700 (PDT)
In-Reply-To: <20120329141019.GQ3668@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Zeng Zhaoming <zengzm.kernel@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Thu, Mar 29, 2012 at 10:10 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Mar 29, 2012 at 10:04:23PM +0800, Shawn Guo wrote:
>> On Thu, Mar 29, 2012 at 11:58:32AM +0100, Mark Brown wrote:
>
>> > No, the bias should be a supply for the microphone - ensuring that this
>> > happens is the whole point of the patch I sent the other day.
>
>> The "MIC" above is confusing. =A0I guess the following that I have in
>> machine driver might be a little clearer.
>
>> =A0 =A0 =A0 =A0 {"Mic Bias", NULL, "Mic Jack"},
>> =A0 =A0 =A0 =A0 {"MIC_IN", NULL, "Mic Bias"},
>
> This should be something like:
>
> =A0 =A0 =A0 =A0{ "Mic Jack", NULL, "Mic Bias" },
> =A0 =A0 =A0 =A0{ "MIC_IN", NULL, "Mic Bias" },
"MiC Bias" --> "Mic Jack" should be enough.
Why do we have "Mic Bias" --> "MIC_IN" ?

Thanks
Richard
>
> (with the conversion of Mic Bias to a supply widget) which has the bonus
> of being a whole lot easier to understand.
>
>> And I need to present it in device tree though.
>
> Use the generic stuff that Stephen put into the core for reading machine
> driver routing maps out of the device tree (unless there's some problem
> with it, but it should work).
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
