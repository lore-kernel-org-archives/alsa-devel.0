From: Jonathan Liu <net147@gmail.com>
Subject: Re: snd-usb-audio Buffer Sizes and Round Trip Latency
Date: Wed, 24 Oct 2018 20:29:58 +1100
Message-ID: <CANwerB2h3MSuVWM03hpJ2pR-O4h6KYqm56DxHB8WuhW+7m5B+A@mail.gmail.com>
References: <CANwerB2wCHRz4E45uqWRVsynhzcFHNDwkHiAefoG0eJ=dCYTKQ@mail.gmail.com>
 <Pine.LNX.4.44L0.1810231048030.1417-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 33FAD26752C
 for <alsa-devel@alsa-project.org>; Wed, 24 Oct 2018 11:30:11 +0200 (CEST)
Received: by mail-pg1-f195.google.com with SMTP id l6-v6so2052977pgp.3
 for <alsa-devel@alsa-project.org>; Wed, 24 Oct 2018 02:30:11 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1810231048030.1417-100000@iolanthe.rowland.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Hi,

On Wed, 24 Oct 2018 at 02:10, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Tue, 23 Oct 2018, Jonathan Liu wrote:
>
> > > > > Linux 4.17.14, Class Compliant Mode (snd-usb-audio, ALSA backend):
> > > > > 16/2 32 + 80 ~ 2.333 ms
> > >
> > > What are these numbers?  Are these lines supposed to in the format
> > > expressed by the first formula above?  If they are, how come
> > > "block_size/periods" shows up as a pair of numbers "16/2" but
> > > "block_size*periods" shows up as a single number "32"?
> > >
> >
> > To interpret "16/2 32 + 80 ~ 2.333 ms"
> > Block size: 16 samples
>
> Is this what ALSA would call the number of frames per period?  I
> presume your sample is the same as an ALSA frame.  (As I recall, in
> ALSA each frame in a stereo stream contains two samples.  You _are_
> using stereo, right?  And each sample would be 3 bytes for 24-bit
> audio.  Also, in ALSA the period size and block size are the sizes in
> bytes, not in frames.)
>

Yes, I am using 2 channels input and 2 channels output for testing on Linux.

> > Periods: 2 (one period for playback + one period for recording when
> > determining round trip latency)
>
> In other words, one period per block in each direction?
>

Yes.

> > The minimum round trip latency is: 16 * 2 = 32 samples
> > However, I measured 112 samples round trip latency which is an
> > additional delay of 80 samples (32 + 80 = 112).
> > 112 samples at 48000 Hz is 112 / 48000 * 1000 is approximately 2.333
> > ms measured round trip latency.
> >
> > > > > 16/3 48 + 109 ~ 3.271 ms
>
> Presumably this indicates three periods, then.  Is that two in the
> outward direction and one in the inward direction, or vice versa?
>

Yes, one period is always for capture and the remaining periods are
for playback.

