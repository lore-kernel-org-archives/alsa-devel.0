From: Tvrtko Ursulin <tvrtko.ursulin@onelan.co.uk>
Subject: Re: idea: a reserve alsa plugin
Date: Thu, 02 May 2013 15:28:47 +0100
Message-ID: <2131647.YQz4O6jht3@deuteros>
References: <51824609.30405@canonical.com>
Reply-To: General PulseAudio Discussion
	<pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pulseaudio-discuss-bounces+gcapd-polypaudio-discuss=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <51824609.30405@canonical.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Sender: pulseaudio-discuss-bounces+gcapd-polypaudio-discuss=m.gmane.org@lists.freedesktop.org
Errors-To: pulseaudio-discuss-bounces+gcapd-polypaudio-discuss=m.gmane.org@lists.freedesktop.org
To: pulseaudio-discuss@lists.freedesktop.org
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Hi David,

On Thursday 02 May 2013 12:55:05 David Henningsson wrote:
> Just had an idea which I'll write down here before I forget it
> again...and I'm not saying I'll implement this anytime soon either, but
> here goes:
> 
> There is a device reserve protocol between PulseAudio and JACK2 - when
> JACK needs the sound card, it'll send a dbus message to PulseAudio and
> grab a name in D-Bus.
> 
> However, there are plenty of applications who like to access ALSA
> directly, without going through JACK2 or PulseAudio. By making a
> "reserve" plugin, we could have this functionality for those apps too.
> 
> In practice, if the app usually opens "plughw:0" or "hw:0", it could
> instead open "reserve:plughw:0" or "reserve:hw:0" to also reserve the
> device from PulseAudio usage while the device is open. Meanwhile,
> PulseAudio is free to use other audio devices (which is not the case
> when using e g pasuspender).
> 
> How does that sound?

If I understand correctly you are saying essentially this:

1. There is an existing device control protocol which works over DBus.
2. Your idea is to add a equivalent device control protocol using ALSA PCM 
plugin (well in fact not add but create a new proxy interface to it).

Is that right? If so, how do you provide this functionality to existing 
applications without teaching them about the reserve plugin?

And if you have to modify the applications, is the only advantage then that 
you do not have to add DBus dependency to them? Or a PA dependency to talk 
directly to the server? If so then this solution feels a bit kludgy. 

Perhaps you would want an extension to snd_pcm_open (or whatever, I am going 
from vague memory here) to have something like "SND_PCM_EXCLUSIVE | 
SND_PCM_NOTIFY_BUSY_OPEN" mode (if the former is not implied) which would 
notify the original owner that the second application is attempting to open 
it. Perhaps using SIGURG or something while returing -EBUSY or something to 
the caller signalling they should retry. Not sure if this would be doable 
completely in userspace so I might be leading you toward a generic 
kernel/glibc solution here. :)

What about the policy control as to which applications are allowed to take 
over? It sounds sub optimal to allow any ALSA application which knows about 
this new plugin or other release mechanism to take over just like that. That 
would create a bit of a mess.

Regards,

Tvrtko
