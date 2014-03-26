From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: twl4030 latency update
Date: Wed, 26 Mar 2014 14:28:41 +0200
Message-ID: <5332C7F9.2040404@ti.com>
References: <532ACD4A.3080508@univpm.it> <532AEEA6.20704@ti.com>
 <532AFBDD.8040407@univpm.it> <532BE58A.2010701@ti.com>
 <5331CFF9.20402@univpm.it> <53328F4C.8030205@ti.com>
 <53329F54.3030305@univpm.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C41E26519F
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 13:28:46 +0100 (CET)
In-Reply-To: <53329F54.3030305@univpm.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Leonardo Gabrielli <l.gabrielli@univpm.it>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/26/2014 11:35 AM, Leonardo Gabrielli wrote:
> =

> On 26/03/2014 09:26, Peter Ujfalusi wrote:
>> Can you elaborate on the corrupted/scrambled audio? I just don't see how=
 it
>> can happen. Can you get the /proc/asound/card0/pcm0p/sub0/hw_params when=
 you
>> have the audio quality issue?
> Hello,
> Here you are:
> =

> cat /proc/asound/card0/pcm0p/sub0/hw_params
> access: MMAP_INTERLEAVED
> format: S16_LE
> subformat: STD
> channels: 2
> rate: 22050 (22050/1)
> period_size: 512
> buffer_size: 1024
> =

> And this is jack output:
> =

> jackd -P62 -t2000 -dalsa -dhw:0 -r22050 -p512 -n2 -s -S -i2 -o2 &

arecord -r 22050 -f S16_LE --period-size=3D512 --buffer-size=3D1024 -v | ap=
lay -r
22050 -f S16_LE  --period-size=3D512 --buffer-size=3D1024 -v

and no issue on the headphone from Beagle.

> I can send you saomething to get it clearer. I recorded  a 10Hz sine wave=
 with
> jaaa. The wave is totally scrambled (probably buffers are not read in ord=
er).
> But it may well be an issue with jack.
> =

> When the output sounds correct (256 period) hw_param is:
> cat /proc/asound/card0/pcm0p/sub0/hw_params
> access: MMAP_INTERLEAVED
> format: S16_LE
> subformat: STD
> channels: 2
> rate: 22050 (22050/1)
> period_size: 256
> buffer_size: 768

arecord -r 22050 -f S16_LE -v --period-size=3D256 --buffer-size=3D768 | apl=
ay -r
22050 -f S16_LE  --period-size=3D256 --buffer-size=3D768 -v

again, audio is clear with this one as well

>> I can not run jackd on the board anymore (with linux-next at least):
>> FATAL: cannot locate cpu MHz in /proc/cpuinfo
> =

> Yes, there's been a recent fix to that (you can checkout the latest jackd=
 from
> git repos, see this thread:
> http://lists.jackaudio.org/private.cgi/jack-devel-jackaudio.org/2014-Marc=
h/012167.html

I also found this, but lazy to update my jack...

> Or maybe you can just start jackd specifying a different clock with the -c
> switch i.e.
> jackd -P62 -t2000 -c s -dalsa -dhw:0 -r22050 -p512 -n2 -s -S -i2 -o2 &

This does not work.

-- =

P=E9ter
