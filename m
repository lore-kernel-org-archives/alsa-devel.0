From: Peter Zubaj <pzad@pobox.sk>
Subject: Re: Is there plans to support SiS7019?
Date: Thu, 19 Aug 2004 09:32:38 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200408190732.i7J7WcoW020750@www3.pobox.sk>
Reply-To: Peter Zubaj <pzad@pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: vrihad@softhome.net
Cc: alsa-devel@lists.sourceforge.net, clemens@ladisch.de, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Hi,

These errors are not related to changes you made.

unregister_sound_special
register_sound_special

These are definied in soundcore module.

I think you need this in modules.conf too=20

alias char-major-116 snd

before these lines
alias snd-card-0 snd-trident
alias sound-slot-0 snd-trident

Peter Zubaj=0A____________________________________=0Ahttp://www.logofun.pob=
ox.sk - urobte radost svojmu telefonu=0A


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
