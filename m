From: "Ivica Ico Bukvic" <ico-rDkNP/OoUoU@public.gmane.org>
Subject: RE: snd-hdsp+cardbus=distortion -- the
	sagacontinues (cardbus driver=culprit?) UPDATE: 99.9% sure it
	is the cardbus driver yenta_socket
Date: Tue, 30 Mar 2004 00:52:11 -0500
Sender: linux-audio-user-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Message-ID: <20040330055204.UUGL2042.smtp1.fuse.net@64BitBadass>
References: <20040329235823.04bacef4@laptop>
Reply-To: A list for linux audio users <linux-audio-user-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-audio-user-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
In-Reply-To: <20040329235823.04bacef4-2T+B9ReNDUQ@public.gmane.org>
List-Unsubscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-user>,
	<mailto:linux-audio-user-request-oG0YroN0ZiqENrSoib9kfocZ5a6xMsm1v5P9MsFVvkkBB/WhxxnpHQ@public.gmane.org>
List-Archive: <http://music.columbia.edu/pipermail/linux-audio-user>
List-Post: <mailto:linux-audio-user-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
List-Help: <mailto:linux-audio-user-request-oG0YroN0ZiqENrSoib9kfocZ5a6xMsm1aFUAG64dwko@public.gmane.org>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-user>,
	<mailto:linux-audio-user-request-oG0YroN0ZiqENrSoib9kfocZ5a6xMsm1+iqrErVy8Mf2+df2TVCvIA@public.gmane.org>
Errors-To: linux-audio-user-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
To: 'A list for linux audio users' <linux-audio-user-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>, alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pcmcia-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Here's the update on the issue (at least from my aspect):

TODO:
1) provide detailed lspci
(will do later tomorrow, too tired right now)

2) thoroughly check /var/log/syslog for anything suspicious
Apart from the ACPI and APIC problems, nothing out of the ordinary (i.e.
APIC assigns IRQ 0 to cardbus and therefore nothing works, but if I disable
APIC it's all ok. Furthermore, I've just yesterday fixed the ACPI and APIC
problems by patching the kernel yet the problem persists. Right now the
laptop boots with ACPI and APIC turned on, IRQ's get assigned properly, as a
matter of fact EXACTLY the same like in Windows where the problem does not
occur. Therefore, now the assumption that there is a "sweet" IRQ I need to
select does not stand any more, as the same problem is exhibiting itself
when the cardbus is at IRQ 11 (no ACPI/APIC) or at 17 (with ACPI/APIC and
also the same IRQ as in WinXP). This now leads me to believe that the
problem is strictly limited to the yenta_socket driver.

3) try pcmcia-cs (most likely won't work as Tim already tried that and it
made no difference on his laptop, also the package wasn't updated since
Dec.)

This is not an option, as Tim pointed out, not only because this package
only works with pre 2.5 kernels but also because it has been tested by Tim
and had no difference.

4) try playback with an external Word Clock source
Will try tomorrow (although I don't think so, as the card appears to work
just fine on other Linux notebook).

5) provide downloadable examples of the distorted sounds
(will do tomorrow). But by briefly looking at it, it definitely looks the
same like Tim's (image found here:
http://www.volny.cz/guitar_billy/hdsp.screenshot.png) where it seems like
the sound has one small burst of audio data, then the comparably-sized
streak of no change in data. There is still some distortion which I am not
sure whether it is a result of this kind of misperformance of the sound or
there is more to the story.

6) Pester alsa-dev, lau, and kernel/pcmcia people to death begging for help
:-)

IN-PROGRESS :-)

7) Pester eMachines to update BIOS (I may retire before this one happens,
though)

I did get through to someone and they did reply to my e-mail seeming
interested in cooperating to resolve the issue, but at this point it does
not seem like the BIOS is the culprit.


8) Something else?
How about I go catch some z's :-)

Good idea...


Best wishes,

Ico
