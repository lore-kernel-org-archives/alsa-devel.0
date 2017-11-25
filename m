From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 09/12] IIO: ADC: add stm32 DFSDM support for PDM
 microphone
Date: Sat, 25 Nov 2017 14:36:10 +0000
Message-ID: <20171125143610.3dba71da@archlinux>
References: <1510222354-15290-1-git-send-email-arnaud.pouliquen@st.com>
        <1510222354-15290-10-git-send-email-arnaud.pouliquen@st.com>
        <20171119141830.29f1cfc9@archlinux>
        <4362763f-2182-a3cf-cbd6-6c71df59af52@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4362763f-2182-a3cf-cbd6-6c71df59af52-qxv4g6HH51o@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre TORGUE <alexandre.torgue-qxv4g6HH51o@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 24 Nov 2017 15:52:26 +0100
Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org> wrote:

> On 11/19/2017 03:18 PM, Jonathan Cameron wrote:
> > On Thu, 9 Nov 2017 11:12:31 +0100
> > Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org> wrote:
> >   
> >> This code offers a way to handle PDM audio microphones in
> >> ASOC framework. Audio driver should use consumer API.
> >> A specific management is implemented for DMA, with a
> >> callback, to allows to handle audio buffers efficiently.
> >> 
> >> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>  
> > 
> > A few minor points inline.  I'm not sure I really 'like' the
> > solution we've ended up with currently but if it works it will
> > do just fine for now :)
> > 
> > Jonathan
> > 
> >   
> >> ---
> >> V3 -> V4 changes:
> >>  - Merge audio implementation in stm32-dfsdm-adc.c instead of creating separate file
> >>  - Add sysfs document for exported attributes
> >> 
> >>  .../ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32      |  22 +
> >>  drivers/iio/adc/stm32-dfsdm-adc.c                  | 517 ++++++++++++++++++++-
> >>  include/linux/iio/adc/stm32-dfsdm-adc.h            |  27 ++
> >>  3 files changed, 562 insertions(+), 4 deletions(-)
> >>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32
> >>  create mode 100644 include/linux/iio/adc/stm32-dfsdm-adc.h
> >> 
> >> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32
> >> new file mode 100644
> >> index 0000000..0ce5508
> >> --- /dev/null
> >> +++ b/Documentation/ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32
> >> @@ -0,0 +1,22 @@
> >> +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage_audio_sampling_rate
> >> +KernelVersion:       4.14
> >> +Contact:     arnaud.pouliquen-qxv4g6HH51o@public.gmane.org
> >> +Description:
> >> +             For audio purpose only.
> >> +             Used by audio driver to set/get the audio sampling rate.
> >> +             Reading returns current audio sample frequency.
> >> +             Writing value before starting conversions.  
> > 
> > I would like to see a note here on why sampling_frequency can't be used for
> > this purpose.  
> The IIO_CHAN_INFO_SAMP_FREQ can not be used because consumer API allows
> only to access to ext_info attributes.
> An alternate is to export channel attribute functions the consumer API.
> - iio_read_channel_attribute (already exist)
> - iio_write_channel_attribute

Yes - add these please.  Just not been a usecase before for the general write.

> 
> Please, tell me your preference.

<snip>

> >> +/**
> >> + * stm32_dfsdm_get_buff_cb - register a callback
> >> + *   that will be called when DMA transfer period is achieved.  
> > Please run kernel-doc over this file. I'm fairly sure this isn't
> > quite meeting the spec...  
> Sorry it is not crystal clear for me, could you detail what you would
> mean by
> "I'm fairly sure this isn't quite meeting the spec.."?

I don't think it lets you have multiple lines for the short description
IIRC.  Not sure about the indented function parameters.. Might be
new since I last looked!

> 
> >   
> >> + *
> >> + * @iio_dev: Handle to IIO device.
> >> + * @cb: pointer to callback function.
> >> + *   @data: pointer to data buffer
> >> + *   @size: size in byte of the data buffer
> >> + *   @private: pointer to consumer private structure
> >> + * @private: pointer to consumer private structure
> >> + */
