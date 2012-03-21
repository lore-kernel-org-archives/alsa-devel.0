From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: [PATCH v7] sound/soc/lapis: add machine driver for
	ML7213 Carrier Board
Date: Wed, 21 Mar 2012 09:51:58 +0900
Message-ID: <CANKRQniytxNLHdkCDF5W4ZZHxo7w5WJgtYh1036x7DNBe4h2ZA@mail.gmail.com>
References: <CANKRQni1k4hv40j0hTzVMdS9aFccM7xRrHis0-cFuBvSZe+9CA@mail.gmail.com>
	<1332158525-14968-1-git-send-email-tomoya.rohm@gmail.com>
	<20120319192101.GG12384@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 13AC41043B2
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2012 01:51:59 +0100 (CET)
Received: by dady9 with SMTP id y9so843338dad.38
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 17:51:58 -0700 (PDT)
In-Reply-To: <20120319192101.GG12384@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, qi.wang@intel.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, yong.y.wang@intel.com, kok.howg.ewe@intel.com, Liam Girdwood <lrg@ti.com>, joel.clark@intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 20, 2012 at 4:21 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
>> + =A0 =A0 snd_soc_dapm_enable_pin(dapm, "Speaker");
>> + =A0 =A0 snd_soc_dapm_enable_pin(dapm, "AnalogMIC");
>> + =A0 =A0 snd_soc_dapm_enable_pin(dapm, "MICBIAS");
>
> Why are you doing thiS? =A0You never disable these things so if this were
> needed you may as well do it on init, but since the default state is
> enabled anyway this shouldn't be doing anytihng.

OK.
I've confirmed if deleting these lines, both playback/capture work well.
So, I'll delete these.

thanks.
-- =

ROHM Co., Ltd.
tomoya
