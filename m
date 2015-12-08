From: Damien Horsley <Damien.Horsley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: img: Add driver for Pistachio
 internal DAC
Date: Tue, 8 Dec 2015 16:04:02 +0000
Message-ID: <5666FF72.7010206@imgtec.com>
References: <1448299499-18435-1-git-send-email-Damien.Horsley@imgtec.com>
 <1448299499-18435-3-git-send-email-Damien.Horsley@imgtec.com>
 <20151125124728.GT1929@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151125124728.GT1929-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 25/11/15 12:47, Mark Brown wrote:
> On Mon, Nov 23, 2015 at 05:24:59PM +0000, Damien Horsley wrote:
> 
>> +	/* The mute state as set by alsa using the digital_mute callback */
>> +	bool alsa_mute_state;
>> +	/* The mute state as set by the userspace mute control */
>> +	bool control_mute_state;
>> +	/* The actual mute state is equal to an OR of the above */
> 
> Does the device *need* the digital mute to avoid noise?  If there's no
> strong need for it then just don't bother which simplifies the code a
> lot.
> 
> Otherwise this looks good.
> 

It does not seem to make a difference. I will remove and repost.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
