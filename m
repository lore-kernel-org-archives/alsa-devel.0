From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] [PATCH 23/44] fireworks: Add proc interface for
	debugging purpose
Date: Thu, 03 Apr 2014 23:16:49 +0200
Message-ID: <533DCFC1.50300@ladisch.de>
References: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
	<1395400229-22957-24-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1395400229-22957-24-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net, perex@perex.cz
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> This commit adds proc interface to output infomation for debugging.
>  - firmware information
>  - sampling rate and clock source
>  - physical metering (linear value)
>
> +++ b/sound/firewire/fireworks/fireworks.c
> @@ -133,6 +133,16 @@ get_hardware_info(struct snd_efw *efw)
> +	/* hardware metering */
> +	efw->phys_out = hwinfo->phys_out;
> +	efw->phys_in = hwinfo->phys_in;
> +	efw->phys_out_grp_count = hwinfo->phys_out_grp_count;
> +	efw->phys_in_grp_count = hwinfo->phys_in_grp_count;

The driver relies on these values being correct.  It will blow up
if^H^Hwhen the firmware makes these values overflow.


Regards,
Clemens

------------------------------------------------------------------------------
