From: Anisse Astier <anisse@astier.eu>
Subject: Re: Mic Boost control problem with snd-hda-intel codec
	AL662 rev 1
Date: Wed, 13 Jan 2010 18:45:25 +0100
Message-ID: <20100113184525.576d7b94@destiny.ordissimo>
References: <20100106164338.2f3764bf@destiny.ordissimo>
	<s5hhbqro8fi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 75726103802
	for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2010 18:45:40 +0100 (CET)
Received: by fxm4 with SMTP id 4so72623878fxm.32
	for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2010 09:45:39 -0800 (PST)
In-Reply-To: <s5hhbqro8fi.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 12 Jan 2010 12:43:13 +0100, Takashi Iwai <tiwai@suse.de> wrote :

> At Wed, 6 Jan 2010 16:43:38 +0100,
> Anisse Astier wrote:
> > 
> > Hi,
> > 
> > The Mic Boost control on a laptop seems to behave incorrectly. The
> > control has the flag "volume" instead of "cvolume", causing it to appear
> > in both the "Playback" and "Capture" tabs of alsamixer.
> > This wouldn't be a problem if it would just work in the Capture tab: it
> > doesn't.
> > When I modify it in Capture, it doesn't retain its value: it's gone after
> > i close alsamixer. But if i modify it in "Playback" it will retain its
> > value and the value will be mirrored by the Mic Boost in Capture (both
> > Mic Boost seem to reflect the same control, except one is RO, the other
> > is RW).
> > 
> > It's a minor a annoyance, but I'd like to fix it and have "Mic Boost"
> > appear only as a Capture control and retaining its value. Maybe I should
> > create a new mixer configuration for this hardware in patch_realtek.c, but
> > I don't know where to start. Bios autoprobing works for everything but
> > just what I mentioned.
> 
> Well, Mic Boost is applied to both playback and capture in case you
> have analog loopback.  So, it's not entirely wrong.
> 
> The problem is rather the inconsistent behavior in alsamixer.
> I guess it's a bug of old alsa-lib.  Try to upgrade the alsa-lib and
> alsa-utils first.

You were right, problem goes away after upgrading userland lib and utils.

Thanks!

Anisse
