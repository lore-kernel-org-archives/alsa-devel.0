From: fab <fab@gnux.info>
Subject: Re: intel-hda on medion laptop
Date: Fri, 6 May 2005 00:48:51 +0200
Message-ID: <20050505224851.GA7681@blackmilk.localzone.fr>
References: <20050505210932.GA8016@blackmilk.localzone.fr> <Pine.LNX.4.63.0505051422190.31406@catbert.rellim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0505051422190.31406@catbert.rellim.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Gary E. Miller" <gem@rellim.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> Yo fab!
> 
> I have a laptop and a desktop with the ICH5 sound. Not had any luck getting
> either to work since Alsa 1.0.4.
> 
> Anything in the dmesg buffer? Can you send the contents of your
> /proc/asound/cards and /proc/sound/devices?  Anything in your
> /etc/asound.conf?

fab@garg:~% cat /proc/asound/cards
0 [Intel          ]: HDA-Intel - HDA Intel
                     HDA Intel at 0x80000000 irq 169

fab@garg:~% cat /proc/asound/devices
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  0: [0- 0]: ctl
 33:       : timer


and my modprobe.d/sound :
alias snd-card-0 snd-hda-intel
alias sound-slot-0 snd-hda-intel
options snd-hda-intel model=w810

Regards.
fab.


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
