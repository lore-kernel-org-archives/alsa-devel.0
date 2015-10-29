From: Damien Horsley <Damien.Horsley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH V2 02/10] ASoC: img: Add driver for I2S input
 controller
Date: Thu, 29 Oct 2015 15:42:59 +0000
Message-ID: <56323E83.5010605@imgtec.com>
References: <1444653637-14711-1-git-send-email-Damien.Horsley@imgtec.com>
 <1444653637-14711-3-git-send-email-Damien.Horsley@imgtec.com>
 <20151019174732.GG32054@sirena.org.uk> <56293472.7000401@imgtec.com>
 <20151023225723.GO29919@sirena.org.uk> <562F824F.9070407@imgtec.com>
 <20151028010443.GX28319@sirena.org.uk> <56313B9C.8030502@imgtec.com>
 <20151028234334.GF28319@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151028234334.GF28319-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, James Hartley <James.Hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 28/10/15 23:43, Mark Brown wrote:
> On Wed, Oct 28, 2015 at 09:18:20PM +0000, Damien Horsley wrote:
>> On 28/10/15 01:04, Mark Brown wrote:
> 
>>>> I think it also makes sense to keep the blocks consistent with each
>>>> other. The spdif (out and in), and parallel out, all flush automatically
>>>> when stopped, and the fifo for the i2s out block is cleared when the
>>>> reset is asserted.
> 
>>> This seems like an issue that got missed in the other drivers then.  I'd
>>> expect the trigger operation to be a minimal operation which starts and
>>> stops the data transfer, not doing anything else.
> 
>> The spdif out, spdif in, and parallel out blocks auto-flush whenever
>> they are stopped. It is not possible for software to prevent this behavior.
> 
> Oh, so this isn't the drivers doing this?  In that case it's fine for
> them to do that, if it's what the hardware does it's what the hardware
> does.  It sounded like you were saying that there was similar code in
> the other drivers.
> 

For the I2S In, there is another issue with flushing on stream close. If
the stream is stopped, then reconfigured to use a larger number of
channels (without the stream being closed), then the per-channel fifos
will become inconsistent with each other. The new channels will have no
samples in their FIFOs, while the others may contain samples from the
previous stream.

Would hw_params be the correct place to flush instead?
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
