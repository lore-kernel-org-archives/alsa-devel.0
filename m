From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v2 04/13] OMAPDSS: hdmi: Make hdmi structure public
Date: Thu, 7 Aug 2014 12:29:47 +0300
Message-ID: <53E3470B.4090902@ti.com>
References: <cover.1403894190.git.jsarha@ti.com> <536afa4069bd73195b05aee3097c86d7e517ae7e.1403894190.git.jsarha@ti.com> <53E324FB.7060000@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <53E324FB.7060000@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, detheridge@ti.com, jyri.sarha@iki.fi
List-Id: alsa-devel@alsa-project.org

On 08/07/2014 10:04 AM, Tomi Valkeinen wrote:
> On 27/06/14 21:38, Jyri Sarha wrote:
>> Name the anonymous hdmi struct as omap_hdmi. Move the struct definition to
>> hdmi.h and turn core member into a pointer to deal with it's different
>> definitions for omap4 and omap5. Make associated changes to hdmi4.c
>> and hdmi5.c.
>
> I didn't understand this one. Why did you make struct hdmi_core_data a
> pointer?
>

That is because there is no point to it :)... my mistake made in a 
hurry. I'll fix that.

Cheers,
Jyri

