From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: via82xx problem
Date: Fri, 11 Feb 2005 11:07:02 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0502111104160.15708-100000@studcom.urz.uni-halle.de>
References: <420C5ECA.3020906@home.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <420C5ECA.3020906@home.se>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Tobias Svensson <tobiassvensson@home.se>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Tobias Svensson wrote:
> "no mixer elems found" when i run alsamixer, and when I start gnome/kde
> and so on the sound server crasch.. and of course there is no sound at
> all ;)

> /proc/asound/cards:
> 0 [modem          ]: VIA82XX-MODEM - VIA 82XX modem
>                      VIA 82XX modem at 0xe100, irq 5
> 1 [V8235          ]: VIA8233 - VIA 8235
>                      VIA 8235 with Cx20468 at 0xe000, irq 5

The driver for the modem got loaded before the ac97 driver.  Please
make sure that your /etc/modprobe.conf or modules.conf contains index
options for both modules, e.g.:

options snd-via82xx index=0
options snd-via82xx-modem index=1


HTH
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