> > > > > 32/2 64 + 129 ~ 4.021 ms
> > > > > 32/3 96 + 166 ~ 5.458 ms
> > > > > 64/2 128 + 205 ~ 6.938 ms
> > > > > 64/3 192 + 242 ~ 9.042 ms
> > > > > 128/2 256 + 352 ~ 12.667 ms
> > > > > 128/3 384 + 496 ~ 18.334 ms
> > > > > 256/2 512 + 650 ~ 24.208 ms
> > > > > 256/3 768 + 650 ~ 29.542 ms
> > > > > 512/2 1024 + 634 ~ 34.542 ms
> > > > > 512/3 1536 + 634 ~ 45.208 ms
> > > > > 1024/2 2048 + 650 ~ 56.208 ms
> > > > > 1024/3 3072 + 650 ~ 77.542 ms
> > > > > 2048/2 4096 + 633 ~ 98.521 ms
> > > > > 2048/3 6144 + 633 ~ 141.188 ms
>
> As compared to the other systems, it appears that in Linux the
> additional delay increases with the period size.  This could be a
> result of the initial zero-filled URBs, since the size or number of
> those URBs may depend on the other settings.
>
> > > > > macOS High Sierra, Class Compliant Mode (Apple Driver):
> > > > > 16/2 32 + 205 ~ 4.938 ms
> > > > > 32/2 64 + 205 ~ 5.604 ms
> > > > > 64/2 128 + 205 ~ 6.938 ms
> > > > > 128/2 256 + 205 ~ 9.604 ms
> > > > > 256/2 512 + 205 ~ 14.938 ms
> > > > > 512/2 1024 + 205 ~ 25.604 ms
> > > > > 1024/2 2048 + 205 ~ 46.938 ms
> > > > > 2048/2 4096 + 205 ~ 89.604 ms
> >
> > >
> > > What are the USB parameters for these tests?  How many bytes/frame?
> > > What is the endpoint's maxpacket size?  What is the speed of the USB
> > > bus?
> > >
> >
> > How would I determine the USB parameters and bytes/frame?
> >
> > USB port is Intel USB 3.0 port. Device is USB 2.0 high speed (480 Mbps).
> >
> > Here is the lsusb output:
>
> Both too much information and too little.  Instead, let's see the
> device's entry in /sys/kernel/debug/usb/devices, copied at a time while
> the test is running.  That will omit a lot of irrelevant information
> and will indicate which of all the possible device settings is the one
> actually in use.
>

T:  Bus=01 Lev=01 Prnt=01 Port=04 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=2a39 ProdID=3fb0 Rev= 0.01
S:  Manufacturer=RME
S:  Product=Babyface Pro (71964099)
S:  SerialNumber=EF72ADBCCECA4C8
C:* #Ifs= 4 Cfg#= 1 Atr=80 MxPwr=100mA
A:  FirstIf#= 0 IfCount= 4 Cls=01(audio) Sub=00 Prot=20
I:* If#= 0 Alt= 0 #EPs= 0 Cls=01(audio) Sub=01 Prot=20 Driver=snd-usb-audio
I:  If#= 1 Alt= 0 #EPs= 0 Cls=01(audio) Sub=02 Prot=20 Driver=snd-usb-audio
I:* If#= 1 Alt= 1 #EPs= 2 Cls=01(audio) Sub=02 Prot=20 Driver=snd-usb-audio
E:  Ad=03(O) Atr=05(Isoc) MxPS= 150 Ivl=125us
E:  Ad=83(I) Atr=11(Isoc) MxPS=   4 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=01(audio) Sub=02 Prot=20 Driver=snd-usb-audio
E:  Ad=03(O) Atr=05(Isoc) MxPS= 900 Ivl=125us
E:  Ad=83(I) Atr=11(Isoc) MxPS=   4 Ivl=1ms
I:  If#= 2 Alt= 0 #EPs= 0 Cls=01(audio) Sub=02 Prot=20 Driver=snd-usb-audio
I:  If#= 2 Alt= 1 #EPs= 1 Cls=01(audio) Sub=02 Prot=20 Driver=snd-usb-audio
E:  Ad=84(I) Atr=05(Isoc) MxPS= 900 Ivl=125us
I:* If#= 2 Alt= 2 #EPs= 1 Cls=01(audio) Sub=02 Prot=20 Driver=snd-usb-audio
E:  Ad=84(I) Atr=05(Isoc) MxPS= 150 Ivl=125us
I:* If#= 3 Alt= 0 #EPs= 2 Cls=01(audio) Sub=03 Prot=00 Driver=snd-usb-audio
E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

> If you want to get a better idea for exactly what is happening at the
> USB level, you can collect a usbmon trace while running a test.  Also,
> it wouldn't hurt to see the values of max_packs_per_urb, urb_packs,
> max_packs_per_period, urbs_per_period, ep->max_urb_frames, and
> ep->nurbs from data_ep_set_params() in the audio driver.

Maybe in a few weeks. I suspect the additional latency is mainly in
the playback direction.

Regards,
Jonathan
