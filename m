From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: A plea for help on mixer support for Fast Track
 Ultra (8R)
Date: Thu, 19 May 2011 10:14:26 +0200
Message-ID: <4DD4D162.20608@showlabor.de>
References: <4DD3E39D.30100@showlabor.de>	<BANLkTinCn2Q+asKhGAoq+3S+AtqyHrg2wg@mail.gmail.com>	<4DD413FC.2090808@showlabor.de>	<BANLkTi=2NeMGL6n7B0n-2p9La=45pM7ZHg@mail.gmail.com>	<s5hhb8r1c20.wl%tiwai@suse.de>
	<4DD4BC97.5090702@showlabor.de> <s5h39kb17bv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vwp5738.webpack.hosteurope.de (vwp5738.webpack.hosteurope.de
	[83.169.30.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 89CE910397D
	for <alsa-devel@alsa-project.org>;
	Thu, 19 May 2011 10:14:30 +0200 (CEST)
In-Reply-To: <s5h39kb17bv.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Grant Diffey <gdiffey@gmail.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Please, Clemens, Daniel and Takashi.

Every single one of you knows at least one way of doing it correctly. I 
don't.

I don't understand most of your suggestions, I don't understand the 
whole quirk framework. I'm just a layman who knows one way of making the 
FTU mixer work which would break others (just by calling 
snd_usb_create_mixer() too many times).

The "blueprint patch" I've send is very small. It's just three 
functions, one of them is very simple the others are almost identical to 
already present functions.

So please, couldn't someone fill the gap between what I have found and a 
proper implementation? As I see it, you might easily spend the same 
amount of time explaining to me how it should be done or why my next 
proposed patch (which would probably take at least a couple of weeks) is 
not acceptable and so on. But this would probably run for weeks or even 
months.

Please, help.

Thanks,

Felix

Am 19.05.2011 09:24, schrieb Takashi Iwai:
>
> In this particular case, you can call snd_usb_create_mixer() then
> create your mixer elements in addition in your quirk function.  This
> is more straightforward than adding branches in multiple points.
>
> Of course, there can be some room for refactoring to share codes
> between different quirks.  But it's a thing to be done in quirk
> codes.
> What I'm thinking is also to keep the thing simple.
> My points are:
>   - Try to avoid conditional branches, don't touch the main path as
>     much as possible
>   - You can call the standard parsers in the quirk itself
>   - You can create additional mixer contents in the quirk as well
>     (so just use your simplified snd_ftu_controls_create()).


Am 19.05.2011 09:15, schrieb Clemens Ladisch:
>
> So create a FTU mixer quirk for intf 0 (or a generic quirk
> with a separate table of mixer controls).
>

Am 18.05.2011 23:30, schrieb Daniel Mack:
> Well in that case, I would add the mixers in
> mixer_quirks.c just like you did in your patch, but I would basically
> copy some code from build_feature_ctl() and allocate and fill a
> special cval from within your quirk function. I would suggest making
> usb_feature_unit_ctl (the struct) public (remove the static, prefix
> the name with snd_usb_ and add the prototype to the header), so you
> can reference it from mixer_quirks.c. That way, you would keep all the
> _info, _get and _put functions privately to mixer.c, but still have
> the ability to reuse most of the code. You just need to fill your cval
> with data the generic functions can cope with. Does that make sense?
>
