From: Felipe Tonello <eu@felipetonello.com>
Subject: Re: [PATCH v2 1/2] ALSA: Added jack detection KControl support
Date: Wed, 7 Aug 2013 16:06:27 -0700
Message-ID: <CAGrhNMxTu6R07Wgp8TY4Aw5a2wA83L5-f7rYF5XbT=sE886SXA@mail.gmail.com>
References: <1375430365-13232-1-git-send-email-eu@felipetonello.com>
	<1375430365-13232-2-git-send-email-eu@felipetonello.com>
	<20130807164509.GO6427@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130807164509.GO6427@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Wed, Aug 7, 2013 at 9:45 AM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Aug 02, 2013 at 12:59:24AM -0700, Felipe F. Tonello wrote:
>
>> +int jack_ctl_integer_info(struct snd_kcontrol *kcontrol,
>> +                          struct snd_ctl_elem_info *uinfo)
>> +{
>> +     uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
>> +     uinfo->count = 0x10000U;
>> +     uinfo->value.integer.min = 0;
>> +     uinfo->value.integer.max = 0xffff;
>> +     return 0;
>> +}
>
> I'd expected to see us creating multiple boolean controls here.  I don't
> have a great problem with doing things this way but it's surprising and
> I worry about confusing existing userspace, Takashi?

Yes, it makes more sense. I got confused with another talk we had
previously, that's why I end up doing as an int.

I will wait for more comments about these patches and will submit a v3.

Thanks,

Felipe Tonello
