From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: alsasound init script (Re: possible problems with rc6 aplay )
Date: Mon, 16 Dec 2002 21:51:29 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18O7m1-0002AU-00@sc8-sf-list1.sourceforge.net>
References: <1040073528.1312.18.camel@Godzilla>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "16 Dec 2002 13:18:47 PST."
             <1040073528.1312.18.camel@Godzilla>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@attbi.com>
Cc: Takashi Iwai <tiwai@suse.de>, martin-langer@gmx.de, Alsa-Devel <alsa-devel@lists.sourceforge.net>, swpatrick@earthlink.net
List-Id: alsa-devel@alsa-project.org

>I wonder if this could have anything to do with a different problem I'm
>seeing. I have a HDSP 9652 and a MidiMan 2X2 interface. The HDSP is
>installed by alsaconf. The 2X2 is installed usign Fernando's
>instructions from the Planet.
>
>When I do a cold boot, the HDSP is always recognized first, and then the
>MidiMan comes up as card 2, at least by reading the numbers of the
>devices in /dev/snd. However, if I reboot, many times the system makes
>the 2X2 card 1 and the HDSP card 2, and that breaks a lot of this
>software.
>
>What would cause this to happen and how could I stop it?

set the snd_index parameter for each module in /etc/modules.conf. this
will force each module to use a particular card number every time.

i think it would something like this:

options snd-hdsp snd_index=0
options snd-usb-foo snd_index=1

i'm sure that takashi or jaroslav will correct me if i got this wrong.

--p


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
