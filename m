From: Ryan Lee <RyanS.Lee@maximintegrated.com>
Subject: RE: [PATCH V2] ASoC: max98373: Added max98373_reset for stable amp
 reset
Date: Wed, 28 Nov 2018 17:07:02 +0000
Message-ID: <DM6PR11MB3131E267C1EDF9254BC7D313E7D10@DM6PR11MB3131.namprd11.prod.outlook.com>
References: <20181128031926.7157-1-ryans.lee@maximintegrated.com>
 <20181128094955.GG6828@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181128094955.GG6828@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Grant Grundler <grundler@chromium.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Benson Leung <bleung@chromium.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>
List-Id: alsa-devel@alsa-project.org

>-----Original Message-----
>From: Mark Brown <broonie@kernel.org>
>Sent: Wednesday, November 28, 2018 1:50 AM
>To: Ryan Lee <RyanS.Lee@maximintegrated.com>
>Cc: Liam Girdwood <lgirdwood@gmail.com>; Jaroslav Kysela
><perex@perex.cz>; Takashi Iwai <tiwai@suse.com>; Grant Grundler
><grundler@chromium.org>; Kuninori Morimoto
><kuninori.morimoto.gx@renesas.com>; Benson Leung
><bleung@chromium.org>; alsa-devel@alsa-project.org; linux-
>kernel@vger.kernel.org; ryan.lee.maxim@gmail.com
>Subject: Re: [PATCH V2] ASoC: max98373: Added max98373_reset for stable
>amp reset
>
>On Wed, Nov 28, 2018 at 03:20:16AM +0000, Ryan Lee wrote:
>> Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
>> ---
>
>Not seeing a changelog here like I asked for :(

Actually I added changelog as below. Do you mean this is not sufficient?

Changes since v1 : Removed unusual repeat for amp software reset and verifi=
cation.
                   Amp software reset will be performed once and it repeats=
 verification maximum 3 times if it is failed.
                   Wait 10ms before every verification trial. Maximum 30ms =
delay will be applied to wait AMP idle state.

>
>> Changes : Created max98373_reset function to minimize code duplication.
>>           Changed regmap_write to regmap_update_bits. Other bits except =
LSB
>need to be masked.
>>           Added reset verification step to make sure software reset is c=
ompleted
>well. Software reset is done in 10ms in normal case.
>>           Revision ID is available when the amp is in the idle state whi=
ch means
>software reset is completed.
>>           Software reset will be performed maximum 3 times to avoid amp =
reset
>failure. Generally it is done in the first trial.
>>           sleep time after software reset is increased + 30ms for every =
retrial.
>Maximum possible msleep time is 100 ms (initial 10 ms + 30 ms * 3 times).
>
>This looks like it's supposed to be a changelog but it isn't one?
