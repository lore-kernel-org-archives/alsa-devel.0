From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: [alsa-devel] [RFC] disabling ALSA period
	interrupts
Date: Wed, 12 May 2010 12:10:13 -0500
Message-ID: <AANLkTilFAbNRyYFCX-gjAIkUSL01OyRyqNnbhu0Bb5bC@mail.gmail.com>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
	<20100507232516.GB16910@tango.0pointer.de>
	<s2r6160a5131005072012o24609ce9q421ed2def04e4728@mail.gmail.com>
	<AANLkTimUaGy7NirNI78duHwGe3V72s_1eUiby_Rb_dRq@mail.gmail.com>
	<alpine.LNX.2.00.1005121452230.6856@eeebox2.perex-int.cz>
Reply-To: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pulseaudio-discuss-bounces@mail.0pointer.de>
In-Reply-To: <alpine.LNX.2.00.1005121452230.6856@eeebox2.perex-int.cz>
List-Unsubscribe: <https://tango.0pointer.de/mailman/options/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=unsubscribe>
List-Archive: <https://tango.0pointer.de/pipermail/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@mail.0pointer.de>
List-Help: <mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=help>
List-Subscribe: <https://tango.0pointer.de/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=subscribe>
Sender: pulseaudio-discuss-bounces@mail.0pointer.de
Errors-To: pulseaudio-discuss-bounces@mail.0pointer.de
To: Jaroslav Kysela <perex@perex.cz>
Cc: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> Please, use tabs for block indention for alsa-lib.

Right, I used the same .emacs style for pa and alsa-lib...Fixed now

> Are you sure that you're using new libraries? 'ldd' and 'nm' tools will help
> you to determine what's wrong with symbols.

Argh.. For some reason Fedora has a preinstalled libasound in
/lib...So when I installed the new alsa-lib in /usr, PA knew about the
include file but used the old lib. Thanks for the tip.


> Ignore this. I don't know about any place where r->cond is used (!= 0) in
> the current ALSA driver, so eating one more bit from params->flags is OK.
> Just put the kernel asound.h in sync with library asound.h.

ok. It works just fine now. Can I send a patch against alsa-kmirror or
do you prefer against alsa-kernel? I use the former to recompile only
the audio modules.
