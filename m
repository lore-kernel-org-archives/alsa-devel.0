From: "Sean McNamara" <smcnam@gmail.com>
Subject: Re: View alsa-lib plugins setup for any app?
Date: Tue, 21 Oct 2008 23:51:30 -0400
Message-ID: <74eb1fe20810212051v1f6bc6fbh645c149f039acb48@mail.gmail.com>
References: <48FD3070.7080406@audioscience.com> <s5h1vyaa22e.wl%tiwai@suse.de>
	<200810220955.01218.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 50A6B243CB
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Oct 2008 05:51:49 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id l35so1438166waf.16
	for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2008 20:51:30 -0700 (PDT)
In-Reply-To: <200810220955.01218.linux@audioscience.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eliot Blennerhassett <linux@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 21, 2008 at 4:55 PM, Eliot Blennerhassett
<linux@audioscience.com> wrote:
> On Tuesday 21 October 2008 19:34:49 Takashi Iwai wrote:
>> Sorry, I don't understand well your question.  Do you want to see the
>> alsa-plugin chain of a running application from the outside,
>
> Yes. Basically see something that looks like the result of "aplay -v", but for
> a running app from the outside.
>
> E.g. to see if the app is using dmix, plughw etc, what parameters the app sees
> vs how the card is accessed.
>
> Best if this info was available like the proc files for the driver, but if it
> required running the app in a special context (debugger-like or LD_PRELOAD)
> that would probably still be useful.

If LD_PRELOAD is acceptable, then write a simple library that
1. Causes the linker to call _your_ snd_pcm_open() function when the
app calls snd_pcm_open().
2. Captures the second parameter to snd_pcm_open -- namely, the
specified device string.
3. You can call snd_pcm_dump using the result of snd_pcm_open; or, you
can just print out the device string and do your own diagnostics on it
manually, like run an aplay -v --device=${devstring} /blah.wav and see
what it produces. It's pretty much the same result though.
4. Call into the normal snd_pcm_open, passing its arguments on.

Quintessential examples of C function "overloading" (in the
object-oriented sense) using the LD_PRELOAD hack can be found in
things such as the aoss program (which just LD_PRELOADs
libalsa-oss.so), padsp, and so on.

If a tracing tool (of which the simplest I can think of is gdb) is
acceptable, then
gdb ./some_compiled_binary

and in gdb:
break snd_pcm_open
[y]
start
continue
x/s name

Note that you'll have to build ALSA with debugging symbols (or install
an alsa-lib debugging symbols package from your distro, if available)
to do this, but you won't have to have the debugging symbols of your
main binary or any of its other (non-ALSA) libraries.

Other than (1) modifying the ALSA source to provide some
out-of-process runtime access, (2) debugging, or (3) LD_PRELOAD,
there's not really much you can do to take a precompiled arbitrary
binary (with or without debugging symbols, with or without source
code) and introspect which device string it's trying to open, and what
the resulting plugins/devices end up being based on the device string
that's been specified. Any useful information on this currently comes
from within the ALSA client process, so you need to get into its
execution flow somehow; gdb and LD_PRELOAD are the swiss army knives
of doing just that.

HTH,

Sean

>
> The app should not have to be recompiled.
>
>
>> or do you
>> ask an API to show the alsa-plugin chains,
>
> no. Now I see that you are thinking of snd_pcm_*_dump() family.
>
>> or a way to show hw_params/sw_params for plugins?
>
> I this is included in my first "yes"
>
> regards
>
> Eliot
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
