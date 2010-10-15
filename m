From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 2/2] tlv: fix returned dB information for
	min-is-mute controls
Date: Fri, 15 Oct 2010 10:33:20 +0200
Message-ID: <4CB811D0.2080906@ladisch.de>
References: <s5hr5hczi06.wl%tiwai@suse.de>	<4C7F6D5D.7020101@canonical.com>	<alpine.LNX.2.00.1009021553460.10278@eeebox2.perex-int.cz>	<4C7FB2CF.5060505@ladisch.de>	<alpine.LNX.2.00.1009021721100.10278@eeebox2.perex-int.cz>	<4C7FC85B.4000009@ladisch.de>	<alpine.LNX.2.00.1009021926120.10278@eeebox2.perex-int.cz>	<i7viav$kjb$1@dough.gmane.org>	<4CA46E98.10402@ladisch.de>	<4CA4A844.7060403@colin.guthr.ie>	<20100930164753.GB9431@sirena.org.uk>	<s5hr5gb9k83.wl%tiwai@suse.de>	<4CA5834D.5030408@ladisch.de>	<4CA59976.2020306@colin.guthr.ie>	<4CA5A38A.7050006@ladisch.de>	<i8ce5u$fj3$1@dough.gmane.org>	<4CAD7F3D.3090205@ladisch.de>	<4CAF1AF2.3060907@colin.guthr.ie>	<4CAF1FA3.5000402@ladisch.de>	<4CAF2533.1060102@colin.guthr.ie>	<4CAF27B7.9080909@colin.guthr.ie>	<4CAF2DD1.5050306@ladisch.de>	<4CAF37D
 E.8070205@colin.guthr.ie>	<4CAF38D7.6030901@colin.guthr.ie>
	<4CAF3D97.8070209@colin.guthr.ie>
	<4CB4218C.6070501@colin.guthr.ie> <4CB8119D.7090505@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 37120103C0B
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Oct 2010 10:32:00 +0200 (CEST)
In-Reply-To: <4CB8119D.7090505@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Colin Guthrie <gmane@colin.guthr.ie>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

For TLV information that indicates that the minimum value is actually
muted, the returned range used the wrong minimum dB value, and
converting dB values to raw control values did not round up correctly
near the minimum.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

--- alsa-lib/src/control/tlv.c
+++ alsa-lib/src/control/tlv.c
@@ -167,17 +167,23 @@ int snd_tlv_get_dB_range(unsigned int *t
 	}
 	case SND_CTL_TLVT_DB_SCALE: {
 		int step;
-		*min = (int)tlv[2];
+		if (tlv[3] & 0x10000)
+			*min = SND_CTL_TLV_DB_GAIN_MUTE;
+		else
+			*min = (int)tlv[2];
 		step = (tlv[3] & 0xffff);
-		*max = *min + (long)(step * (rangemax - rangemin));
+		*max = (int)tlv[2] + step * (rangemax - rangemin);
 		return 0;
 	}
 	case SND_CTL_TLVT_DB_MINMAX:
-	case SND_CTL_TLVT_DB_MINMAX_MUTE:
 	case SND_CTL_TLVT_DB_LINEAR:
 		*min = (int)tlv[2];
 		*max = (int)tlv[3];
 		return 0;
+	case SND_CTL_TLVT_DB_MINMAX_MUTE:
+		*min = SND_CTL_TLV_DB_GAIN_MUTE;
+		*max = (int)tlv[3];
+		return 0;
 	}
 	return -EINVAL;
 }
@@ -217,7 +223,7 @@ int snd_tlv_convert_to_dB(unsigned int *
 		min = tlv[2];
 		step = (tlv[3] & 0xffff);
 		mute = (tlv[3] >> 16) & 1;
-		if (mute && volume == rangemin)
+		if (mute && volume <= rangemin)
 			*db_gain = SND_CTL_TLV_DB_GAIN_MUTE;
 		else
 			*db_gain = (volume - rangemin) * step + min;
@@ -327,7 +333,11 @@ int snd_tlv_convert_from_dB(unsigned int
 		step = (tlv[3] & 0xffff);
 		max = min + (int)(step * (rangemax - rangemin));
 		if (db_gain <= min)
-			*value = rangemin;
+			if (db_gain > SND_CTL_TLV_DB_GAIN_MUTE && xdir > 0 &&
+			    (tlv[3] & 0x10000))
+				*value = rangemin + 1;
+			else
+				*value = rangemin;
 		else if (db_gain >= max)
 			*value = rangemax;
 		else {
@@ -345,7 +355,11 @@ int snd_tlv_convert_from_dB(unsigned int
 		min = tlv[2];
 		max = tlv[3];
 		if (db_gain <= min)
-			*value = rangemin;
+			if (db_gain > SND_CTL_TLV_DB_GAIN_MUTE && xdir > 0 &&
+			    tlv[0] == SND_CTL_TLVT_DB_MINMAX_MUTE)
+				*value = rangemin + 1;
+			else
+				*value = rangemin;
 		else if (db_gain >= max)
 			*value = rangemax;
 		else {
