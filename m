From: Sean McNamara <smcnam@gmail.com>
Subject: Re: Exclusive access to capture device
Date: Sun, 24 Jun 2012 17:03:46 -0400
Message-ID: <CAPAActd061w8OvHR0iG+vMqTpvQYV95SfV42g_rgNF2+eBqV+g@mail.gmail.com>
References: <CADfV-LHztneYAZJusarOSTv3qXuECWqrQajqLEKCsJC82yvULA@mail.gmail.com>
	<CADfV-LGfSwGU6fdBeWqtW4-4rpux0NeneV=7uEe4dFbyBs9NGA@mail.gmail.com>
	<CAPAActe9s54_8BiwiR+wrWUTfOtzAEJ6ycAhWaeK2h9EgoLBDQ@mail.gmail.com>
	<CADfV-LFEoFa7moFiR7AiJBGwJkTPpVbh=uV0KpwG8PjqTG46Qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
	[209.85.212.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 525CB24396
	for <alsa-devel@alsa-project.org>;
	Sun, 24 Jun 2012 23:03:48 +0200 (CEST)
Received: by wibhm6 with SMTP id hm6so1336707wib.2
	for <alsa-devel@alsa-project.org>; Sun, 24 Jun 2012 14:03:46 -0700 (PDT)
In-Reply-To: <CADfV-LFEoFa7moFiR7AiJBGwJkTPpVbh=uV0KpwG8PjqTG46Qw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Jun 24, 2012 at 4:48 PM, Guy Rutenberg <guyrutenberg@gmail.com> wrote:
> Hi Sean,
>
> On Sun, Jun 24, 2012 at 11:31 PM, Sean McNamara <smcnam@gmail.com> wrote:
>>
>>
>> Hopefully you aren't writing a desktop application, because distros
>> and users generally abhor the notion of an application "hogging" the
>> sound device for any reason, and would prefer that all access be
>> non-exclusive. But if you're coding for an embedded device, then I can
>> understand this approach.
>>
>> I'm actually writing a desktop application. The idea is to extract random
> bits from microphone in order to create a true random number generator
> (after being extracted the bits go through an unbiasing phase and
> compression by a hash function to increase entropy). So I intentionally
> want to hog the sound device, as to be sure that nobody else is recording
> at the same time I'm gathering entropy.
>
> So basically I want to temporarily disable any hardware/software mixing on
> the mixing device. Is it possible given user privileges? Assuming
> root privileges?

Anything is possible with root privileges. You could run `fuser' or
`lsof' and find all the processes accessing /dev/snd/* and SIGKILL
them, and then do your capture. You could parse /etc/asound.conf and
figure out whether the default sound device is a software mixer or
pointing to a hardware device by detecting strings like "hw:0". You
could detect the hardware being used and refuse to operate if the user
is running a card with hardware mixing. You can do a lot of really
nasty, imho stupid things.

In the general case of running general hardware on a general desktop
Linux distribution, I would really strongly advise you NOT to attempt
to reconfigure the user's sound system, kill daemons or applications,
or otherwise "hog" the sound device, unless you are only doing this
"in-house" on systems you have full control over. I can guarantee you
that users will take significant beef with your program if you try to
distribute your software to the general public.

Besides, ALSA is open source, so someone could effectively counter
your attempts in an infinite number of ways, by writing their own
modified libasound that lies to you and makes you *think* you have
exclusive access when you really don't. Ditto for the kernel.

There is no way to absolutely *prevent* an untrusted system from doing
anything. If the *user* of the system has root, and you're just a
program, guarantees are meaningless. They could have a custom
filesystem that makes you think that /dev/snd/* are hardware ALSA
devices, but are in fact just CUSE devices from the kernel, feeding
you a pre-determined stream of integers.

Sounds like you're trying to do something with DRM or randomly
generating crypto certificates or something. Use an interface that's
more reliable and draw from /dev/urandom or something -- ALSA is not
designed to be part of a security system. Even if there were a
parameter to snd_pcm_open() that let you explicitly ask for exclusive
access, all bets are off if you don't trust every single bit of
executable code on the system.

This is why I said "if you are on an embedded platform" then this
would make sense, because embedded developers typically control
everything from the hardware up. But even then, every single Android
device to market has been rooted so far, so....

If you're looking for good sources of entropy, look at the code that
OpenSSL uses for generating RSA private keys. It's still not
completely airtight because, like I said, any "external" sources that
you rely on for entropy could easily be preempted by the user or a
virus to feed you pre-determined sequences of numbers; but OpenSSL
does it pretty good to the extent that the user and their software
stack are not trying to fool you on purpose.

Good luck,

Sean

>
> Thanks,
>
> Guy
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
