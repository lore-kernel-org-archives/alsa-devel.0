From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: alsactl adds volume controls?
Date: Fri, 08 Oct 2010 17:49:52 +0200
Message-ID: <4CAF3DA0.9020908@ladisch.de>
References: <s5hr5hczi06.wl%tiwai@suse.de>	<4C7F6D5D.7020101@canonical.com>	<alpine.LNX.2.00.1009021553460.10278@eeebox2.perex-int.cz>	<4C7FB2CF.5060505@ladisch.de>	<alpine.LNX.2.00.1009021721100.10278@eeebox2.perex-int.cz>	<4C7FC85B.4000009@ladisch.de>	<alpine.LNX.2.00.1009021926120.10278@eeebox2.perex-int.cz>	<i7viav$kjb$1@dough.gmane.org>	<4CA46E98.10402@ladisch.de>	<4CA4A844.7060403@colin.guthr.ie>	<20100930164753.GB9431@sirena.org.uk>	<s5hr5gb9k83.wl%tiwai@suse.de>	<4CA5834D.5030408@ladisch.de>	<4CA59976.2020306@colin.guthr.ie>	<4CA5A38A.7050006@ladisch.de>	<i8ce5u$fj3$1@dough.gmane.org>	<4CAD7F3D.3090205@ladisch.de>	<4CAF1AF2.3060907@colin.guthr.ie>	<4CAF1FA3.5000402@ladisch.de>	<4CAF2533.1060102@colin.guthr.ie>
	<4CAF27B7.9080909@colin.guthr.ie> <4CAF2DD1.5050306@ladisch.de>
	<4CAF37DE.8070205@colin.guthr.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 905B5103971
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Oct 2010 17:48:22 +0200 (CEST)
In-Reply-To: <4CAF37DE.8070205@colin.guthr.ie>
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
> What is odd about this tho', is that the flag for min is mute (0x10000)
> is checked on tlv[3] which is also used here for the "max" value.

SND_CTL_TLVT_DB_SCALE uses a flag in tlv[3] to indicate min-is-mute, but
SND_CTL_TLVT_DB_MINMAX has a variant SND_CTL_TLVT_DB_MINMAX_MUTE.
(The HDA driver uses DB_SCALE).

> +       if (db_gain <= min) {
>                 *value = rangemin;
> +               if (xdir > 0 && (tlv[3] & 0x10000) && db_gain > SND_CTL_TLV_DB_GAIN_MUTE)
> +                       *value = rangemin + 1;

This should go at the same place in the SND_CTL_TLVT_DB_SCALE branch.


Regards,
Clemens
