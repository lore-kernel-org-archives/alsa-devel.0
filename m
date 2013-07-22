From: Felipe Tonello <eu@felipetonello.com>
Subject: Re: [PATCH] ALSA: SoC: Added jack detection kcontrol support
Date: Mon, 22 Jul 2013 14:11:44 -0700
Message-ID: <CAGrhNMyAofsnwKYMk+60GyvpaW9pMtoJf_2Q_Tc82G8QCFOiFA@mail.gmail.com>
References: <1374281962-3786-1-git-send-email-eu@felipetonello.com>
	<20130722000157.GI9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130722000157.GI9858@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, LiamGirdwoodlgirdwood@gmail.com, JaroslavKyselaperex@perex.cz, TakashiIwaitiwai@suse.de, linux-kernel@vger.kernel.org, "Felipe F. Tonello" <ftonello@cercacor.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Sun, Jul 21, 2013 at 5:01 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Jul 19, 2013 at 05:59:22PM -0700, Felipe F. Tonello wrote:
>> From: "Felipe F. Tonello" <ftonello@cercacor.com>
>>
>> It adds soc jack support for alsa kcontrol.
>>
>> This support is necessary since the new kcontrol is used by user-space
>> daemons, such as PulseAudio(>=2.0), to do jack detection.
>>
>> Signed-off-by: Felipe F. Tonello <ftonello@cercacor.com>
>> ---
>>  include/sound/soc.h  |  1 +
>>  sound/soc/Kconfig    |  1 +
>>  sound/soc/soc-jack.c | 22 ++++++++++++++++++++++
>>  3 files changed, 24 insertions(+)
>
> No, this makes no sense at all as an ASoC specific feature - it should
> be a standard feature of ALSA jacks.  The whole point of having ALSA
> core infrastructure for jacks is to avoid having to go round doing make
> work stuff like this.

I agree. I added as a ASoC feature because I followed the example of
HDA implementation.

My question is: Why ALSA Jack support uses evdev input events to
notify user-space? Is there any user-space relying on that? If no, I
would like to change ALSA Jack implementation to only use KControl and
remove specific implementations.

At least the only daemon that I know that supports jack detection,
which is PulseAudio, uses this new ALSA KControl for Jacks.

Regards,
Felipe Tonello
