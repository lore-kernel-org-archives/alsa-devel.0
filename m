From: Adam Rosenberg <adam@alcorn.com>
Subject: Re: ALSA processor usage is too high
Date: Fri, 5 Nov 2010 15:27:01 -0400
Message-ID: <AANLkTi=7pEPATKneHvZ-U-v7RUe90X-YSR-fqhF3bNx6@mail.gmail.com>
References: <AANLkTik-sb1OihaDhNgptH44gQ4__E+ozxhSKpA9GdSK@mail.gmail.com>
	<4CD41528.1060600@ladisch.de>
	<AANLkTinXm2G1y477xRTc_QjXuEZ_nyAqGWuSkq32KGe2@mail.gmail.com>
	<4CD445BD.3020501@ladisch.de>
	<AANLkTi=kMF=_1u40yTtvA=oSpyyQn=nEF_JHY_NskiAw@mail.gmail.com>
	<4CD456AE.7090302@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 789021037EE
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2010 20:27:22 +0100 (CET)
Received: by wwi17 with SMTP id 17so1448372wwi.20
	for <alsa-devel@alsa-project.org>; Fri, 05 Nov 2010 12:27:22 -0700 (PDT)
In-Reply-To: <4CD456AE.7090302@ladisch.de>
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

On Fri, Nov 5, 2010 at 3:10 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> When the program is looping and waiting for some free space to become
> available in any of the eight buffers, it doesn't actually process
> audio data. =A0(And you should use poll() with all eight handles so that
> you don't eat CPU while waiting.)

I can't use poll because the application has to perform many other
tasks in a deterministic manner (meaning I can only use threads and
other processes to notify the main loop to perform some task).  I
tried using the async callback method so that I could set a flag when
it was time to copy more audio data to the stream but that didn't seem
to work well with multiple streams.  I found that polling using
avail_update was the only reliable method.  Could you provide an
alternative example that is known to work with multiple streams in the
same application?

>
> The aplay experiment above tells me that your program spent 95% of
> its time calling snd_pcm_avail_update. =A0In that time, you could
> decode instead.

Sorry for the confusion, the main loop of my application basically does thi=
s:
while(1)
{
  processNextAlsaStream();
  processMp3Decoder();
  processLCD();
  processInputs();
  processSerial();
}

so the processNextAlsaStream() function just calls avail_update for
the next stream in my list of 8 streams and then handles the result
before allowing the loop to process the next task.

>
> Playing silence is not any faster than playing anything else, because
> the sound card _cannot_ run faster than the configured sample rate.
>

I agree.  I only mentioned it was silence so that it was understood I
have a static buffer that I am copying audio frames from so there is
no other processing needed (no reading from a file, etc).

Thank you for your help, I am happy to be discussing this with you all
as it makes me feel as though I am not totally lost.  Please let me
know if you have an example of a program that can efficiently handle
multiple PCM streams.

Thanks!
Adam
