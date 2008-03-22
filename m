From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: ca0106 Digital Output at 44.1kHz
Date: Sat, 22 Mar 2008 10:31:40 +0000
Message-ID: <47E4E00C.2010108@superbug.co.uk>
References: <1205410524.8486.274.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-32.mail.demon.net (anchor-post-32.mail.demon.net
	[194.217.242.90])
	by alsa0.perex.cz (Postfix) with ESMTP id 9CF5C2441B
	for <alsa-devel@alsa-project.org>; Sat, 22 Mar 2008 11:31:41 +0100 (CET)
In-Reply-To: <1205410524.8486.274.camel@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Stanley <Ben.Stanley@exemail.com.au>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ben Stanley wrote:
> Dear List,
>
> Hello. I'm new here. This is my first attempt to hack an alsa driver.
>
> I recently purchased a "Sound Blaster Audigy Value!" card for use in a
> MythTV box. As I have a digital receiver, I was mainly concerned with
> getting a working S/PDIF output (coax or optical) and not too much more.
>
> Summary: I can make 44.1kHz digital output work, but I think that the
> driver model of the card having 3 or 4 digital output channels is
> incorrect. I believe the card only has 1 digital output channel.
>   
The ca0106 chip has 3 or 4 digital outputs. These outputs may or may not 
be present on the output connectors of the card.
I know that one of the SB cards does in fact work with 3 digital outputs 
using the 4 pin jacks because I have tested it myself.
I GPIO is programmed to switch it between 3 digital outputs and 1 in, 1 out.
> Details:
>
> The card I have is characterised by the following:
> http://www.soundblaster.com/products/product.asp?category=1&subcategory=205&product=14189
> Model: SB0570
> serial: 100a1102
> Also known as: Sound Blaster Audigy SE
>
> During initial testing, I noticed that 44.1kHz playback was not
> implemented. Subsequent testing shows that speaker-test works fine with
> 48kHz, 96kHz and 192kHz. (I only tested 16bit output so far.)
>
> I noticed in the source code that 44.1k was explicitly disabled. I added
> code in snd_ca0106_pcm_prepare_playback to set up this rate for S/PDIF
> output as per the comments in ca0106.h . Initial tests using hw:0,0 at
> 44.1kHz produced recognisable signals with some noisy corruption. Later
> I accidentally discovered that serially opening hw:0,2 , hw:0,1 and
> hw:0,0  at 44.1kHz then produces perfectly good 44.1kHz sampled digital
> audio output. Removing hw:0,1 or hw:0,2 from this sequence causes noisy
> corruption. It seems that channels 0-2 in reg40 must all be set to the
> same sampling frequency for S/PDIF to work where 44.1kHz is concerned.
> Conversely, to sucessfully output 48kHz again, I have to open hw:0,2 ,
> hw:0,1 and hw:0,0 at 48kHz to restore proper output. I do not have such
> troubles with 96kHz and 192kHz, for which it suffices to just open
> hw:0,0 at the relevant sampling rate.
>   
The ca0106 can do 44.1kHz for digital output ONLY.
The ca0106 cannot output 44.1kHz to the DACs so it will only work in 
Digital mode.
It is a hardware restriction. You are correct, all the inputs and 
outputs have to be at the same rate.


> Anyway, this is speculation. I'd love to have the docs. I haven't tried
> to get them. Is it likely/unlikely that I would get them?
>
>   

You can sign an open-source NDA and get the datasheets.
It lets me write drivers like the current ca0106 and E-Mu drivers.
If you are interested in a NDA, priv-email me.

Kind Regards

James
