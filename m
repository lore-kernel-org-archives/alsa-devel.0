From: Adam Rosenberg <adam@alcorn.com>
Subject: Re: ALSA processor usage is too high
Date: Fri, 5 Nov 2010 11:19:53 -0400
Message-ID: <AANLkTinXm2G1y477xRTc_QjXuEZ_nyAqGWuSkq32KGe2@mail.gmail.com>
References: <AANLkTik-sb1OihaDhNgptH44gQ4__E+ozxhSKpA9GdSK@mail.gmail.com>
	<4CD41528.1060600@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C4D6103965
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2010 16:20:14 +0100 (CET)
Received: by wwi17 with SMTP id 17so1215265wwi.20
	for <alsa-devel@alsa-project.org>; Fri, 05 Nov 2010 08:20:13 -0700 (PDT)
In-Reply-To: <4CD41528.1060600@ladisch.de>
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

On Fri, Nov 5, 2010 at 10:31 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Adam Rosenberg wrote:
>> I am trying to decode 8 MP3 files simultaneously. =A0Each file is 3
>> minutes 11 seconds long. =A0When I just decode the files and copy the
>> PCM data to memory it takes 2 minutes 36 seconds. =A0When I do the same
>> test after opening 8 ALSA PCM streams and while writing data to them
>> it takes 4 minutes 37 seconds. =A0This is much too slow for what should
>> be a simple copy operation.
>
> Are you using the "hw" device? =A0Otherwise, it's not a simple copy op.

I am using the hw device for each stream.

>
> How much CPU does "aplay -D hw -t raw -f dat /dev/zero" use?
>

I do not know how to calculate CPU usage for a given process.

All of my calculations have just been done by running the application
I wrote (which has to do a number of other things while decoding mp3
data and playing audio).  I time the application from start to finish
to determine if it is handling all of the tasks in an acceptable
amount of time.

For the audio playback I am polling the streams using
snd_pcm_avail_update() and then writing the number of frames available
using snd_pcm_writei().  I am trying to squish this whole project into
2mb of flash so I will not be able to include aplay in the final os
image.

I am able to add aplay for testing so I used your command to open the
8 streams, removed the audio processing from my application, and ran
the test again.  The result was 4 minutes and 35 seconds, which is
basically the same as the result from the test within my application
and much too slow.

Thanks,
Adam
