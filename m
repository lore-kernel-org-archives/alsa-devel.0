From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 1/8] ALSA: core: Constify the name in new
	kcontrols
Date: Fri, 17 Feb 2012 09:50:30 +0000
Message-ID: <1329472230.3972.10.camel@odin>
References: <1329458170-22119-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog126.obsmtp.com (na3sys009aog126.obsmtp.com
	[74.125.149.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 14FF22453E
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 10:50:46 +0100 (CET)
Received: by wibhm14 with SMTP id hm14so1946565wib.37
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 01:50:32 -0800 (PST)
In-Reply-To: <1329458170-22119-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2012-02-16 at 21:56 -0800, Mark Brown wrote:
> We never modify it and this lets us use a const string as the name without
> warnings.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  include/sound/control.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/include/sound/control.h b/include/sound/control.h
> index b2796e8..57815f6 100644
> --- a/include/sound/control.h
> +++ b/include/sound/control.h
> @@ -40,7 +40,7 @@ struct snd_kcontrol_new {
>  	snd_ctl_elem_iface_t iface;	/* interface identifier */
>  	unsigned int device;		/* device/client number */
>  	unsigned int subdevice;		/* subdevice (substream) number */
> -	unsigned char *name;		/* ASCII name of item */
> +	const unsigned char *name;	/* ASCII name of item */
>  	unsigned int index;		/* index of item */
>  	unsigned int access;		/* access rights */
>  	unsigned int count;		/* count of same elements */

All 

Acked-by: Liam Girdwood <lrg@ti.com>

I'll do some incremental updates for platform and ABE support.

Liam
