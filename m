From: Matti Picus <matti.picus@gmail.com>
Subject: Re: S51 usb support
Date: Mon, 04 Oct 2010 22:08:56 +0200
Message-ID: <4CAA3458.9080007@gmail.com>
References: <4CA8F3F8.6010705@gmail.com>
	<20101004044152.GC7159@buzzloop.caiaq.de>
Reply-To: matti.picus@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C9681038D1
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Oct 2010 22:09:07 +0200 (CEST)
Received: by bwz13 with SMTP id 13so4573267bwz.38
	for <alsa-devel@alsa-project.org>; Mon, 04 Oct 2010 13:09:07 -0700 (PDT)
In-Reply-To: <20101004044152.GC7159@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/04/2010 06:41 AM, Daniel Mack wrote:
> On Sun, Oct 03, 2010 at 11:22:00PM +0200, Matti Picus wrote:
>    
>> My X-FI Surround USB card is barely usable. pulseaudio will let me
>> control the volume levels, alsa support cannot view any volume controls.
>>      
> But audio streaming does work for you? I heard people reporting success
> with this kind of hardware.
>    
Yes, audio streaming works in aplay if I choose the hw:S51 device. I 
cannot find a convenient way to control the volume without firing up 
pavucontrol, "convenient" in this case means "for mpd run as root"
>> How can I contribute to better support for this card under alsa? I would
>> like to get to the point where amixer can control the analog
>> input/output volume levels.
>>      
> As for the volume controls, there are merely two ways how they can be
> implemented on USB soundcards. One is as feature unit control, and the
> other is a proprietary vendor specific USB request. You should start
> having a look at the USB descriptors the devices exports (by running
> "lsusb -v").
>
>    
OK, what should I be looking for? Here is a summary:
 >lsusb -v -s 002:006 |grep '\(\<i[^I]\)\|\(bDescriptorSubtype\)\|\(PCM\)'
   idVendor           0x041e Creative Technology, Ltd
   idProduct          0x3042
   iManufacturer           1 Creative Technology
   iProduct                2 SB X-Fi Surround 5.1
   iSerial                 3 000008NV
     iConfiguration          0
         bDescriptorSubtype      1 (HEADER)
         bDescriptorSubtype      2 (INPUT_TERMINAL)
         iChannelNames           0
         iTerminal               0
         bDescriptorSubtype      3 (OUTPUT_TERMINAL)
         iTerminal               0
         bDescriptorSubtype      2 (INPUT_TERMINAL)
         iChannelNames           0
         iTerminal               0
         bDescriptorSubtype      3 (OUTPUT_TERMINAL)
         iTerminal               0
         bDescriptorSubtype      3 (OUTPUT_TERMINAL)
         iTerminal               0
         bDescriptorSubtype      1 (AS_GENERAL)
         wFormatTag              1 PCM
         bDescriptorSubtype      2 (FORMAT_TYPE)
           bDescriptorSubtype      1 (EP_GENERAL)
         bDescriptorSubtype      1 (AS_GENERAL)
         wFormatTag              1 PCM
         bDescriptorSubtype      2 (FORMAT_TYPE)
           bDescriptorSubtype      1 (EP_GENERAL)
         bDescriptorSubtype      1 (AS_GENERAL)
         wFormatTag              1 PCM
         bDescriptorSubtype      2 (FORMAT_TYPE)
           bDescriptorSubtype      1 (EP_GENERAL)
         bDescriptorSubtype      1 (AS_GENERAL)
         wFormatTag              1 PCM
         bDescriptorSubtype      2 (FORMAT_TYPE)
           bDescriptorSubtype      1 (EP_GENERAL)
         bDescriptorSubtype      1 (AS_GENERAL)
         wFormatTag              1 PCM
         bDescriptorSubtype      2 (FORMAT_TYPE)
           bDescriptorSubtype      1 (EP_GENERAL)
         bDescriptorSubtype      1 (AS_GENERAL)
         wFormatTag              1 PCM
         bDescriptorSubtype      2 (FORMAT_TYPE)
           bDescriptorSubtype      1 (EP_GENERAL)
         bDescriptorSubtype      1 (AS_GENERAL)
         bDescriptorSubtype      2 (FORMAT_TYPE)
           bDescriptorSubtype      1 (EP_GENERAL)
         bDescriptorSubtype      1 (AS_GENERAL)
         bDescriptorSubtype      2 (FORMAT_TYPE)
           bDescriptorSubtype      1 (EP_GENERAL)
         bDescriptorSubtype      1 (AS_GENERAL)
         wFormatTag              1 PCM
         bDescriptorSubtype      2 (FORMAT_TYPE)
           bDescriptorSubtype      1 (EP_GENERAL)
         bDescriptorSubtype      1 (AS_GENERAL)
         wFormatTag              1 PCM
         bDescriptorSubtype      2 (FORMAT_TYPE)
           bDescriptorSubtype      1 (EP_GENERAL)
         bDescriptorSubtype      1 (AS_GENERAL)
         wFormatTag              1 PCM
         bDescriptorSubtype      2 (FORMAT_TYPE)
           bDescriptorSubtype      1 (EP_GENERAL)
         bDescriptorSubtype      1 (AS_GENERAL)
         wFormatTag              1 PCM
         bDescriptorSubtype      2 (FORMAT_TYPE)
           bDescriptorSubtype      1 (EP_GENERAL)


> In case the card does not offer a standard way to control the volume
> levels, you need to trace how the Windows driver does it by sniffing
> the communication while performing this specific operation, either with
> an USB hardware analyzer, or with a piece of software. There are some
> projects aiming for this, but I can't give you any recommendation. Just
> try some of these, maybe:
>
>    http://www.google.com/search?q=windows+usb+traffic+sniffer
>
> Once you found out how they do it in Windows, you can add device
> specific mixer handlers, as they exist for other hardware. Have a look
> at sound/usb/mixer_quirks.c.
>
> Hope that helps,
>
> Daniel
>
>    
The card must offer something close to a standard set of volume controls 
since pulseaudio can control the basic stereo volume sliders. I would be 
happy if amixer or even alsamixer would see just the analog stereo 
output and analog line-in input. Currently, pulseaudio can control the 
volume levels but alsa cannot, alsamixer simply shows no volume controls.

Any guidance you can give toward getting the volume controls recognized 
would be greatly appreciate.
Matti
