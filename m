From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: snd-usb-midi, midi input, oss, oops!
Date: Wed, 18 Sep 2002 16:32:59 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D882C2B.6000306@boosthardware.com>
References: <Pine.HPX.4.33n.0209170930500.5178-100000@studcom.urz.uni-halle.de> <200209171947.MAA06264@cmn29.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Fernando Pablo Lopez-Lezcano wrote:
> 
> Thanks to an email from Michal Seta (off the list) the MIDI in
> problem is solved. Apparently the Midisport 2x2 firmware does
> not like any active MIDI inputs while the firmware is loading.
> If you disconnect everything, plug in the interface to the usb
> bus, load all the drivers and _then_ connect the input midi
> cables everything is fine.
> 

Added to the online docs.

-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================

"Um...symbol_get and symbol_put... They're
kindof like does anyone remember like get_symbol
and put_symbol I think we used to have..."
- Rusty Russell in his talk on the module subsystem



-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
