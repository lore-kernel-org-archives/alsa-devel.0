From: Kevin Cernekee <cernekee-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/3] ASoC: tas571x: Add DT binding document
Date: Mon, 20 Apr 2015 14:16:15 -0700
Message-ID: <CAJzqFtbK+m2hrUn6uydeuMr+hfrzTe3hkMP76xQU8niRY62qWQ@mail.gmail.com>
References: <1429134141-17924-1-git-send-email-cernekee@chromium.org> <20150418111622.GD26185@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150418111622.GD26185-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Olof Johansson <olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 18, 2015 at 4:16 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Apr 15, 2015 at 02:42:19PM -0700, Kevin Cernekee wrote:
>
>> +- VDD-supply: regulator phandle for the AVDD/DVDD/HP_VDD supply
>
> This is clearly not correct - if there are three separate physical
> supplies there should be three separate regulators requested.  They may
> all resolve to one physical regulator on the board you are working with
> but that might not be true on other boards.

In the "simplified diagram," TI shows a single AVDD/DVDD/HP_VDD supply:

http://www.ti.com/lit/ds/symlink/tas5717.pdf#2

Page 20 also suggests the use of a single 3.3V supply for AVDD/DVDD/HP_VDD.

But this combines a number of separate pins.  On 5711 we have
dedicated pins for:

PVDD_A
PVDD_B
PVDD_C
PVDD_D
AVDD
DVDD

On 5717 we have dedicated pins for:

PVDD_AB
PVDD_CD
AVDD
DVDD
HPVDD

I didn't see anything in the datasheet suggesting it is OK to have
different voltages or power states on the various supply pins (other
than the special voltage on PVDD).

I can add as many regulator entries as appropriate.  What do you recommend?
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
