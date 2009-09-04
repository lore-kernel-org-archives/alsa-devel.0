From: Joonyoung Shim <dofmind@gmail.com>
Subject: Re: [PATCH] ASoC: AK4671: add ak4671 codec driver
Date: Sat, 5 Sep 2009 00:37:47 +0900
Message-ID: <4e1455be0909040837i3f8906c9w8d1d4436dee46897@mail.gmail.com>
References: <4A9FB5C7.5060607@samsung.com>
	<20090903140236.GB1406@rakim.wolfsonmicro.main>
	<4AA06DB5.6060107@samsung.com>
	<20090904101859.GA17522@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f200.google.com (mail-vw0-f200.google.com
	[209.85.212.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B168244EB
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Sep 2009 17:37:50 +0200 (CEST)
Received: by vws38 with SMTP id 38so691279vws.16
	for <alsa-devel@alsa-project.org>; Fri, 04 Sep 2009 08:37:49 -0700 (PDT)
In-Reply-To: <20090904101859.GA17522@rakim.wolfsonmicro.main>
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
Cc: kyungmin.park@samsung.com, alsa-devel@alsa-project.org, Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: alsa-devel@alsa-project.org

2009/9/4 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Fri, Sep 04, 2009 at 10:30:29AM +0900, Joonyoung Shim wrote:
>> On 9/3/2009 11:02 PM, Mark Brown wrote:
>
>> >> + =A0case SND_SOC_BIAS_STANDBY:
>> >> + =A0 =A0 =A0 =A0 =A0if (ak4671->pll_on) {
>
>> > I suspect this will run into trouble with bypass paths (which do appear
>> > to exist if I read the DAPM routes correctly). =A0If a bypass path is
>> > active then the CODEC will be brought up to full bias out of sync with
>> > any configuration of pll_on by the DAI format configuration.
>
>> A bypass path should operate regardless pll_on.
>
> Yes, I'd expect the bypass path itself to be fine. =A0What I'm concerned
> about is that because with newer ASoC versions the bypass path will
> cause the CODEC to change bias levels independantly of playback and
> record starting the PLL will be configured when the bypass path is
> enabled rather than when record/playback is started. =A0This may cause
> things to get out of sync.
>

Right, so i will use SND_SOC_DAPM_DAC_E and SND_SOC_DAPM_ADC_E.
This event handler desides the setting of PLL, then PLL can be
configured regardless the bypass path.

 _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
