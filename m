From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: usb quattro
Date: Thu, 26 Sep 2002 09:56:15 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D925B2F.9060704@boosthardware.com>
References: <3D77A319.3010703@boosthardware.com>	<DAELIEGDPLDDCIJPAICBGEHNCDAA.annabellesgarden@yahoo.de>	<s5hvg5jwgvk.wl@alsa2.suse.de>	<3D7912A2.1000908@boosthardware.com> <s5hy9abzefz.wl@alsa2.suse.de> <3D8C277C.2070808@boosthardware.com> <3D9090D6.6010402@boosthardware.com> <3D924CD9.9010503@boosthardware.com>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Patrick Shirkey wrote:
> I just updated using cvs from a couple of hours ago and I can get 
> perfect quality audio with multiple channels through jack.
> 

Further testing reveals that jack cannot capture audio from the pcm ins. 
arecord works however. I have tested using jackrec and ardour but 
neither will capture audio. Instead they write a soundless file to disk 
  without complaint.




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
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
