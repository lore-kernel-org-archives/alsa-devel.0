From: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: ALSA: usb-audio: fix oops due to cleanup race when
 disconnecting
Date: Tue, 22 Feb 2011 13:38:18 -0800
Message-ID: <20110222213818.GA3141@xanatos>
References: <Pine.LNX.4.44L0.1102111737280.13739-100000@netrider.rowland.org>
 <4D58EDA9.2020805@ladisch.de>
 <s5hoc6ejz2j.wl%tiwai@suse.de>
 <20110216235422.GB6375@xanatos>
 <s5hk4gyy9m1.wl%tiwai@suse.de>
 <4D63800E.30509@ladisch.de>
 <s5hfwrg9zpv.wl%tiwai@suse.de>
 <AANLkTikcXPTZYYwYDunq4pJwzDhxSv5u++jEWN0RU4EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikcXPTZYYwYDunq4pJwzDhxSv5u++jEWN0RU4EQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: pl bossart <bossart.nospam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 22, 2011 at 02:18:41PM -0600, pl bossart wrote:
> >> When a USB audio device is disconnected, snd_usb_audio_disconnect(=
)
> >> kills all audio URBs. =A0At the same time, the application, after =
being
> >> notified of the disconnection, might close the device, in which ca=
se
> >> ALSA calls the .hw_free callback, which should free the URBs too.
> >>
> >> Commit de1b8b93a0ba prevented snd_usb_hw_free() from freeing the U=
RBs to
> >> avoid a hang that resulted from this race, but this introduced ano=
ther
> >> race because the URB callbacks could now be executed after
> >> snd_usb_hw_free() has returned, and try to access already freed da=
ta.
> >>
> >> Fix the first race by introducing a mutex to serialize the disconn=
ect
> >> callback and all PCM callbacks that manage URBs (hw_free and hw_pa=
rams).
> >>
> >> Reported-by: Pierre-Louis Bossart <pierre-louis.bossart-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> >> [CL: also serialize hw_params callback]
> >> Signed-off-by: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
> >
> > Ah, I forgot to put my sign-off since I was waiting for any test
> > result... =A0Has anyone tried it?
>=20
> Doesn't work for me. same oops as before. Either I made a mistake whe=
n
> merging this patch manually (there were some rejects), or the problem
> is still there.

Which kernel version were you trying to patch?  Was it a vanilla kernel=
,
or did you have some other changes applied?

Sarah Sharp
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
