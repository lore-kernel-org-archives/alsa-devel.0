From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: [PATCH] - Audigy 1 and Audigy 2 mixer - again
Date: Wed, 05 Nov 2003 15:28:09 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FA91709.7060905@superbug.demon.co.uk>
References: <200311050701.IAA20667@www3.pobox.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200311050701.IAA20667@www3.pobox.sk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: p z oooo <pzad@pobox.sk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

p z oooo wrote:
> Hi,
> 
> Last evening I found way how to use Philips ADC instead of AC97 on 
> Audigy 1.
> 
> Attached patch is tested only on Audigy 1 player (not tested on 
> Audigy 1 Platinium, Audigy 1 Platinium EX, Audigy 2, Audigy 2 
> Platinium, Audigy 2 Platinium EX), but I think it should work for all 
> Audigy 1 and Audigy 2 cards, can some one test it ???
> 
> Modification:
>  - disable routing from AC97 line out to front speakers.
>  - AC97 ADC is used only for Mic playback and recording
>  - Philips ADC is used for other analog playback and recording 
> (Analog Mix Playback Volume, Analog Mix Capture Volume)
>  - removes unused AC97 controls (is phone used ???)
> 
> Advantage:
>  - better Line In, Analog CD, Aux sound quality playback and 
> recording (I hope that Philips ADC is better than old AC97 ADC)
>  - similiar mixer as used on Windows
>  - simpler mixer
>  - you doesn't need set capture source to be able listen or record 
> analog sources - I think this was confusing for many users
>  - fixed small bug in MIC ADC buffer recording (alias device 1 - 16 
> bit 8000 Hz mono)
> 
> TODO:
>  It seems that Audigy 1 can do 24 bit/48kHz recording (and I think 24 
> bit /48 kHz playback too) using TRAM playback and capture. Philips 
> ADC is connected to DSP and trasmit to DSP all 24 bit and I think 
> that Philips DAC is connected in same way.
> 
> Peter Zubaj
> 
Here is a web page with some nice pictures of the chips on the Audigy1
http://board.gabara.co.kr/Board/Read.php?tName=b_goods_ps&number=373
Do you have that ^ card ?

I have an Audigy2 non-platinum, and it has the Philips 1361T Chip.
http://www.semiconductors.philips.com/pip/UDA1361TS_N1.html#datasheet
It looks to me to be an ADC for 2 channels. (Left and Right)
As it is an ADC, I don't see how it can help playback. It probably 
handles the Line-in jack, which currently does not work with alsa.

There is another Chip on my Audigy2 which is a Cirrus Logic CS4382-K
http://www.cirrus.com/en/products/pro/detail/P282.html
That is a 8-channel DAC so it would handle Playback, but strangely, the 
card only has 7-channel output (2 stereo jacks, and 1 3-channel jack).
There are also some OP-AMPs
3x ST 4558C chips dual opamp
1x JRC 4556A chip dual opamp
1x ST 33078 / Z250 dual opamp

The AC97 chip is a Sigmatel STAC9721T
http://www.alsa-project.org/alsa/ftp/datasheets/sigmatel/9721spec.PDF

The main Audigy2 chip is Creative Audigy2 CA0102-IAT

It also has a Serial EEPROM: CSI 93C46S

It also has an as yet unidentied creative chip: NO302 CA0151-DBS

Does anyone have a Pin-Out details of the CA0102 and CA0151 ?

Cheers
James



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
