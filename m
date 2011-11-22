From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 4/6] compress: add API header and driver
 header	files
Date: Tue, 22 Nov 2011 12:18:54 +0100
Message-ID: <4ECB851E.7010806@ladisch.de>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1321951920-4363-5-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id E245C24615
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 12:18:56 +0100 (CET)
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id C63CE20E09
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 06:18:55 -0500 (EST)
In-Reply-To: <1321951920-4363-5-git-send-email-vinod.koul@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Vinod Koul wrote:
> This patch adds the header files for ioctl definations and header file for
> driver APIs for lower level device drivers to use

> +++ b/include/sound/compress_offload.h
> ...
> +#define SNDRV_COMPRESS_GET_CAPS		_IOWR('C', 0x00, struct snd_compr_caps *)
> +#define SNDRV_COMPRESS_GET_CODEC_CAPS	_IOWR('C', 0x01, struct snd_compr_codec_caps *)
> +#define SNDRV_COMPRESS_SET_PARAMS	_IOW('C', 0x02, struct snd_compr_params *)
> +#define SNDRV_COMPRESS_GET_PARAMS	_IOR('C', 0x03, struct snd_compr_params *)
> +#define SNDRV_COMPRESS_TSTAMP		_IOR('C', 0x10, struct snd_compr_tstamp *)
> +#define SNDRV_COMPRESS_AVAIL		_IOR('C', 0x11, struct snd_compr_avail *)

The type whose size is made part of the ioctl number is supposed to be
the actual structure, not a pointer to it.


Regards,
Clemens
