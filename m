From: "Daniele (Mastro)" <daniele.bilug@gmail.com>
Subject: Re: Notebook Toshiba satellite x200-21g with realtek
 snd-hda-intel audio device still not supported (codec ALC268)
Date: Tue, 19 Feb 2008 19:52:42 +0100
Message-ID: <47BB257A.1080800@gmail.com>
References: <47672BCB.9080608@gmail.com>	<476912F3.8090609@gmail.com>	
	<476A2BCC.4060109@gmail.com>	<s5h1w9h4g5d.wl%tiwai@suse.de>	
	<47727C6C.6080401@gmail.com>	
	<1198815321.3732.229.camel@razman.gruemaster.com>	
	<47B06DEF.4070609@gmail.com>	<s5htzkfv5jp.wl%tiwai@suse.de>	
	<47B0D319.2000702@gmail.com>	<s5hd4r2v5g1.wl%tiwai@suse.de>	
	<47B23AB8.6000301@gmail.com>	<47B5D230.4050402@gmail.com>	
	<47B9C909.9010100@gmail.com>	<s5h3arpujri.wl%tiwai@suse.de>	
	<47BAE549.2080009@gmail.com>	<s5hzltxt3oy.wl%tiwai@suse.de>	
	<47BAEFB6.8040209@gmail.com>	<s5hprutt22f.wl%tiwai@suse.de>	
	<47BAFBD6.8050903@gmail.com> <s5hir0kudkz.wl%tiwai@suse.de>	
	<47BB1204.5010801@gmail.com>
	<1203444980.1677.20.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.187])
	by alsa0.perex.cz (Postfix) with ESMTP id C619624619
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2008 19:53:03 +0100 (CET)
Received: by fk-out-0910.google.com with SMTP id f40so2284729fka.0
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2008 10:53:02 -0800 (PST)
In-Reply-To: <1203444980.1677.20.camel@razman.gruemaster.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tobin Davis <tdavis@dsl-only.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Tobin Davis ha scritto:
> The only way to support Midi on that system is via software midi.  There
> is no hardware midi support directly to the system (no place to plug in
> midi devices), except through USB or possibly integrated in a docking
> system.  To get Midi support for Linux, use Timidity
> (http://timidity.sourceforge.net).   This will convert midi sequences to
> pcm audio tracks.

ok.. they sucks :)
anyway i know how to do software midi.. i've written a guide for it too 
some times ago, thanks

> I personally can't translate the specs listed, but from what I can tell,
> the system should have a Line-in, Mic-In, and HP-out jacks, along with 4
> internal speakers (nothing indicating surround sound).  It does have
> SPDIF out, and I would assume that will allow surround sound if hooked
> up to a digital receiver, as SPDIF is essentially a digital
> pass-through.  The codec itself only has two DACs, which could be
> configured between the headphones and speakers to do a quasi-surround4.0
> setup, but based on the chip diagram would take some additional
> programming effort.

i'm 130% sure there's a subwoofer anyway..

> And I'm sorry I dropped the ball in helping here.  I wish I could spend
> more time on Alsa, but economics forces me to have a full time job doing
> non-alsa work at this time.  Bad excuse, I know.

i understand it :) no problem! thanks a lot for what you have done!

> I'll try to get my test board working again this week, and I'll even
> download the Windows drivers for your system to use as a baseline for
> comparison.  No guarantees, though.

ok.. if you found something keep me informed, thanks!
--
Daniele
