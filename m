From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: twl4030 latency update
Date: Wed, 26 Mar 2014 10:41:07 +0200
Message-ID: <533292A3.5070000@ti.com>
References: <532ACD4A.3080508@univpm.it> <532AEEA6.20704@ti.com>
 <532AFBDD.8040407@univpm.it> <532BE58A.2010701@ti.com>
 <5331CFF9.20402@univpm.it> <53328F4C.8030205@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 6335D265121
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 09:41:10 +0100 (CET)
In-Reply-To: <53328F4C.8030205@ti.com>
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

On 03/26/2014 10:26 AM, Peter Ujfalusi wrote:
> Hi Leonardo,
> =

> On 03/25/2014 08:50 PM, Leonardo Gabrielli wrote:
>> Thanks Peter,
>> I've been able today to test following your suggestions.
>> Unfortunately I didn't get any improvement on latency, but reducing sDMA=
 FIFO
>> threshold improved on audio integrity (with some period+samplerate
>> combinations I have corrupted audio, maybe scrambled or empty frames).
> =

> Can you elaborate on the corrupted/scrambled audio? I just don't see how =
it
> can happen. Can you get the /proc/asound/card0/pcm0p/sub0/hw_params when =
you
> have the audio quality issue?
> =

> I can not run jackd on the board anymore (with linux-next at least):
> FATAL: cannot locate cpu MHz in /proc/cpuinfo
> =

> but with aplay -v --period-size=3D512 or 64 2ch-left-since-22050.wav
> seams to be fine for me (assuming AU=3Dko means that it is the corrupted =
one)

Yeah, this is not correct. it means 512 or 64 periods and not the period si=
zes.
I would need the hw_params for the actual playback to be able to reproduce =
the
issue.

-- =

P=E9ter
