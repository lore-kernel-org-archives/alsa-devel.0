From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: snd-usb-audio Buffer Sizes and Round Trip Latency
Date: Wed, 24 Oct 2018 10:20:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1810241010560.1534-100000@iolanthe.rowland.org>
References: <CANwerB2h3MSuVWM03hpJ2pR-O4h6KYqm56DxHB8WuhW+7m5B+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
 by alsa0.perex.cz (Postfix) with SMTP id A1DCF2675BB
 for <alsa-devel@alsa-project.org>; Wed, 24 Oct 2018 16:20:11 +0200 (CEST)
In-Reply-To: <CANwerB2h3MSuVWM03hpJ2pR-O4h6KYqm56DxHB8WuhW+7m5B+A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Liu <net147@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, 24 Oct 2018, Jonathan Liu wrote:

> > Both too much information and too little.  Instead, let's see the
> > device's entry in /sys/kernel/debug/usb/devices, copied at a time while
> > the test is running.  That will omit a lot of irrelevant information
> > and will indicate which of all the possible device settings is the one
> > actually in use.
> >
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=04 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=2a39 ProdID=3fb0 Rev= 0.01
> S:  Manufacturer=RME
> S:  Product=Babyface Pro (71964099)
> S:  SerialNumber=EF72ADBCCECA4C8
> C:* #Ifs= 4 Cfg#= 1 Atr=80 MxPwr=100mA
> A:  FirstIf#= 0 IfCount= 4 Cls=01(audio) Sub=00 Prot=20
> I:* If#= 0 Alt= 0 #EPs= 0 Cls=01(audio) Sub=01 Prot=20 Driver=snd-usb-audio

This is the control interface; it is not directly involved.

> I:  If#= 1 Alt= 0 #EPs= 0 Cls=01(audio) Sub=02 Prot=20 Driver=snd-usb-audio
> I:* If#= 1 Alt= 1 #EPs= 2 Cls=01(audio) Sub=02 Prot=20 Driver=snd-usb-audio
> E:  Ad=03(O) Atr=05(Isoc) MxPS= 150 Ivl=125us
> E:  Ad=83(I) Atr=11(Isoc) MxPS=   4 Ivl=1ms

This is one of the interfaces in use; it handles playback data (i.e.,
data sent to the device).  The maxpacket size is 150 bytes, which is 25
frames at 3 bytes/sample and 2 channels.  The interval is 125 us,
giving a maximum throughput of 200 frames/ms, comfortably larger than
the bandwidth being used (48 frames/ms).

> I:  If#= 1 Alt= 2 #EPs= 2 Cls=01(audio) Sub=02 Prot=20 Driver=snd-usb-audio
> E:  Ad=03(O) Atr=05(Isoc) MxPS= 900 Ivl=125us
> E:  Ad=83(I) Atr=11(Isoc) MxPS=   4 Ivl=1ms
> I:  If#= 2 Alt= 0 #EPs= 0 Cls=01(audio) Sub=02 Prot=20 Driver=snd-usb-audio
> I:  If#= 2 Alt= 1 #EPs= 1 Cls=01(audio) Sub=02 Prot=20 Driver=snd-usb-audio
> E:  Ad=84(I) Atr=05(Isoc) MxPS= 900 Ivl=125us
> I:* If#= 2 Alt= 2 #EPs= 1 Cls=01(audio) Sub=02 Prot=20 Driver=snd-usb-audio
> E:  Ad=84(I) Atr=05(Isoc) MxPS= 150 Ivl=125us

This is the other interface being used for audio data; it handles the 
record direction.  Parameters are the same as for playback.

> I:* If#= 3 Alt= 0 #EPs= 2 Cls=01(audio) Sub=03 Prot=00 Driver=snd-usb-audio
> E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

I don't know what this interface is for.  It's probably not directly 
relevant to the issue.

> > If you want to get a better idea for exactly what is happening at the
> > USB level, you can collect a usbmon trace while running a test.  Also,
> > it wouldn't hurt to see the values of max_packs_per_urb, urb_packs,
> > max_packs_per_period, urbs_per_period, ep->max_urb_frames, and
> > ep->nurbs from data_ep_set_params() in the audio driver.
> 
> Maybe in a few weeks. I suspect the additional latency is mainly in
> the playback direction.

That seems likely, especially in the light of Takashi's comments.

Alan Stern
