From: "=?UTF-8?Q?Rafael_Esp=C3=ADndola?=" <rafael.espindola@gmail.com>
Subject: Re: Fwd: [PATCH] sound working on the macbook pro
Date: Tue, 20 Feb 2007 20:05:49 +0000
Message-ID: <564d96fb0702201205i11beca64g11ca9602a53ad433@mail.gmail.com>
References: <564d96fb0702180906u6dc0f0d9k2cd1d5e1409f1911@mail.gmail.com>
	<564d96fb0702180924y32118e7esf81e5ec2514d3af9@mail.gmail.com>
	<s5hps8674an.wl%tiwai@suse.de>
	<564d96fb0702200140u7aee7dfbt271ed3818ed92366@mail.gmail.com>
	<s5hhcthrq3c.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hhcthrq3c.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> OK, this is basically the problem of stac92xx_add_dyn_out_pins() that
> it adds surrounds unconditionally.
> (BTW, just a curisotiy - would these surround and/or CLFE work as
>  outputs?  Or does it have no [mic/line] input jack?)

The control status with the FIX-UP (and the new pin config) is:
Master: controls the hp volume
Front: dummy
Surround: dummy
Center: dummy
LFE: dummy

> > 4) stac92xx_auto_create_hp_ctls doesn't run add_spec_dacs or
> > create_controls for the speaker. It then creates a control name Master
> > instead of Headphone.
>
> Hm, I don't get this yet.
The speaker was moved to line_out, so cfg->speaker_outs == 0.

>  The current auto-config code in
> patch_sigmatel isn't 100% suitable for the laptop-style configurations
> but rather for the desktop machines.  So, we need a slight redesign of
> the configurator at first.  Let's get things straight now.
>
> Please write down the pins you have on your device and what controls
> should appear.  I suppose you have
>
> - a HP pin
> - a speaker pin
> - a mic-in pin
> What else?  And, for these controls, we'll have
>
> - Speaker volume/switch
> - Headphone volume/switch
> - Captuer volume/switch
> - Input Mux
>

the mac book pro has a built in speaker, a built in microphone and two
jacks. One is a spdif output and headphone. The other one is a spdif
in and a line in.

The controls should be:
Speaker, Microphone, select builtin mic/line-in . I am not sure if
there should be two different controls or one control and one select
switch for the mic/line-in. Currently I also have IEC958 to turn on
the spdif output.

I don't have any spdif equipment. I also don't have an external
microphone, but I am sure I can get one for testing.

> but no Master (as STAC codec controls these outputs individually).
Right. I love that :-)

> Yes, there is certainly a room for improvements.
> For example, we can add another field to indicate what is the primary
> output type (line-out, speaker, HP) and stop moving the pin
> information itself, so that the check of primary output is kept as
> simple as now, and the original information won't be lost.
I will give it a try latter on.

> Takashi
>

Rafael

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
