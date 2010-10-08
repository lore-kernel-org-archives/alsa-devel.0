From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: alsactl adds volume controls?
Date: Fri, 08 Oct 2010 16:42:25 +0200
Message-ID: <4CAF2DD1.5050306@ladisch.de>
References: <s5hr5hczi06.wl%tiwai@suse.de>	<4C7F6D5D.7020101@canonical.com>	<alpine.LNX.2.00.1009021553460.10278@eeebox2.perex-int.cz>	<4C7FB2CF.5060505@ladisch.de>	<alpine.LNX.2.00.1009021721100.10278@eeebox2.perex-int.cz>	<4C7FC85B.4000009@ladisch.de>	<alpine.LNX.2.00.1009021926120.10278@eeebox2.perex-int.cz>	<i7viav$kjb$1@dough.gmane.org>	<4CA46E98.10402@ladisch.de>	<4CA4A844.7060403@colin.guthr.ie>	<20100930164753.GB9431@sirena.org.uk>	<s5hr5gb9k83.wl%tiwai@suse.de>	<4CA5834D.5030408@ladisch.de>	<4CA59976.2020306@colin.guthr.ie>	<4CA5A38A.7050006@ladisch.de>	<i8ce5u$fj3$1@dough.gmane.org>	<4CAD7F3D.3090205@ladisch.de>	<4CAF1AF2.3060907@colin.guthr.ie>	<4CAF1FA3.5000402@ladisch.de>
	<4CAF2533.1060102@colin.guthr.ie> <4CAF27B7.9080909@colin.guthr.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 0330E103874
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Oct 2010 16:40:55 +0200 (CEST)
In-Reply-To: <4CAF27B7.9080909@colin.guthr.ie>
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

Colin Guthrie wrote:
> Hmm, just thinking about this (as I don't know the volume control logic
> particularly well in PA), the call snd_mixer_selem_set_playback_dB() is
> used with a dir argument of +1.
> 
> From what I understand, this would allow me to say "set the volume to
> 50dB" and due to the +1 dir, it should select -46.499999 ( because -46.5
> mutes it).
> 
> In this case however, the value of -99999.999dB is ultimately selected
> (aka 0).
> 
> I'm wondering if the TLV fix actually affects how
> snd_mixer_selem_set_playback_dB() call works with the dir argument.

Uh, oh.  snd_tlv_convert_from_dB() ignores the minimum-is-mute flag.
Please try this hack:

--- alsa-lib/src/control/tlv.c
+++ alsa-lib/src/control/tlv.c
@@ -335,6 +335,9 @@ int snd_tlv_convert_from_dB(unsigned int *tlv, long rangemin, long rangemax,
 			if (xdir > 0)
 				v += (max - min) - 1;
 			v = v / (max - min) + rangemin;
+			if (v == rangemin && xdir > 0 && (tlv[3] & 0x10000) &&
+			    db_gain > SND_CTL_TLV_DB_GAIN_MUTE)
+				v++;
 			*value = v;
 		}
 		return 0;
