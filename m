From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [pulseaudio-discuss] idea: a reserve alsa plugin
Date: Thu, 02 May 2013 16:37:47 +0200
Message-ID: <51827A3B.9040907@canonical.com>
References: <51824609.30405@canonical.com> <2131647.YQz4O6jht3@deuteros>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F57B2651EC
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2013 16:37:50 +0200 (CEST)
In-Reply-To: <2131647.YQz4O6jht3@deuteros>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tvrtko Ursulin <tvrtko.ursulin@onelan.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

On 05/02/2013 04:28 PM, Tvrtko Ursulin wrote:
>
> Hi David,
>
> On Thursday 02 May 2013 12:55:05 David Henningsson wrote:
>> Just had an idea which I'll write down here before I forget it
>> again...and I'm not saying I'll implement this anytime soon either, but
>> here goes:
>>
>> There is a device reserve protocol between PulseAudio and JACK2 - when
>> JACK needs the sound card, it'll send a dbus message to PulseAudio and
>> grab a name in D-Bus.
>>
>> However, there are plenty of applications who like to access ALSA
>> directly, without going through JACK2 or PulseAudio. By making a
>> "reserve" plugin, we could have this functionality for those apps too.
>>
>> In practice, if the app usually opens "plughw:0" or "hw:0", it could
>> instead open "reserve:plughw:0" or "reserve:hw:0" to also reserve the
>> device from PulseAudio usage while the device is open. Meanwhile,
>> PulseAudio is free to use other audio devices (which is not the case
>> when using e g pasuspender).
>>
>> How does that sound?
>
> If I understand correctly you are saying essentially this:
>
> 1. There is an existing device control protocol which works over DBus.
> 2. Your idea is to add a equivalent device control protocol using ALSA PCM
> plugin (well in fact not add but create a new proxy interface to it).
>
> Is that right? If so, how do you provide this functionality to existing
> applications without teaching them about the reserve plugin?

Many ALSA applications lets you specify the device string on e g the 
command line or through a configuration interface. So the end user would 
configure the application to use "reserve:plughw:0" instead of "plughw:0".

The applications that do not follow this will have to be taught, and 
they have a extremely simple way to implement it - just add "reserve:" 
do the device string.

>
> And if you have to modify the applications, is the only advantage then that
> you do not have to add DBus dependency to them? Or a PA dependency to talk
> directly to the server? If so then this solution feels a bit kludgy.
>
> Perhaps you would want an extension to snd_pcm_open (or whatever, I am going
> from vague memory here) to have something like "SND_PCM_EXCLUSIVE |
> SND_PCM_NOTIFY_BUSY_OPEN" mode (if the former is not implied) which would
> notify the original owner that the second application is attempting to open
> it. Perhaps using SIGURG or something while returing -EBUSY or something to
> the caller signalling they should retry. Not sure if this would be doable
> completely in userspace so I might be leading you toward a generic
> kernel/glibc solution here. :)
>
> What about the policy control as to which applications are allowed to take
> over? It sounds sub optimal to allow any ALSA application which knows about
> this new plugin or other release mechanism to take over just like that. That
> would create a bit of a mess.

That is a valid point - but so far the only app that can *give away* a 
sound card is PulseAudio. All of the others (at least in the simplest 
scenario), can only *take* a sound card. If the card is already used by 
some app that can't give away its sound card, it's going to be -EBUSY as 
usual.



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
