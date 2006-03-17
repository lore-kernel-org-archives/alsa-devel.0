From: "S. Effendi" <osbebas@yahoo.co.id>
Subject: [PATCH] nearest conv_rates matching
Date: Sat, 18 Mar 2006 06:57:14 +0700 (ICT)
Message-ID: <20060317235714.50540.qmail@web38612.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1751506671-1142639834=:44781"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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
List-Id: alsa-devel@alsa-project.org

--0-1751506671-1142639834=:44781
Content-Type: text/plain; charset=utf-8
Content-Id: 
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

attached you can find a simple patch to match
"uncommon" rate in some USB speaker to the fixed
conv_rates in usbaudio.c.

I had problem using ALSA with "Typhoon Desktop Mini
USB Speakers" (0e6a:0310 Megawin Technology Co., Ltd).

mpg123 told me "No supported rate found!".

# cat /proc/asound/card1/stream0
USB Audio Device at usb-0000:00:1d.0-2.4, full speed :
USB Audio
  Interface 2
    Altset 1
    Format: S16_LE
    Channels: 2
    Endpoint: 2 OUT (ADAPTIVE)
    Rates: 46875

With this patch now I get:

USB Audio Device at usb-0000:00:1d.0-2.4, full speed :
USB Audio
  Interface 2
    Altset 1
    Format: S16_LE
    Channels: 2
    Endpoint: 2 OUT (ADAPTIVE)
    Rates: 44100

and mpg123 works JustFine(TM) :)

Hope you find it useful.


Best regards,
S. Effendi


=09

=09
	=09
_________________________________________________________________________=
______=20
Apakah Anda Yahoo!?
Kunjungi halaman depan Yahoo! Indonesia yang baru!=20
http://beta.id.yahoo.com/
--0-1751506671-1142639834=:44781
Content-Type: text/x-patch; name="alsa_usbaudio_conv_rates.patch"
Content-Description: 3723235254-alsa_usbaudio_conv_rates.patch
Content-Disposition: inline; filename="alsa_usbaudio_conv_rates.patch"

--- linux-2.6.15.6/sound/usb/usbaudio.c	2006-03-05 20:07:54.000000000 +0100
+++ linux-2.6.15.6-patched/sound/usb/usbaudio.c	2006-03-18 00:27:13.000000000 +0100
@@ -2394,17 +2394,35 @@
 		fp->nr_rates = nr_rates;
 		fp->rate_min = fp->rate_max = combine_triple(&fmt[8]);
 		for (r = 0, idx = offset + 1; r < nr_rates; r++, idx += 3) {
+			unsigned int last_rate;
+			unsigned int rate_supported;
 			unsigned int rate = fp->rate_table[r] = combine_triple(&fmt[idx]);
 			if (rate < fp->rate_min)
 				fp->rate_min = rate;
 			else if (rate > fp->rate_max)
 				fp->rate_max = rate;
+			rate_supported = 0;
+			last_rate = 0;
 			for (c = 0; c < (int)ARRAY_SIZE(conv_rates); c++) {
 				if (rate == conv_rates[c]) {
-					fp->rates |= (1 << c);
+					/* conv_rate matched */
+					rate_supported = (1 << c);
+					break;
+				} else if (rate > conv_rates[c]) {
+					/* nearest conv_rate matched */
+					rate_supported = (1 << c);
+					last_rate = conv_rates[c];
+				} else {
 					break;
 				}
 			}
+			fp->rates |= rate_supported;
+			if(last_rate > 0) {
+				if(fp->rate_min > last_rate)
+					fp->rate_min = last_rate; /* fix to nearest conv_rate matched */
+				/* nearest supported conv_rate */
+				fp->rate_table[r] = last_rate; 
+			}
 		}
 	} else {
 		/* continuous rates */

--0-1751506671-1142639834=:44781--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
