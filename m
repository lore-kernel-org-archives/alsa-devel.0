From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Implementing sync start
Date: Mon, 10 Aug 2009 07:45:35 -0400
Message-ID: <9e4733910908100445u3ea02395y9dc39b73ad41cb6b@mail.gmail.com>
References: <9e4733910908081116p221e606cma31a95b06d9b5be6@mail.gmail.com>
	<9e4733910908082007n5d2e7f48g453b1f2e3c6eb23e@mail.gmail.com>
	<9e4733910908091913j63debfefja44e8e04e278e087@mail.gmail.com>
	<9e4733910908091919o617eb1b8r44436cd87a6873ff@mail.gmail.com>
	<4A7FCF0A.1000806@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 26B3E1037F9
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Aug 2009 13:45:36 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c37so945590anc.2
	for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2009 04:45:35 -0700 (PDT)
In-Reply-To: <4A7FCF0A.1000806@ladisch.de>
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
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 10, 2009 at 3:40 AM, Clemens Ladisch<clemens@ladisch.de> wrote:
> Jon Smirl wrote:
>> Here's how I implemented sync start/stop.......
>
> Have a look at oxygen_trigger() in sound/pci/oxygen/oxygen_pcm.c for a
> working sync start/stop implementation.
>
>> =A0 =A0 =A0 snd_pcm_group_for_each_entry(substream, sub) {
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtd =3D substream->private_data;
>
> There is no guarantee the all linked substreams belong to the same card
> or the same driver; you have to check that first and ignore streams you
> don't know about.

ok

>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sub !=3D substream)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_pcm_trigger_done(substre=
am, sub);
>
> You can just call snd_pcm_trigger_done() for every substream you handle.

ok

>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ...
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 return 0;
>
> There is no common code for the two substreams.
> Is your hardware actually capable of starting them at exactly the same
> time?

Sync start is working. This is in the loop and starts the streams:
   bcom_enable(s->bcom_task);
s is set to two different values in the loop.

I'm having problems with the drain error on stop.

>
>
> Best regards,
> Clemens
>



-- =

Jon Smirl
jonsmirl@gmail.com
