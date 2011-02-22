From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: ALSA: usb-audio: fix oops due to cleanup race when disconnecting
Date: Tue, 22 Feb 2011 15:12:10 +0300
Message-ID: <4D63A81A.5010002@ru.mvista.com>
References: <Pine.LNX.4.44L0.1102111737280.13739-100000@netrider.rowland.org>	<4D58EDA9.2020805@ladisch.de> <s5hoc6ejz2j.wl%tiwai@suse.de>	<20110216235422.GB6375@xanatos> <s5hk4gyy9m1.wl%tiwai@suse.de> <4D63800E.30509@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D63800E.30509-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Cc: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bossart.nospam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Pierre-Louis Bossart <pierre-louis.bossart-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hello.

On 22-02-2011 12:21, Clemens Ladisch wrote:

> From: Takashi Iwai<tiwai-l3A5Bk7waGM@public.gmane.org>

> When a USB audio device is disconnected, snd_usb_audio_disconnect()
> kills all audio URBs.  At the same time, the application, after being
> notified of the disconnection, might close the device, in which case
> ALSA calls the .hw_free callback, which should free the URBs too.

> Commit de1b8b93a0ba prevented snd_usb_hw_free() from freeing the URBs to

    Linus asks to also specify the commit summary in parens.

> avoid a hang that resulted from this race, but this introduced another
> race because the URB callbacks could now be executed after
> snd_usb_hw_free() has returned, and try to access already freed data.

> Fix the first race by introducing a mutex to serialize the disconnect
> callback and all PCM callbacks that manage URBs (hw_free and hw_params).

> Reported-by: Pierre-Louis Bossart<pierre-louis.bossart-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> [CL: also serialize hw_params callback]
> Signed-off-by: Clemens Ladisch<clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
