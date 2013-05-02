From: Tvrtko Ursulin <tvrtko.ursulin@onelan.co.uk>
Subject: Re: idea: a reserve alsa plugin
Date: Thu, 02 May 2013 15:50:35 +0100
Message-ID: <1817655.rAjill4Xyc@deuteros>
References: <51824609.30405@canonical.com> <2131647.YQz4O6jht3@deuteros>
	<51827A3B.9040907@canonical.com>
Reply-To: General PulseAudio Discussion
	<pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pulseaudio-discuss-bounces+gcapd-polypaudio-discuss=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <51827A3B.9040907@canonical.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Sender: pulseaudio-discuss-bounces+gcapd-polypaudio-discuss=m.gmane.org@lists.freedesktop.org
Errors-To: pulseaudio-discuss-bounces+gcapd-polypaudio-discuss=m.gmane.org@lists.freedesktop.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

On Thursday 02 May 2013 16:37:47 David Henningsson wrote:
> On 05/02/2013 04:28 PM, Tvrtko Ursulin wrote:
> > Hi David,
> > 
> > On Thursday 02 May 2013 12:55:05 David Henningsson wrote:
> >> Just had an idea which I'll write down here before I forget it
> >> again...and I'm not saying I'll implement this anytime soon either, but
> >> here goes:
> >> 
> >> There is a device reserve protocol between PulseAudio and JACK2 - when
> >> JACK needs the sound card, it'll send a dbus message to PulseAudio and
> >> grab a name in D-Bus.
> >> 
> >> However, there are plenty of applications who like to access ALSA
> >> directly, without going through JACK2 or PulseAudio. By making a
> >> "reserve" plugin, we could have this functionality for those apps too.
> >> 
> >> In practice, if the app usually opens "plughw:0" or "hw:0", it could
> >> instead open "reserve:plughw:0" or "reserve:hw:0" to also reserve the
> >> device from PulseAudio usage while the device is open. Meanwhile,
> >> PulseAudio is free to use other audio devices (which is not the case
> >> when using e g pasuspender).
> >> 
> >> How does that sound?
> > 
> > If I understand correctly you are saying essentially this:
> > 
> > 1. There is an existing device control protocol which works over DBus.
> > 2. Your idea is to add a equivalent device control protocol using ALSA PCM
> > plugin (well in fact not add but create a new proxy interface to it).
> > 
> > Is that right? If so, how do you provide this functionality to existing
> > applications without teaching them about the reserve plugin?
> 
> Many ALSA applications lets you specify the device string on e g the
> command line or through a configuration interface. So the end user would
> configure the application to use "reserve:plughw:0" instead of "plughw:0".
> 
> The applications that do not follow this will have to be taught, and
> they have a extremely simple way to implement it - just add "reserve:"
> do the device string.

Ah yes I forgot about this configurability. Which also means the question of 
central policy is sorted since it is explicit user configuration to steal a 
device.

It is still a bit kludgy for a PCM plugin to do this, but, it solves a real 
problem and does it cheaply so I think the result justifies the means in this 
case.

Regards,

Tvrtko

P.S. I am not active in this field but just dropping in due personal interest 
in this functionality.
