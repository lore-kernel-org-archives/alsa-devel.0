From: "fmoraes74@netzero.net" <fmoraes74@netzero.net>
Subject: emu10k1x patch
Date: Tue, 25 May 2004 01:00:58 GMT
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040524.180130.29254.73272@webmail13.nyc.untd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="--__JWM__J2781.446bS.794bM"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

----__JWM__J2781.446bS.794bM
Content-Type: text/plain; charset = us-ascii
Content-Disposition: inline

A few minor fixes to the emu10k1x driver. Also, it would be nice to update the soundcards page to list it as supported (mention that only PCM playback is currently supported).

I will try to test a few more things before 1.0.5 gets final, I hope.

Francisco

----__JWM__J2781.446bS.794bM
Content-Type: text/x-patch
Content-Description: emu101x.patch
Content-Disposition: attachment; filename="emu101x.patch"

Index: pci/emu10k1/emu10k1x.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/pci/emu10k1/emu10k1x.c,v
retrieving revision 1.2
diff -r1.2 emu10k1x.c
185c185
<       .channels_min =         1,
---
>       .channels_min =         2,
188,189c188,189
<       .period_bytes_min =     64,
<       .period_bytes_max =     (32*1024),
---
>       .period_bytes_min =     (16*1024),
>       .period_bytes_max =     (16*1024),
732,733c732,733
<       //  snd_emu10k1x_intr_enable(chip, (INTE_CH_0_LOOP<<1);
<       //  snd_emu10k1x_intr_enable(chip, INTE_CH_0_LOOP<<2);
---
>       snd_emu10k1x_intr_enable(chip, (INTE_CH_0_LOOP|INTE_CH_0_HALF_LOOP)<<1);>       snd_emu10k1x_intr_enable(chip, (INTE_CH_0_LOOP|INTE_CH_0_HALF_LOOP)<<2);
----__JWM__J2781.446bS.794bM--


________________________________________________________________
The best thing to hit the Internet in years - NetZero HiSpeed!
Surf the Web up to FIVE TIMES FASTER!
Only $14.95/ month -visit www.netzero.com to sign up today!


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
