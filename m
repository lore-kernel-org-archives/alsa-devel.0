From: Jesus R <sonorejr@gmail.com>
Subject: Re: [PATCH v3 5/5] ALSA: snd-usb: add quirks handler
 for DSD streams
Date: Mon, 12 Aug 2013 08:17:31 -0400
Message-ID: <CANNq7HjCERQxLLBe_43Px6eYc1Dhgh3xCW+8L-H2wk2RnE88fw@mail.gmail.com>
References: <CANNq7HhLg=1p4ASYzRdN4igexQX11NhwdbiKF2eS=avnyU1ykA@mail.gmail.com>
 <5208A24D.5000400@gmail.com>
 <CANNq7HjgbBvJLRPpewWZKF1LSYmDaSndQnmaXV9XSLj7rvPeHA@mail.gmail.com>
 <5208CA5E.8040604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f175.google.com (mail-ob0-f175.google.com
 [209.85.214.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 0500726163E
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2013 14:17:33 +0200 (CEST)
Received: by mail-ob0-f175.google.com with SMTP id xn12so7179218obc.20
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2013 05:17:33 -0700 (PDT)
In-Reply-To: <5208CA5E.8040604@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 12, 2013 at 7:43 AM, Daniel Mack <zonque@gmail.com> wrote:

> [please never drop people from the Cc: list but always use 'reply to all'!]
>
sorry I didn't notice..

>
> On 12.08.2013 13:27, Jesus R wrote:
> > On Mon, Aug 12, 2013 at 4:52 AM, Daniel Mack <zonque@gmail.com
> > <mailto:zonque@gmail.com>> wrote:
>
> >     Given than none of devices have a chance to report their
> capabilities to
> >     the host, finding out which modes to use is a trial-and-error game,
> >     unless you have access to the firmware sources.
> >
> >
> >     Hence, please just look up the USB IDs and alternate interface
> settings
> >     of your connected device with lsusb, and then augment the code in
> >     snd_usb_interface_dsd_format_quirks() (file sound/usb/quirks.c) and
> play
> >     around with different possibilities (bitreverse on/off, DSD_U8 vs
> >     DSD_U16 etc). Follow the example that I provided in that function.
> >
> > Right now MPD supports DSD/DoP with one selectable on/off option. On
> > equals DoP output and off equals conversion to PCM. I'm not aware of any
> > case where it does not work. I would seem to me that there is one
> > predominant format?
>
> It's more complicated than that. Applications were always free to use a
> usual PCM stream and stuff it with DOP/DSD samples. This is the whole
> idea of DOP: allow applications to transport DSD samples via regular
> audio streams. The downside of this is that applications are in charge
> of adding the DOP markers manually, and information about bit-reversing
> and marker format (8 bit vs. 16 bit) is up to the application, which is
> not the right place for it.
>
The majority of devices only support up to 192K. These only support DSD64
via DoP using 176.4K and you can automatically assume 16 bit. The remaining
devices support up to 384K. These support DSD64 via DoP using 176.4K
and DSD128 via DoP using 384K. Again you have to assume 16 bit. I'm not
aware of any devices that support 705.6K that also support DSD/DoP, but
someone will do it.

>
> The patch series I brought in addressed this in a way that all that
> information about device-specific details is now known to the kernel,
> which can hence offer a standard compliant interface to userspace.
>
> [There's yet one more level of confusion as some file formats store the
> samples bit-reversed, but there's nothing we can do about that from
> kernel space except for defining a stable interface application have to
> obey to in order to be compatible. That is, samples are expected to
> always carry the oldest bit in the most significant bit of a byte.]
>
> So my question is: are you 100% sure that MPD uses the newly introduces
> ALSA formats, or are they doing the DOP conversion in manually in their
> own software layers?
>
MPD is doing the DoP conversion.

>
> >     You have to recompile and rmmod/insmod the snd-usb driver every time
> you
> >     make a change, and then you need some sort of userspace tool to test
> it.
> >     I published one here:
> >
> > This may be more than I can do. Can you add the options (bitreverse
> > on/off, DSD_U8 vs
> > DSD_U16 etc) to the alas-dsd-player? This would allow me to quickly test
> > the devices.
>
> There are #if0'ed blocks that you can opt-in for bit reversal, but as
> the marker format is different for 8 and 16 bits, and up to the kernel
> space now, the dsd player does not know about them. That was the entire
> intention of bringing that logic to kernel space in the first place.
>
> > Take a look at the DSD database so you can see what we are up against. I
> > could even add the tests results to the database.
> >
> https://docs.google.com/spreadsheet/ccc?key=0AgVhKcl_3lHfdFVyenBBNjNpQ2lieG81WGpqQTNfVUE#gid=0
>
> Nice list. Only devics with USB interface are interesting at this point,
> but that's a good start.
>
Understood.

>
> As I said: you need to add the quirks for the devices to the quirks
> list. Other than that, there's no chance to test them.
>
> Copy'n pasting code inside that function and recompiling the kernel is
> really not as hard as you might think it is. Just search the internet
> for "compile kernel git <your-distribution-here>" and follow the links.
>
I can compile something with luck on my side, but I'm not coder.

>
>
> Thanks,
> Daniel
>
>
