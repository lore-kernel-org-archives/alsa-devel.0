From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: alsa-utils uses incorrect format for 24 bit audio?
Date: Wed, 6 Sep 2017 09:28:15 +0900
Message-ID: <e2ffedd4-a1db-a76b-3bb0-598aa352a74f@sakamocchi.jp>
References: <alpine.DEB.2.11.1709052122100.24087@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id BF9B526734C
 for <alsa-devel@alsa-project.org>; Wed,  6 Sep 2017 02:28:21 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.11.1709052122100.24087@lnxricardw1.se.axis.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Sep 6 2017 04:32, Ricard Wanderlof wrote:
> When attempting to use arecord to capture audio from a 24 bit source, and
> create a 24-bit .wav file I ran into the problem that the resulting file
> does not seem valid. Looking closer at the contents, it appears that
> arecord writes the 32-bit S24_LE samples verbatim to the file, and sets
> the number of bits per sample specifier to 24 in the .wav header, at the
> same time as it sets the 'block align' to 4 which I suppose is logical,
> although normally the block align corresponds to the frame size (in bytes)
> for the sample size specified in the bits per sample specifier.
> 
> A number of utilities and applications I tried refused to play the file
> back properly, including Audacity, VLC, sox and kwave, so I'm guessing the
> format written by arecord is not valid in this case. 24 bit audio as
> exported from Audacity for instance in reality corresponds to the ALSA
> S24_3LE format, i.e. the data is sent with no padding (resulting in a .wav
> 'block align' specifier of 3 for a mono stream).
> 
> Is this a known problem with arecord/aplay, or is it the other
> applications which have been less than accurate when implementing .wav
> file standard?

Would you please dump headers of RIFF/Wave format file with the captured 
samples? Like:

$ hexdump -C /tmp/test.wav | head -n5
00000000  52 49 46 46 70 31 00 00  57 41 56 45 66 6d 74 20 
|RIFFp1..WAVEfmt |
00000010  10 00 00 00 01 00 01 00  a0 0f 00 00 80 3e 00 00 
|.............>..|
00000020  04 00 18 00 64 61 74 61  28 31 00 00 00 00 00 00 
|....data(1......|
00000030  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00 
|................|
*

For confirmation, when capturing any samples, please add '-v' option to 
arecord command line to dump the type of handled samples. Like:

$ LANG=C arecord -v -D plughw:0,0 -t wav -f S24_LE /tmp/hoge.wav
Recording WAVE '/tmp/hoge.wav' : Signed 24 bit Little Endian, Rate 8000 
Hz, Mono
Plug PCM: Rate conversion PCM (48000, sformat=S24_LE)
Converter: libspeex (external)
Protocol version: 10002
Its setup is:
   stream       : CAPTURE
   access       : RW_INTERLEAVED
   format       : S24_LE
...


Regards

Takashi Sakamoto
