From: Michael Howard <mike@dewberryfields.co.uk>
Subject: Re: Wandboard Quad - SPDIF issue, no sound
Date: Wed, 25 Jun 2014 15:16:51 +0100
Message-ID: <53AAD9D3.2000107@dewberryfields.co.uk>
References: <53A86CC5.2060204@dewberryfields.co.uk>
 <53A90D98.3050000@writeme.com> <53A991F4.9070905@dewberryfields.co.uk>
 <53AA0E8E.6030508@writeme.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dewberryfields.co.uk (mail.dewberryfields.co.uk
 [217.41.92.67]) by alsa0.perex.cz (Postfix) with ESMTP id D103F2615B9
 for <alsa-devel@alsa-project.org>; Wed, 25 Jun 2014 16:16:51 +0200 (CEST)
In-Reply-To: <53AA0E8E.6030508@writeme.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 25/06/2014 00:49, Sinan Akman wrote:
>
>   Hi Mike
>
>> I have tried a second receiver and the results are the same, as in, the
>> wandboard fails, the cubietruck works. I fear that this a design issue
>> and I'm wasting your time.
>
>   There is one another thing. When you run aplay for testing I suggest
> you define the format and the rate explicitly and don't use plugin
> as part of your device. It is possible that your default format that
> your aplay on wandbord picks is not compatible with what your receiver
> can handle.
>
>   Regards
>
>   Sinan Akman
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
Hi Sinan,

Well I've tried all the formats and various rates without suceess.

I've determined the capabilities of the Wandboard spdif to be;

alsacap -d hw:0,0
*** Exploring configuration space of device `hw:0,0' for playback ***
2 channels
Sampling rate 32000..48000 Hz
Sample formats: S16_LE, S24_LE

as opposed to the Cubietruck (which works - as does Win7);

  alsacap -d hw:1,0
*** Exploring configuration space of device `hw:1,0' for playback ***
1..2 channels
Sampling rate 8000..192000 Hz
Sample formats: S16_LE
Significant bits: 16

The ouputs of speaker test are almost identical;

Wnadboard;

speaker-test -Dsysdefault:CARD=imxspdif -c2

speaker-test 1.0.25

Playback device is sysdefault:CARD=imxspdif
Stream parameters are 48000Hz, S16_LE, 2 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 64 to 16384
Period size range from 32 to 8192
Using max buffer size 16384
Periods = 4
was set period_size = 4096
was set buffer_size = 16384

Cubietruck;

speaker-test -Dsysdefault:CARD=sunxisndspdif -c2

speaker-test 1.0.25

Playback device is sysdefault:CARD=sunxisndspdif
Stream parameters are 48000Hz, S16_LE, 2 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 4096 to 32768
Period size range from 1024 to 8192
Using max buffer size 32768
Periods = 4
was set period_size = 8192
was set buffer_size = 32768

One obvious difference is that the Wandboard uses 'snd-soc-dummy-dai'.

I'll get a scope on the job this evening, is there anything inparticular 
I should be looking for?

Cheers,
Mike.

-- 
