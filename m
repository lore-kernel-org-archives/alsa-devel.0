From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to deal with cards with a large on-board buffer?
Date: Wed, 03 May 2006 14:26:58 +0200
Message-ID: <20060503122658.GB11243@turing.informatik.uni-halle.de>
References: <20060502234125.GC4109@home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20060502234125.GC4109@home>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Nicolas Boullis wrote:
> I'm trying to write an ALSA interface for the audio part of MPEG2 
> decoder boards Sigma Designs Hollywod+ and Creative Labs DXR3, both 
> based on Sigma Designs EM8300 chip.
> 
> To make it short, the trouble is that, to get correct working, it seems 
> to require that the audio buffer be kept at some minimal fill level. Is 
> there a way I can enforce this?

The card should do this automatically as it initiates the DMA transfers
by itself.

> Browsing at the code, I found out the fifo_size element of the 
> snd_pcm_hardware_t type, that is not documented

because it isn't used.

> I also discovered the SNDRV_PCM_INFO_DOUBLE, SNDRV_PCM_INFO_BATCH 
> and SNDRV_PCM_INFO_BLOCK_TRANSFER that are give little information, and 
> that sound to me like things that might be useful.

These are just informational flags that describe how the driver does
things.

> Now, just in case someone has a better idea how to make things work, 
> here is a more comprehensive explanation about how those cards work, *as 
> far as I could understand* (since I got absolutely no explanation from 
> the manufacturer):
>    - there is a rather large on-chip buffer (0x3c00 bytes), that we can 
>      neither write to or read directly

So it's just a FIFO that is more or less transparent to the computer?

>    - we can read pointers to the current read and write positions in 
>      this buffer
>    - this buffer is fed by chip-initiated DMA transfers from the main 
>      memory

How big are these transfers?

>    - the buffers for DMA transfers are declared in a FIFO;

You mean this chip supports scatter/gather buffers?

>    - if the on-chip buffer is "too empty" (don't know exactly when the 
>      chip decides it is too empty) and no buffer is available for 
>      DMA transfer, it "sends" some junk to the internal buffer

Most sound card FIFOs operate like this.

>    - interruptions are not raised when buffers are DMA-transfered, but 
>      at fixed 20.2ms interval (stable experimental value)

The ymfpci and usb drivers deal with a similar problem.


Regards,
Clemens


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
