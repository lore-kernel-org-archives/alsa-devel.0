From: pl bossart <bossart.nospam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: ALSA: usb-audio: fix oops due to cleanup race when disconnecting
Date: Tue, 22 Feb 2011 17:10:05 -0600
Message-ID: <AANLkTimNhi7GT4NbQRrNq6kyrKOQhudF2owf=U_qzQav@mail.gmail.com>
References: <Pine.LNX.4.44L0.1102111737280.13739-100000@netrider.rowland.org>
	<4D58EDA9.2020805@ladisch.de>
	<s5hoc6ejz2j.wl%tiwai@suse.de>
	<20110216235422.GB6375@xanatos>
	<s5hk4gyy9m1.wl%tiwai@suse.de>
	<4D63800E.30509@ladisch.de>
	<s5hfwrg9zpv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <s5hfwrg9zpv.wl%tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Pierre-Louis Bossart <pierre-louis.bossart-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

> Ah, I forgot to put my sign-off since I was waiting for any test
> result... =A0Has anyone tried it?
>

Tested-by: Pierre-Louis Bossart<pierre-louis.bossart-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Discard my other messages, the patch seems to work fine when I don't
skip any steps...  I need more coffee and stop multitasking... I spent
15mn pluging and unpluging my headset without any issues.
Thanks Takashi and Clemens for the fix
-Pierre
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
