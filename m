From: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Subject: Re: [alsa-devel] Buffer size for ALSA USB PCM audio
Date: Tue, 27 Aug 2013 10:11:20 +0200
Message-ID: <521C5F28.70309@ladisch.de>
References: <Pine.LNX.4.44L0.1308261419100.886-100000@iolanthe.rowland.org> <521C5315.3030207@ladisch.de> <521C5CC2.7030809@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <521C5CC2.7030809-49v42ZqfXVBBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Hofman <pavel.hofman-49v42ZqfXVBBDgjK7y7TUQ@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Eldad Zack <eldad-v6AqZgAe4C4dvzyIwGCCOg@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, James Stone <jamesmstone-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Pavel Hofman wrote:
> On 27.8.2013 09:19, Clemens Ladisch wrote:
>> The driver cannot control how many samples actually end up in a capture
>> packet,...
>
> Does this reasoning apply to asynchronous playback too?

No.

> I understand the driver has some control, but has to satisfy the endpoint
> feedback requests.

When the driver wants to submit a playback URB, it knows how many
samples it is copying into the packets.  (There is a delay between the
device reporting its desired rate and the driver actually using it.)


Regards,
Clemens
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
