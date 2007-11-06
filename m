From: thomas schorpp <thomas.schorpp@googlemail.com>
Subject: Re: [CONF] All C-Media Codecs based 5.1 Channel USB-
	Headsets
Date: Tue, 06 Nov 2007 09:39:04 +0100
Message-ID: <47302828.2060703@googlemail.com>
References: <472D7698.2080700@googlemail.com>
Reply-To: thomas.schorpp@googlemail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.187])
	by alsa0.perex.cz (Postfix) with ESMTP id EB681247BF
	for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2007 09:39:08 +0100 (CET)
Received: by nf-out-0910.google.com with SMTP id b21so1298385nfd
	for <alsa-devel@alsa-project.org>; Tue, 06 Nov 2007 00:39:08 -0800 (PST)
In-Reply-To: <472D7698.2080700@googlemail.com>
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

thomas schorpp wrote:
> Report to devlist as requested from USB-Audio.conf header:
> 
> 1. all this headsets with windriver inf files + manual showing c-media 
> driver must have the cm106x series 7.1 channel usb-codec in. there's no 
> other from c-media for the design of 5.1 channel usb headsets available 
> at this time, see:
> 
> http://www.cmedia.com.tw/?q=en/usb_audio
> 
> 2. the headset interface shows up with 8 channels in lsusb -v , 1 8-ch 
> pcm in /proc,
> and must be driven with surround7.1 pcm plug instead of surround5.1 or 
> it will not work. speaker-test program works with -c6 -Dsurround7.1, 
> test with -c8 works too, but shows that no SideL/R -speakers 
> connected/routed/downmixed ( Speedlink Medusa 5.1 Mobile USB Headset, 
> cm106L)
> 
> 3. it works instantly without extra config using programs that allow 
> specifying (-D)surround7.1 like VDR and MPlayer, VLC did not so far 

since yesterday VLC does work fine now with the cm106L device, 
just select the alsa device from the list in VLC config, MPlayer should too, 
then. Noteworthy, especially VLC's software equalizer brings a great 
*music sound quality boost* in, it is amazing! :)
sorry for the misreport, but audio device open errors showed up once, 
don't know the cause.

system is debian lenny (testing).

y
tom
