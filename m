From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: possible problems with rc6 aplay
Date: Mon, 16 Dec 2002 09:29:05 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18NwBf-0003qc-00@sc8-sf-list1.sourceforge.net>
References: <s5h4r9et6au.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 16 Dec 2002 14:57:45 +0100."
             <s5h4r9et6au.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Mark Knecht <markknecht@attbi.com>, martin-langer@gmx.de, Alsa-Devel <alsa-devel@lists.sourceforge.net>, swpatrick@earthlink.net
List-Id: alsa-devel@alsa-project.org

>the standard alsasound init script can call a card-dependent script

that reminds me. the last version of the alsasound script that i saw
did something very dangerous. it seemed to try to install *every*
snd-card module it could find. if you have a system with an ISA bus,
this can prove fatal to the system - many ISA device probes will kill
the machine if the device is not present.

the alsasound script should assume, i think, that alsaconf has been
run, and that only modules listed in /etc/modules.conf or its
equivalent should be loaded.

--p


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
