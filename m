From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: Re: snd-hda-intel prevents machine to power off
Date: Tue, 28 Oct 2008 16:44:33 -0200
Message-ID: <20081028164433.2b2c6db4@doriath.conectiva>
References: <20081028135933.36778d60@doriath.conectiva>
	<s5hskqgbt4h.wl%tiwai@suse.de>
	<20081028141916.610a2847@doriath.conectiva>
	<s5hod14br3h.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754546AbYJ1SoR@vger.kernel.org>
In-Reply-To: <s5hod14br3h.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, herton@mandriva.com.br
List-Id: alsa-devel@alsa-project.org

Em Tue, 28 Oct 2008 17:51:30 +0100
Takashi Iwai <tiwai@suse.de> escreveu:

| At Tue, 28 Oct 2008 14:19:16 -0200,
| Luiz Fernando N. Capitulino wrote:
| > 
| > Em Tue, 28 Oct 2008 17:07:42 +0100
| > Takashi Iwai <tiwai@suse.de> escreveu:
| > 
| > | >  Hi Takashi,
| > | > 
| > | >  If I have some process with the sound device opened in my eeepc
| > | > (say KDE's kmix) and try to power off the machine, for example with:
| > | > 
| > | > # echo o > /proc/sysrq-trigger
| > | > 
| > | >  The machine will not power off.
| > | 
| > | At which point does it stop?
| > | What shows alt-sysrq-t (or w) output?
| > 
| >  I'm wondering how to get that kind of output because everything
| > is disabled at that point (display inclusive).
| 
| OK, then it's hard to see.
| A good news is that it goes at least fairly end point, thus likely no
| hanging task, etc.
| 
| 
| > | >  But it does work if I remove the snd-hda-intel module before issuing
| > | > the echo above.
| > | > 
| > | >  This problem seems to be pretty popular among distros, I could find
| > | > it reported for Mandriva, Ubuntu and Fedora.
| > | 
| > | Hmm, I haven't heard of unfixed issues.
| > 
| >  Well, these are the tickets I've found:
| > 
| > https://bugzilla.redhat.com/show_bug.cgi?id=444115
| > https://bugs.launchpad.net/ubuntu/+source/linux-source-2.6.22/+bug/126140
| > https://qa.mandriva.com/show_bug.cgi?id=44752
| 
| Looking through the comments that the power-saving helps, the problem
| may disappear even without disabling the pci device.  The power-saving
| doesn't involve with pci_disable_device() or changing the power-state
| of the controler.  So, at least, the problem is either in the codec
| or the controller setup.
| 
| Suppose you already use the power-saving and it solves the shutdown
| problem, could you set power_save_controller=0 option for
| snd-hda-intel, and check whether the shutdown still works or not?
| If the shutdown doesn't work with this option, it means that
| azx_stop_chip() is what would be needed.

 Yes, power_save_controller=0 doesn't work while the power-saving
one works.

 Where should I put a call to azx_stop_ship()? I'm not an alsa
hacker. :)

| Anyway, I feel this is rather a BIOS issue, and not sure what is the
| best way to fix in the driver itself...

 I see... I'm running with the latest BIOS update, btw.

-- 
Luiz Fernando N. Capitulino
