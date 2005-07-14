From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB Audio - Silence
Date: Thu, 14 Jul 2005 11:24:27 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0507141123330.26288-100000@studcom.urz.uni-halle.de>
References: <200507130019.56200.luca_ing@libero.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200507130019.56200.luca_ing@libero.it>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Smery <luca_ing@libero.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Smery wrote:
>         I have an USB device with one Audio Class interface.
> snd_usb_audio detects it and register the corresponding card:
> Also recording sems to work fine:
>
> The problem is that I obtain a file does not contain anything other than a
> sequence of "40 00" (hex) bytes.

What is the output of "amixer -c 3 contents" and "lsusb -v" for your
device?


Regards,
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
