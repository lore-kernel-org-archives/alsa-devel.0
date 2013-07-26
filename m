From: Felipe Tonello <eu@felipetonello.com>
Subject: Re: [PATCH 1/4] ALSA: Added jack detection kcontrol support
Date: Fri, 26 Jul 2013 12:10:27 -0700
Message-ID: <CAGrhNMy7qZ8CbAjFX5Gv8OqYkit+Eqzr2zZTYXeQ-cNO22+pTQ@mail.gmail.com>
References: <1374863133-6745-1-git-send-email-eu@felipetonello.com>
	<1374863133-6745-2-git-send-email-eu@felipetonello.com>
	<20130726185458.GX9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130726185458.GX9858@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, David Henningsson <david.henningsson@canonical.com>, Wang Xingchao <xingchao.wang@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

Mark,

On Fri, Jul 26, 2013 at 11:54 AM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Jul 26, 2013 at 11:25:30AM -0700, Felipe F. Tonello wrote:
>
>> +
>> +     /* Update ALSA KControl interface */
>> +     snd_kctl_jack_report((struct snd_card *)jack->kctl->private_data, jack->kctl, !!status);
>
> This isn't ideal for multi-function jacks like headsets - it will report
> a single boolean value for the jack regardless of what's plugged in
> meaning userpace can't do things like figure out if a headset or
> headphone is present.  It's probably OK for any realistic input button
> since you're not going to get an input button without other things being
> present.

The KControl for Jack is boolean anyway. You can check it with "amixer
contents". user-space can figure out based on the control name. At
least PulseAudio does that way.

>
> What I'd expect to happen here is that for multi function jacks we
> create a control per function if the controls are valid.

Do you mean based on snd_jack_types?

Felipe Tonello
