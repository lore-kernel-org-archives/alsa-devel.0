From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Subject: Re: [PATCH v3] ASoC: AMD: Fix race condition between register access
Date: Wed, 19 Dec 2018 10:45:27 +0000
Message-ID: <9b80c3da-c137-f1a3-fd50-85ecb9e3f6a4@amd.com>
References: <1541020930-17337-1-git-send-email-akshu.agrawal@amd.com>
 <20181105111557.GB5365@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181105111557.GB5365@sirena.org.uk>
Content-Language: en-US
Content-ID: <6E44EA00FFF9A24DAE4FA96F78AF4398@namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "djkurtz@chromium.org" <djkurtz@chromium.org>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>, Guenter Roeck <linux@roeck-us.net>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org



On 11/5/2018 4:45 PM, Mark Brown wrote:
> On Wed, Oct 31, 2018 at 09:24:10PM +0000, Agrawal, Akshu wrote:
>=20
>> +/* Lock to protect access to registers */
>> +static DEFINE_SPINLOCK(lock);
>> +
>=20
> Why is this a global variable and not a part of the driver structure?
> Is there some interaction between multiple instances?
>
Yes, this lock is used to protect registers which are common to multiple
instances and can cause issue in cases such as simultaneous playback and
capture.

Thanks,
Akshu
