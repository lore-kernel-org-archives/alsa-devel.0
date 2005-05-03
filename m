From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ICH5 fails
Date: Tue, 3 May 2005 15:01:40 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0505031455320.19889-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.63.0505021217480.6463@catbert.rellim.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.63.0505021217480.6463@catbert.rellim.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Gary E. Miller" <gem@rellim.com>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Gary E. Miller wrote:
> I have laptops and desktops with the ICH5 sound subsystem.  They
> all work fine up to 2.6.8.1.  Anything past that does not work.

What does "does not work" mean?  No sound?

> kernel: ALSA device list:
> kernel:  #0: Intel ICH5 with unknown codec at 0xd0000c0 0, irq 17

Please try ALSA 1.0.9rc3.

What are the contents of /proc/asound/card0/codec97#0/ac97#0-0?


Regards,
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
