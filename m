From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH] HDA-Intel: present up to 8 HDMI/DP outputs
 via "hdmi" device
Date: Mon, 23 Sep 2013 01:17:09 +0300
Message-ID: <523F6C65.9090002@iki.fi>
References: <1379886110-27931-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirokuusama.dnainternet.net (sirokuusama.dnainternet.net
 [83.102.40.133])
 by alsa0.perex.cz (Postfix) with ESMTP id E865C2650C5
 for <alsa-devel@alsa-project.org>; Mon, 23 Sep 2013 00:17:12 +0200 (CEST)
In-Reply-To: <1379886110-27931-1-git-send-email-anssi.hannula@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

23.09.2013 00:41, Anssi Hannula kirjoitti:
> Some new AMD cards have HDA codecs presenting 6 connected HDMI/DP pin
> nodes (plus 1 unconnected pin node) according to the ALSA card database.
> 
> Example:
> http://www.alsa-project.org/db/?f=de3ced7af41de0ed54d218650e5e2f16c511787b
> 
> Bump the maximum number of presented HDMI outputs per card via the
> "hdmi" PCM from 4 to 8 (so that the last possible device is DEV=7).
> 
> Note that HDMI PCM devices DEV=4..7 use shared PCM device numbers, so
> HDA cards that have over 4 audio PCM devices or multiple S/PDIF or modem
> devices will have their remaining PCM devices misrepresented as HDMI
> devices.
> 
> Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
> ---
> 
> Another example:
> http://www.alsa-project.org/db/?f=cd12a9d38f51c47eeedd380e4c5713f0d9a6c9de
> 
> I do not have confirmed that all of these pins are actually usable (and
> therefore this patch is untested on affected hardware), but I guess that
> is probable.
> Maybe the large amount of them has something to do with DisplayPort
> supporting multiple displays via a single connector, but that is just
> a wild guess on my part...

>From what I can see from looking at the radeon driver and their wiki,
Radeon display cores DCE4+ have 6 pins, and DCE8+ have 7 pins.

http://www.x.org/wiki/RadeonFeature/#index7h2

So seems this is really needed. Now what is left is whether we care
about the 10+ non-HDMI conflicts, and if so, what do we do about that?



> But do we want some sort of a solution for the possible conflicts between
> non-HDMI devices in the 10+ physical PCM device numbering range?
> 
> 
>  src/conf/cards/HDA-Intel.conf | 92 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
> 
> diff --git a/src/conf/cards/HDA-Intel.conf b/src/conf/cards/HDA-Intel.conf
> index 3957c12..7976b6c 100644
> --- a/src/conf/cards/HDA-Intel.conf
> +++ b/src/conf/cards/HDA-Intel.conf
> @@ -305,6 +305,98 @@ HDA-Intel.pcm.hdmi.3 {
>  	}
>  }
>  
> +HDA-Intel.pcm.hdmi.4 {
> +	@args [ CARD AES0 AES1 AES2 AES3 ]
> +	@args.CARD { type string }
> +	@args.AES0 { type integer }
> +	@args.AES1 { type integer }
> +	@args.AES2 { type integer }
> +	@args.AES3 { type integer }
> +	@func refer
> +	name {
> +		@func concat
> +		strings [
> +			"cards.HDA-Intel.pcm.hdmi.common:"
> +			"CARD=" $CARD ","
> +			"DEVICE=10,"
> +			"CTLINDEX=4,"
> +			"AES0=" $AES0 ","
> +			"AES1=" $AES1 ","
> +			"AES2=" $AES2 ","
> +			"AES3=" $AES3
> +		]
> +	}
> +}
> +
> +HDA-Intel.pcm.hdmi.5 {
> +	@args [ CARD AES0 AES1 AES2 AES3 ]
> +	@args.CARD { type string }
> +	@args.AES0 { type integer }
> +	@args.AES1 { type integer }
> +	@args.AES2 { type integer }
> +	@args.AES3 { type integer }
> +	@func refer
> +	name {
> +		@func concat
> +		strings [
> +			"cards.HDA-Intel.pcm.hdmi.common:"
> +			"CARD=" $CARD ","
> +			"DEVICE=11,"
> +			"CTLINDEX=5,"
> +			"AES0=" $AES0 ","
> +			"AES1=" $AES1 ","
> +			"AES2=" $AES2 ","
> +			"AES3=" $AES3
> +		]
> +	}
> +}
> +
> +HDA-Intel.pcm.hdmi.6 {
> +	@args [ CARD AES0 AES1 AES2 AES3 ]
> +	@args.CARD { type string }
> +	@args.AES0 { type integer }
> +	@args.AES1 { type integer }
> +	@args.AES2 { type integer }
> +	@args.AES3 { type integer }
> +	@func refer
> +	name {
> +		@func concat
> +		strings [
> +			"cards.HDA-Intel.pcm.hdmi.common:"
> +			"CARD=" $CARD ","
> +			"DEVICE=12,"
> +			"CTLINDEX=6,"
> +			"AES0=" $AES0 ","
> +			"AES1=" $AES1 ","
> +			"AES2=" $AES2 ","
> +			"AES3=" $AES3
> +		]
> +	}
> +}
> +
> +HDA-Intel.pcm.hdmi.7 {
> +	@args [ CARD AES0 AES1 AES2 AES3 ]
> +	@args.CARD { type string }
> +	@args.AES0 { type integer }
> +	@args.AES1 { type integer }
> +	@args.AES2 { type integer }
> +	@args.AES3 { type integer }
> +	@func refer
> +	name {
> +		@func concat
> +		strings [
> +			"cards.HDA-Intel.pcm.hdmi.common:"
> +			"CARD=" $CARD ","
> +			"DEVICE=13,"
> +			"CTLINDEX=7,"
> +			"AES0=" $AES0 ","
> +			"AES1=" $AES1 ","
> +			"AES2=" $AES2 ","
> +			"AES3=" $AES3
> +		]
> +	}
> +}
> +
>  <confdir:pcm/modem.conf>
>  
>  HDA-Intel.pcm.modem.0 {
> 


-- 
Anssi Hannula
