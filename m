From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA processor usage is too high
Date: Fri, 05 Nov 2010 20:10:38 +0100
Message-ID: <4CD456AE.7090302@ladisch.de>
References: <AANLkTik-sb1OihaDhNgptH44gQ4__E+ozxhSKpA9GdSK@mail.gmail.com>
	<4CD41528.1060600@ladisch.de>
	<AANLkTinXm2G1y477xRTc_QjXuEZ_nyAqGWuSkq32KGe2@mail.gmail.com>
	<4CD445BD.3020501@ladisch.de>
	<AANLkTi=kMF=_1u40yTtvA=oSpyyQn=nEF_JHY_NskiAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id BEDA31038AD
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2010 20:08:51 +0100 (CET)
In-Reply-To: <AANLkTi=kMF=_1u40yTtvA=oSpyyQn=nEF_JHY_NskiAw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adam Rosenberg <adam@alcorn.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adam Rosenberg wrote:
> I am not sure how to interpret this, but I told aplay to play for 3
> minutes from /dev/zero and here are the results:
> root:/> time aplay -d 180 -D hw -t raw -f dat /dev/zero
> Playing raw data '/dev/zero' : Signed 16 bit Little Endian, Rate 48000
> Hz, Stereo
> real    3m 0.10s
> user    0m 0.22s
> sys     0m 8.48s

9s / 180s = 5%

> > And what does your program do when avail_update returns 0 frames?
> 
> If it returns 0 then I do not write any frames.  I then check the next
> stream.  This continues in an infinite loop.

When the program is looping and waiting for some free space to become
available in any of the eight buffers, it doesn't actually process
audio data.  (And you should use poll() with all eight handles so that
you don't eat CPU while waiting.)

The aplay experiment above tells me that your program spent 95% of
its time calling snd_pcm_avail_update.  In that time, you could
decode instead.

> > You cannot write data faster than it's playing; the audio ring buffer
> > has a finite size.
> >
> > You would have a problem if the processing and/or the driver would
> > make everything so slow that you wouldn't be able to write new data
> > to the device fast enough, which would result in an buffer underrun.
> > Does this actually happen?
> 
> I am currently writing the decoded mp3 data to a buffer in RAM so that
> the program is decoding the mp3 data as fast as it can.  I then run
> the audio process separately and just play silence.  I am doing this
> so that I can tell how much time is being spent decoding mp3 data and
> processing audio data so that I know how much time remains for other
> tasks.

Playing silence is not any faster than playing anything else, because
the sound card _cannot_ run faster than the configured sample rate.


Regards,
Clemens
