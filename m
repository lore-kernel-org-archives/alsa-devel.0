From: thomas schorpp <t.schorpp@gmx.de>
Subject: [Fwd: Re: newer C-Media CMI9761A, your testpatches],
 unrequested headphone-out, equalizer set
Date: Fri, 18 Feb 2005 18:56:12 +0100
Message-ID: <42162C3C.6000703@gmx.de>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020606000002060001050703"
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>, cltien@cmedia.com.tw, Takashi Iwai <tiwai@users.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020606000002060001050703
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160

hello,

tonight i discovered one more issue:

sound output quality of the looped through lines conn. to external
hifi-amplifier:

- - low+high band drain > 6dB or mid-band gain > 6dB

possible causes:

- - driver sets headphone output instead of external ampflifier mode
(poss. wrong output impedance effecting fr-linearity)

tried switching in mixer, result negative.

- - the build-in equalizer is set implicitely online by the driver.

y
tom
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iQCVAwUBQhYsOGqsze5HSzyoAQMJzAQAnHpENcKI+9iAUleqW/RkWNLV8WKj9ayI
y8mO09tabw9Y0aLex7NsDL09KU1GCHUlRKTi0GH4ZGhfMbJcTmL29d4DdsnhdzzK
LHvY4gSCSSUSLrr/ObuRnc562r8me7rpZ1k+zXlgnPyftTw5CEHpdqBZ/OpzW2ia
+gOW4jCrcBc=
=0caw
-----END PGP SIGNATURE-----

--------------020606000002060001050703
Content-Type: message/rfc822;
 name="Re: [Alsa-devel]   C-Media CMI9761 -A- type, your patches"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Re: [Alsa-devel]   C-Media CMI9761 -A- type, your patches"

Message-ID: <42156835.9010202@gmx.de>
Date: Fri, 18 Feb 2005 04:59:49 +0100
From: thomas schorpp <t.schorpp@gmx.de>
Reply-To: t.schorpp@gmx.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [Alsa-devel]   C-Media CMI9761 -A- type, your patches
References: <E1D1Ttl-0000lb-In@sc8-pr-cvs1.sourceforge.net>	<4213BB44.5060702@gmx.de>	<s5hbrajs9zj.wl@alsa2.suse.de>	<4214DD40.3070102@gmx.de>	<s5hvf8rqb7k.wl@alsa2.suse.de>	<4214ECAC.8040003@gmx.de> <s5hll9nq949.wl@alsa2.suse.de>
In-Reply-To: <s5hll9nq949.wl@alsa2.suse.de>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


> But, before changing this, please check whether my last patch works.
> If this is OK, I can fix the above together.

 > both patches applied to rev 1.73 patch.c et al.

bad idea ;) your patch code isnt even run there.

next time state the rev to patch, pls. but for future i assume head.

updated to head.

applied both patches...

verifying.....

- low unregulateable noisy distorted output of pcm sound after muting 
"iec capture monitor"

- no vol master slider
- no pcm master slider
- 1 dxs slider

hope this helps, meanwhile i read the mixer building functions and 
rollback to 1.73 and try a override to get the missing sliders back.

seems to be not underestimateable diffrence with my chips registers.

tom











--------------020606000002060001050703--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
