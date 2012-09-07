From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH 01/11] ALSA: implement
	MEDIA_IOC_DEVICE_INFO
Date: Fri, 7 Sep 2012 10:13:10 +0800
Message-ID: <20120907021309.GD6827@opensource.wolfsonmicro.com>
References: <503BF48E.1090100@ladisch.de>
 <503BF4CD.6000207@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 083EB261672
 for <alsa-devel@alsa-project.org>; Fri,  7 Sep 2012 04:21:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <503BF4CD.6000207@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 28, 2012 at 12:29:33AM +0200, Clemens Ladisch wrote:

> +config SND_MEDIA
> +	bool "Media Controller API (EXPERIMENTAL)"
> +	depends on EXPERIMENTAL
> +	help
> +	  Say Y here to enable the media controller API, which allows to
> +	  retrieve the internal topology of sound devices.

I think there's a general consensus these days that EXPERIMENTAL is
pretty meaningless so we probably shouldn't bother with it.  The text is
also a bit confusing, it enables use of the media controller API for
ALSA devices really.

I have to say I'm also a bit surprised that there's no core framework
for media controller and we're open coding ioctl() implementations here,
I'd have thought there would at least be a way of enumerating all media
controller devices in the system...
