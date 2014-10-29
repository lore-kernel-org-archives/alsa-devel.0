From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [alsa-devel] [PATCH 00/11] Add AXD Audio Processing IP driver
Date: Wed, 29 Oct 2014 10:48:14 +0530
Message-ID: <20141029051814.GR28745@intel.com>
References: <1414495589-8579-1-git-send-email-qais.yousef@imgtec.com>
 <544F8439.4080402@ladisch.de>
 <544F97A4.7080209@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <544F97A4.7080209@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Qais Yousef <qais.yousef@imgtec.com>
Cc: Clemens Ladisch <clemens@ladisch.de>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org, Neil Jones <neil.jones@imgtec.com>, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 28, 2014 at 01:18:28PM +0000, Qais Yousef wrote:
> On 10/28/2014 11:55 AM, Clemens Ladisch wrote:
> >Qais Yousef wrote:
> >>AXD Audio Processing IP performs audio decoding, encoding, mixing, equalisation,
> >>synchronisation and playback.
> >What exactly do you mean with "synchronisation" and "playback"?
> 
> Synchronisation refers to accurate audio playout relative to a master
> clock source including compensation of drift between the master clock
> source and the playout clock of the audio hardware. Hence allowing
> synchronised audio playout across multiple independent devices.
> 
> Playback simple refers to the fact that AXD is capable of managing audio
> playout hardware like I2S and SPDIF interfaces.
> 
> 
> >>It doesn't fit in alsa subsystem but I Cced them to confirm.
> >... because those two words sound like something that a sound card could do.
> 
> The problem mainly stems from the fact that we take a variety of
> compressed audio as input and we could perform audio encoding. The
> problem with the compressed audio is that the range of decoders and
> configuration supported in alsa is limited and there's no support for
FWIW ALSA does not support decoders. The compressed ALSA API allows you to
encode or decode your conent on a DSP, it provides API for that

If you have an additional need for a decoder or an encoder which is not
listed, feel free to send a patch!
The most important point is frameowrk is there for thsi so you need to use
that and add whatever is not supported

> taking raw pcm and producing compressed output. I'm not an expert on
> alsa but when I looked it looked like there's more infra structure
> required.
I disagree. You can use alsa PCM device to send pcm data and then use alsa
compressed device to take back the compressed content. The two devices need
to be "connected" using DPCM and DAPM frameowork availble. It should work
with little or no changes

> 
> The following not supported points from Documentation/sound/alsa/compress_offload.txt affect us:
> 
> - Volume control/routing is not handled by this API. Devices exposing a
>   compressed data interface will be considered as regular ALSA devices;
>   volume changes and routing information will be provided with regular
>   ALSA kcontrols.
And why can't you use ALSA kcontrols for volume??
> 
> - Embedded audio effects. Such effects should be enabled in the same
>   manner, no matter if the input was PCM or compressed.
Again why can't you use ALSA kcontrol for effects, be it PCM or compressed
progarmming an EQ thru alsa kcontrol remains same
> 
> - Encoding/decoding acceleration is not supported as mentioned
>   above. 
Wrong on this count

> It is possible to route the output of a decoder to a capture
>   stream, or even implement transcoding capabilities. This routing
>   would be enabled with ALSA kcontrols.
Yes and it should work

> >>I added it to drivers/char as this is the best location I could think of at the
> >>moment.
> >drivers/misc?
> 
> Yeah could do if there's consensus.
NAK for that, this should be an ALSA driver

-- 
~Vinod
