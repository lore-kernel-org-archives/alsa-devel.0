From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: Re: snd-hda-intel prevents machine to power off
Date: Tue, 28 Oct 2008 14:19:16 -0200
Message-ID: <20081028141916.610a2847@doriath.conectiva>
References: <20081028135933.36778d60@doriath.conectiva>
	<s5hskqgbt4h.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754138AbYJ1QSs@vger.kernel.org>
In-Reply-To: <s5hskqgbt4h.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Em Tue, 28 Oct 2008 17:07:42 +0100
Takashi Iwai <tiwai@suse.de> escreveu:

| >  Hi Takashi,
| > 
| >  If I have some process with the sound device opened in my eeepc
| > (say KDE's kmix) and try to power off the machine, for example with:
| > 
| > # echo o > /proc/sysrq-trigger
| > 
| >  The machine will not power off.
| 
| At which point does it stop?
| What shows alt-sysrq-t (or w) output?

 I'm wondering how to get that kind of output because everything
is disabled at that point (display inclusive).

| >  But it does work if I remove the snd-hda-intel module before issuing
| > the echo above.
| > 
| >  This problem seems to be pretty popular among distros, I could find
| > it reported for Mandriva, Ubuntu and Fedora.
| 
| Hmm, I haven't heard of unfixed issues.

 Well, these are the tickets I've found:

https://bugzilla.redhat.com/show_bug.cgi?id=444115
https://bugs.launchpad.net/ubuntu/+source/linux-source-2.6.22/+bug/126140
https://qa.mandriva.com/show_bug.cgi?id=44752

| >  Its workaround is also documented in a few wikis: people are doing
| > a 'rmmod snd-hda-intel' in the last halt stage (ie, halt script
| > in etc).
| 
| I hate wiki or forum just recommending a wrong workaround :)

 Yeah.

-- 
Luiz Fernando N. Capitulino
