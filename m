From: "Joshua J. Kugler" <joshua@azariah.com>
Subject: Re: Problem with timing and USB scanning...
Date: Wed, 22 Oct 2014 21:31:16 -0800
Message-ID: <1550200.IEyPMVlB9F@hosanna>
References: <5078808.P2JmJn6G2E@hosanna> <6193432.QnYu1kqnSE@hosanna>
 <CAN8ccibDFnqzYjh64zgF-9SiBn0m-MvQ+Jhg9q=3NGJ=YO4ZMg@mail.gmail.com>
Reply-To: General PulseAudio Discussion
 <pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <CAN8ccibDFnqzYjh64zgF-9SiBn0m-MvQ+Jhg9q=3NGJ=YO4ZMg@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
Sender: "pulseaudio-discuss" <pulseaudio-discuss-bounces@lists.freedesktop.org>
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

On Thursday, October 23, 2014 13:13:19 Raymond Yau wrote:
> Unfotunately, you need to fix many things in kernel

Well, I'm an end user, not a kernel hacker, so I don't see it getting fixed any 
time soon. :)

> Is this a notebook with internal 5.1 speakers with three jacks at rear
> panel (headphone , mic and line in) ?

Notebook: yes
Internal 5.1? I don't believe so.
Headphone, mic, line in? Yes.

> 1) large volume range of mic capture
> Volume and speaker playback volume
> 
> 
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/usb/mixer.c?id=9b4ef97757953c6071563b7cbfc689e3dd771603

Are you saying there is a large range on the internal mic? or on the USB mic?

> 2) your 5.1 internal speaker have same priority
Which priority are we discussing?  Somewhere in udev?  In pulse audio? Or in 
the KDE audio setup?  And this original thread wasn't about speakers.  The USB 
out works fine, every time.  My issue is this: when I try to hotplug the USB 
headset, it comes up as a *output* device only, instead of also detecting the 
mic.

Also, this worked flawlessly in Ubuntu 12.04 (pulse-audio 1.1, kernel 3.2-3.8). 
It is only since upgrading to pulse-audio 4.0 and kernel 3.13.x that i have a 
problem.

j


-- 
Joshua J. Kugler - Fairbanks, Alaska
Azariah Enterprises - Programming and Website Design
joshua@azariah.com - Jabber: pedahzur@gmail.com
PGP Key: http://pgp.mit.edu/  ID 0x73B13B6A
