From: Adam Rosenberg <adam@alcorn.com>
Subject: Re: ALSA processor usage is too high
Date: Fri, 5 Nov 2010 14:45:41 -0400
Message-ID: <AANLkTi=kMF=_1u40yTtvA=oSpyyQn=nEF_JHY_NskiAw@mail.gmail.com>
References: <AANLkTik-sb1OihaDhNgptH44gQ4__E+ozxhSKpA9GdSK@mail.gmail.com>
	<4CD41528.1060600@ladisch.de>
	<AANLkTinXm2G1y477xRTc_QjXuEZ_nyAqGWuSkq32KGe2@mail.gmail.com>
	<4CD445BD.3020501@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1EF91103988
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2010 19:46:03 +0100 (CET)
Received: by ewy22 with SMTP id 22so2108323ewy.38
	for <alsa-devel@alsa-project.org>; Fri, 05 Nov 2010 11:46:02 -0700 (PDT)
In-Reply-To: <4CD445BD.3020501@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 5, 2010 at 1:58 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Adam Rosenberg wrote:
>> On Fri, Nov 5, 2010 at 10:31 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
>> > How much CPU does "aplay -D hw -t raw -f dat /dev/zero" use?
>>
>> I do not know how to calculate CPU usage for a given process.
>
> The time utility (if you have it) measures both elapsed and actually
> used CPU time.

I am not sure how to interpret this, but I told aplay to play for 3
minutes from /dev/zero and here are the results:
root:/> time aplay -d 180 -D hw -t raw -f dat /dev/zero
Playing raw data '/dev/zero' : Signed 16 bit Little Endian, Rate 48000
Hz, Stereo
real    3m 0.10s
user    0m 0.22s
sys     0m 8.48s

>
>> For the audio playback I am polling the streams using
>> snd_pcm_avail_update() and then writing the number of frames available
>> using snd_pcm_writei().
>
> And what does your program do when avail_update returns 0 frames?

If it returns 0 then I do not write any frames.  I then check the next
stream.  This continues in an infinite loop.

> You cannot write data faster than it's playing; the audio ring buffer
> has a finite size.
>
> You would have a problem if the processing and/or the driver would
> make everything so slow that you wouldn't be able to write new data
> to the device fast enough, which would result in an buffer underrun.
> Does this actually happen?

I am currently writing the decoded mp3 data to a buffer in RAM so that
the program is decoding the mp3 data as fast as it can.  I then run
the audio process separately and just play silence.  I am doing this
so that I can tell how much time is being spent decoding mp3 data and
processing audio data so that I know how much time remains for other
tasks.  From the times I have calculated I can tell that a buffer
underrun would occur frequently if I was actually writing the decoded
mp3 data to the pcm streams.

-Adam
