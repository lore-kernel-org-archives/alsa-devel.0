From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/8] add main file of driver module
Date: Mon, 03 Jun 2013 13:18:17 +0200
Message-ID: <51AC7B79.5050007@ladisch.de>
References: <1370102158-24389-1-git-send-email-o-takashi@sakamocchi.jp>
	<1370102158-24389-2-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1370102158-24389-2-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: o-takashi@sakamocchi.jp
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net, perex@perex.cz
List-Id: alsa-devel@alsa-project.org

o-takashi@sakamocchi.jp wrote:
> +#define VENDOR_ECHO_DIGITAL_AUDIO	0x001486
> +#define  MODEL_ECHO_AUDIOFIRE_2		0x000af2
> +#define  MODEL_ECHO_AUDIOFIRE_4		0x000af4
> +#define  MODEL_ECHO_AUDIOFIRE_8		0x000af8
> +/* #define  MODEL_ECHO_AUDIOFIRE_8A	0x?????? */
> +/* #define  MODEL_ECHO_AUDIOFIRE_PRE8	0x?????? */

The 8a has ID 0x000af9; please also add the Pre8 ID.


Regards,
Clemens

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite
It's a free troubleshooting tool designed for production
Get down to code-level detail for bottlenecks, with <2% overhead.
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap2
