From: Frank Roth <frashman@freenet.de>
Subject: Re: Testers wanted: New SB X-Fi driver
Date: Mon, 20 Jul 2009 20:47:55 +0200
Message-ID: <4A64BBDB.3000801@freenet.de>
References: <4A5DB59B.2010407@freenet.de>	<s5hvdltnfrp.wl%tiwai@suse.de>	<4A5EFEA3.7060603@freenet.de>
	<s5hfxcri6r6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout6.freenet.de (mout6.freenet.de [195.4.92.96])
	by alsa0.perex.cz (Postfix) with ESMTP id BFB5824470
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jul 2009 20:47:55 +0200 (CEST)
In-Reply-To: <s5hfxcri6r6.wl%tiwai@suse.de>
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

Hi

Got it, there was a wrong default entry in
/etc/modprobe.d/50-sound.conf
..made by alsaconf

alias snd-card-0 snd-ctxfi
alias sound-slot-0 snd-ctxfi


moved it now to
/etc/modprobe.d/modprobe.conf
and chanced to:

alias snd-card-0 snd_ctxfi
alias sound-slot-0 snd_ctxfi

now it's fine ... so ... no conflict ... sorry.
but maybe someone could look, why alsaconf had done this.



> 
> The PCI ID looks different from what snd-hda-intel driver supports.
> When compiled together with snd-ctxfi, snd-hda-intel only probes
> PCI ID 1002:0009.
> 
> Are you sure that it's hda-intel that interferes the xfi?
> Any relevant kernel messages or asound entry when this happens?
> 
> 
> Takashi



Found another problem ... maybe it isn't a bug ...

If I raise all volumes in alsamixer to 100% it starts to crackle while playing music ...
If I lower one of the mixer volumes down to 90% it's fine.
Maybe it's just overdriven ... but I'm relative sure, in windows I can gain everything to 100% without to be overdriven.

For now, I've set the PCM volume control to 90%, then I can do whatever I want with the master volume ;-)


Greetings
Frank
