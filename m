From: "Rui Nuno Capela" <rncbc-d0bMj/AywobYtjvyW6yDsg@public.gmane.org>
Subject: Re: Linux/Alsa Tascam US-122 Issues
Date: Tue, 28 Sep 2004 09:14:49 +0100 (WEST)
Sender: linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Message-ID: <39452.195.245.190.93.1096359289.squirrel@195.245.190.93>
References: <1096223695l.3281l.0l@Zeryn>   
	<200409271157.14861.annabellesgarden@yahoo.de>   
	<38541.195.245.190.94.1096281640.squirrel@195.245.190.94>   
	<1096328215l.25915l.0l@Zeryn>
Reply-To: "The Linux Audio Developers' Mailing List"
	<linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
In-Reply-To: <1096328215l.25915l.0l@Zeryn>
List-Unsubscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=unsubscribe>
List-Archive: <http://music.columbia.edu/pipermail/linux-audio-dev>
List-Post: <mailto:linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
List-Help: <mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=help>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=subscribe>
Errors-To: linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
To: Antonio Willy Malara <behappy-3P0L4Tc7aotWk0Htik3J/w@public.gmane.org>
Cc: alsa-devel <alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Martin Langer <martin-langer-Mmb7MZpHnFY@public.gmane.org>, Werner Schweer <ws-XKvGbLkbjOk@public.gmane.org>, The Linux Audio Developers' Mailing List <linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Antonio Willy Malara wrote:
>
>Rui Nuno Capela wrote:
>
>> Karsten Wiese wrote:
>> > I've got something cooking to solve this, but don't know when it will
>> > be ready.
>
> really!?!?!? THANX!!! :)
>
>> AFAICR, the last alsa-driver release version from which snd-usb-usx2y
>> worked barely was 1.0.5a. I do remember also that it was somewhat
>> unstable, specially regarding jackd support, but IMMV.
>
> thanks for the infos!! infact downgrading to 1.0.5a works well.. uhm..
> not really well, with oss emulation it has a PERFECT sound, the only alsa
> app i use (would to) is jack, but it will kick itself out after really
> few second of operation, even with -R switches and so..
>

As of yesterday, after applying the Karten's cooking patch on top of
alsa-kernel CVS HEAD (which is about 1.0.7rc1) I've got partial success,
at least the kernel doesn't oops anymore.

You can follow the details on ALSA bugtracker bug #0000425
(https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000425).

The fact is that 1.0.7rc1 with this usx2y+ohci patch works fine with alsa
native interface (e.g. aplay -D hw:x), but jackd hangs on some
pcm_prepare() loop, being ultimately killed by jack_watchdog.

I can't tell for sure, but AFAICR and Antonio seems to confirm, this jackd
behaviour is exactly the same as the one of 1.0.5a: aplay OK, jackd HANGS.

That said, I guess we're back in business nevertheless, on the OHCI arena
at least.

OTOH, Karsten is also cooking a experimental usx2y jack backend that
recently made a great success around here (erm, that was on my desktop, a
UHCI  based one). Very promising stuff. So promising, that I've already
added support for it on my qjackctl CVS tree :)

I just wonder if we can merge these and test whether things get any
better. But Karsten may have even better ideas... ;)

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc-d0bMj/AywobYtjvyW6yDsg@public.gmane.org
