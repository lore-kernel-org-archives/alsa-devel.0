From: Damien Zammit <damien.zammit@gmail.com>
Subject: Re: Bug in aplay?
Date: Wed, 12 Dec 2012 22:54:04 +1100
Message-ID: <CABXa2sEdsWcT8Prq59mTO6szeSvO9-AD6Me=gPF3-wpAGgHB9A@mail.gmail.com>
References: <CABXa2sHAWX-q=tpMdLqJSXbu-kNeuuhhPY5UQ41qKQ+SisD=Rg@mail.gmail.com>
 <s5h38zbh557.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id E3EEA261662
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2012 12:54:05 +0100 (CET)
Received: by mail-ob0-f179.google.com with SMTP id x4so499872obh.38
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2012 03:54:05 -0800 (PST)
In-Reply-To: <s5h38zbh557.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

pi@raspberrypi ~ $ hexdump -C 48000-S24_3BE.wav |head
00000000  52 49 46 58 01 c3 20 48  57 41 56 45 66 6d 74 20  |RIFX.. HWAVEfmt |
00000010  00 00 00 28 ff fe 00 02  00 00 bb 80 00 04 65 00  |...(..........e.|
00000020  00 06 00 18 00 16 00 18  00 00 00 03 00 01 00 00  |................|
00000030  00 00 10 00 80 00 00 aa  00 38 9b 71 66 61 63 74  |.........8.qfact|
00000040  00 00 00 04 00 4b 30 00  64 61 74 61 01 c3 20 00  |.....K0.data.. .|
00000050  ff f6 00 00 14 00 00 3f  00 00 26 00 00 25 00 00  |.......?..&..%..|
00000060  2c 00 ff cf 00 00 2b 00  00 0b 00 00 25 00 00 44  |,.....+.....%..D|
00000070  00 00 1d 00 00 1b 00 00  13 00 00 19 00 00 06 00  |................|
00000080  ff f8 00 00 00 00 ff ab  00 00 04 00 ff f1 00 00  |................|
00000090  0a 00 00 5a 00 00 0d 00  00 38 00 00 0a 00 00 08  |...Z.....8......|

On 12 December 2012 22:38, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 12 Dec 2012 22:01:38 +1100,
> Damien Zammit wrote:
>>
>> Hi,
>> I think i found a small bug in alsa utility "aplay".
>>
>> If you have a sound device that supports the S24_3BE format natively,
>> and you have a wav file of the same format, aplay will not play it
>> because it detects the wrong format and assumes it is default format.
>> (ie 8000Hz Mono 1 channel).
>> I compiled my own version of aplay and it works because I hacked the
>> default format to match this format, but it is not the ideal solution.
>>
>> pi@raspberrypi ~ $ aplay --version
>> aplay: version 1.0.25 by Jaroslav Kysela <perex@perex.cz>
>>
>> pi@raspberrypi ~ $ aplay -D hw:1 48000-S24_3BE.wav
>> Playing raw data '48000-S24_3BE.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
>> aplay: set_params:1081: Sample format non available
>> Available formats:
>> - S24_3BE
>
> Does your WAV file have a valid WAV_FMT_* chunk indicating the 24bit
> format?  aplay checks bit_p_spl and byte_p_spl fields of WaveFmtBody
> defined in formats.h.
>
>
> Takashi
