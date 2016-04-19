From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Question about Conversion to S24_LE from S24_3LE
Date: Tue, 19 Apr 2016 09:27:19 +0200
Message-ID: <5715DDD7.7060907@ladisch.de>
References: <61B6C8BF61481342973655BC8AB0FF355AE2F4@PGSMSX101.gar.corp.intel.com>
 <5714A9B0.8060002@ladisch.de>
 <61B6C8BF61481342973655BC8AB0FF355AEE24@PGSMSX101.gar.corp.intel.com>
 <5714CCB2.1050403@ladisch.de>
 <61B6C8BF61481342973655BC8AB0FF355AEFE5@PGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id CD7912651DB
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2016 09:27:20 +0200 (CEST)
In-Reply-To: <61B6C8BF61481342973655BC8AB0FF355AEFE5@PGSMSX101.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Tan, Seng Kai" <seng.kai.tan@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Tan, Seng Kai wrote:
> The input to the driver should be 0x123456 (3 byte, no padding)
> And the driver supposed to arrange it to 0x12345600 (4 byte, LSB padding for left justified)

No, the kernel driver should never change sample data.

If the hardware supports only 32-bit-aligned samples, then the driver
must declare that.  Any needed conversions are then done in user space.

>>> S24_LE in wav file
>
> qwavheaderdump -F ~/Public/workspace/aud_file/Tones/2ch_48sine_S24_LE.wav
>         channels: 2
>         sample rate: 48000
>         bytes/second: 384000
>         bytes/sample: 8
>         bits/sample: 24

This is not correct according to the .wav specification; the
wBitsPerSamples field must be the container size, which is 32 here (as
shown by nChannels and nBlockAlign).

If the number of valid bits is less than the container size, the file
must use the wValidBitsPerSample field in the WAVEFORMATEXTENSIBLE
structure.

Anyway, .wav files cannot describe or use S24_LE samples, they use
either S32_LE (as in this file) or S24_3LE.


Regards,
Clemens
