From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 8/8] modify Makefile and Kconfig to build this module
Date: Mon, 03 Jun 2013 13:19:00 +0200
Message-ID: <51AC7BA4.4020804@ladisch.de>
References: <1370102158-24389-1-git-send-email-o-takashi@sakamocchi.jp>
	<1370102158-24389-9-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1370102158-24389-9-git-send-email-o-takashi@sakamocchi.jp>
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
> +config SND_FIREWORKS
> +	tristate "Echo Fireworks chipset support"
> +	select SND_PCM
> +	select SND_RAWMIDI
> +	select SND_FIREWIRE_LIB
> +	help
> +	  Say Y here to include support for FireWire devices based
> +	  on Echo Digital Audio's Fireworks architecture:
> +	  * Echo AudioFire 2/4/8/8a/Pre8/12
> +	  * Echo Fireworks 8/HDMI
> +	  * Gibson Goldtop/RIP
> +	  * Mackie Onyx 400F/1200F
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called snd-fireworks.

We'll have to find some mechanism to prevent FFADO from blowing up just
because a distribution update has introduced this driver.


Regards,
Clemens

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite
It's a free troubleshooting tool designed for production
Get down to code-level detail for bottlenecks, with <2% overhead.
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap2
