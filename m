From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: alsasound init script (Re: possible problems with rc6 aplay )
Date: Mon, 16 Dec 2002 10:23:38 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18Nx2x-0004Mi-00@sc8-sf-list1.sourceforge.net>
References: <s5h1y4it3qd.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 16 Dec 2002 15:53:14 +0100."
             <s5h1y4it3qd.wl@alsa2.suse.de>
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

>> that reminds me. the last version of the alsasound script that i saw
>> did something very dangerous. it seemed to try to install *every*
>> snd-card module it could find. if you have a system with an ISA bus,
>> this can prove fatal to the system - many ISA device probes will kill
>> the machine if the device is not present.
> 
>well, you can find that the alsasound script tries to load the modules
>aliased as "snd-card-[0-9]", not the all snd-card-* modules.
>remember that there is no module named as such.  that means, if such a
>module is found, it was certainly configured by some means.

ah. sorry, i missed the -c on modprobe. i take it all back :(

--p


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
