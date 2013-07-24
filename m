From: Felipe Tonello <eu@felipetonello.com>
Subject: Re: [PATCH] ALSA: SoC: Added jack detection kcontrol support
Date: Tue, 23 Jul 2013 17:10:29 -0700
Message-ID: <CAGrhNMyWXGcDUHxexgvQ2rusKTSbSjEbcEToKZZUudtP-pYxsA@mail.gmail.com>
References: <1374281962-3786-1-git-send-email-eu@felipetonello.com>
	<20130722000157.GI9858@sirena.org.uk>
	<CAGrhNMyAofsnwKYMk+60GyvpaW9pMtoJf_2Q_Tc82G8QCFOiFA@mail.gmail.com>
	<20130723124023.GX9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130723124023.GX9858@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, LiamGirdwoodlgirdwood@gmail.com, JaroslavKyselaperex@perex.cz, TakashiIwaitiwai@suse.de, linux-kernel@vger.kernel.org, "Felipe F. Tonello" <ftonello@cercacor.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Tue, Jul 23, 2013 at 5:40 AM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Jul 22, 2013 at 02:11:44PM -0700, Felipe Tonello wrote:
>
>> My question is: Why ALSA Jack support uses evdev input events to
>> notify user-space? Is there any user-space relying on that? If no, I
>> would like to change ALSA Jack implementation to only use KControl and
>> remove specific implementations.
>
> This was the existing kernel API at the time that the code was added -
> I beleive people had been doing that for simple switches that detect the
> physical presence of a jack since it looks exactly like a button from a
> hardware point of view.  See the original commit adding the code.

I saw it. I don't know what you think is the best way to go. I'm not
sure if someone is using this input event API, since even PulseAudio
even declined that implementation due KControl implementation.

I'm thinking in re-implement core/jack.c using only kcontrol for
reporting status and leaving input events only for keys (which is
already implemented). This will break compatibility if any user-space
checks for jack status using input events, but again, is anyone using
this?

Regards,

Felipe Tonello
