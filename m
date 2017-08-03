From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Problem with DoP mode in Chord 2qute USB audio
Date: Thu, 3 Aug 2017 11:32:36 -0500
Message-ID: <9feb9dce-db60-3624-02db-f431484c6ea6@linux.intel.com>
References: <939956ee-4e91-f726-84ee-59a9b9ddafd1@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E30EF267467
 for <alsa-devel@alsa-project.org>; Thu,  3 Aug 2017 18:32:38 +0200 (CEST)
In-Reply-To: <939956ee-4e91-f726-84ee-59a9b9ddafd1@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@ivitera.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 8/3/17 10:00 AM, Pavel Hofman wrote:
> Hello,
>
> I am working with owner of Chord 2qute on the following problem (FYI
> long discussion at
> http://www.diyaudio.com/forums/pc-based/310578-chord-2qute-dop-challenge.html):
>
>
> Regular 176.4/24 PCM plays OK, however 176.4/24 DoP produces random 1-2
> sec sound interruptions every several tens of seconds. Tested players -
> squeezelite, MPD. The soundcard has its own power supply.
>
> I googled out several reports of simlar problem with this soundcard,
> mostly on linux (did not see any problem report for OSX).
>
> alsainfo: http://www.fyn13.dk/diy/alsa_output_chord_2qute_4.4.0-62.txt
>
> lsusb -v : http://www.fyn13.dk/diy/chord_lsusb.txt
>
> hw_params and stream0 files are identical for both 176.4/24 PCM and DoP:
>
> /proc/asound/card1/pcm0p/sub0/hw_params:
> access: RW_INTERLEAVED
> format: S32_LE
> subformat: STD
> channels: 2
> rate: 176400 (176400/1)
> period_size: 1764
> buffer_size: 7056
>
> /proc/asound/card1/stream0:
> Chord Electronics Ltd 2Qute at usb-0000:00:14.0-2, high speed : USB Audio
> Playback:
>   Status: Running
>     Interface = 2
>     Altset = 1
>     Packet Size = 224
>     Momentary freq = 176402 Hz (0x16.0ce0)
>     Feedback Format = 16.16
>   Interface 2
>     Altset 1
>     Format: S32_LE
>     Channels: 2
>     Endpoint: 5 OUT (ASYNC)
>     Rates: 32000, 44100, 48000, 88200, 96000, 176400, 192000, 352800,
> 384000
>     Data packet interval: 125 us
>
> We checked for XRUNs, none were produced during the interruption in DoP
> playback.
>
> Powerful 4-core CPU Intel Pentium 4405U @ 2.10GHz, idle > 99% of time in
> DoP playback.
>
> However, the IRQs rate of the onboard XHCI controller is 8k/s for both
> PCM and DoP playback which corresponds to 1 IRQ every 125us frame. The
> rate drops to almost zero when playback is stopped in the player -
> clearly it is related to the soundcard.  Could this perhaps be a sign of
> the problem? Please is there a way to lower the rate, like the old
> removed param nrpacks of the usb-audio driver?
>
> I suspect a buggy XMOS firmware. I very much appreciate any suggestion
> or help, either with fixing in software, or further diagnostics to
> support potential claim to the manufacturer.

Suggestions:
- try with regular PCM @ 176.4Khz 24 bits to rule out issues in the way 
DSD is depacked from the stream
- look into the ASYNC endpoint handling. It could be that the host 
doesn't provide enough data and the device buffer is emptied at some 
point. USB doesn't clearly define in how much time the host needs to 
adjust to feedback information, the implementation may have defined its 
buffer depth assuming a quick correction.

>
> Thank you very much. With regards,
>
>
> Pavel.
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
