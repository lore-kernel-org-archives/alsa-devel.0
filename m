From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] [PATCH 1/4] Rename functions, structure and member
	name for AMDTP
Date: Sun, 28 Apr 2013 14:52:38 +0200
Message-ID: <517D1B96.3070304@ladisch.de>
References: <1367125334-446-1-git-send-email-o-takashi@sakamocchi.jp>
	<1367125334-446-2-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1367125334-446-2-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, perex@perex.cz
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> This patch rename some functions, structure and member name to reuse them
> in both AMDTP receive and AMDTP transmit stream.

> +++ b/sound/firewire/amdtp.c

> -int amdtp_out_stream_init(struct amdtp_out_stream *s, struct fw_unit *unit,
> -			  enum cip_out_flags flags)
> +int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
> +			  enum cip_flags flags)

Please adjust the indentation in such cases.


Regards,
Clemens

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
