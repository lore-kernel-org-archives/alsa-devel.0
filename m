From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Request for test (1.0.18 final)
Date: Tue, 28 Oct 2008 12:53:08 +0100
Message-ID: <4906FD24.608@ladisch.de>
References: <Pine.LNX.4.61.0810271449320.12044@tm8103.perex-int.cz>	<4905F6EB.8080507@gmail.com>	<4906C822.7070807@ladisch.de>
	<s5hr6615asc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 7AE7B24400
	for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2008 12:53:12 +0100 (CET)
In-Reply-To: <s5hr6615asc.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> IIRC, the hack was needed at the time alsa-driver's kconfig parser
> didn't parse the tea575x dependency correctly.  So, the whole hack should
> be removed now.
>
> How about the patch below?
>
> --- a/i2c/other/Makefile
> +++ b/i2c/other/Makefile
> @@ -5,17 +5,8 @@ endif
>  include $(SND_TOPDIR)/toplevel.config
>  include $(SND_TOPDIR)/Makefile.conf
>
> -export-objs += ak4xxx-adda.o ak4114.o ak4117.o pt2258.o
> -
> -# Toplevel Module Dependency
> -# hack for tea575x support
> -ifeq (y,$(CONFIG_VIDEO_DEV))
> -obj-$(CONFIG_SND_FM801) += snd-tea575x-tuner.o
> -ifeq (m,$(CONFIG_SND_FM801))
> -export-objs += tea575x-tuner.o
> +export-objs += ak4xxx-adda.o ak4114.o ak4117.o pt2258.o tea575x-tuner.o
>  clean-files += tea575x-tuner.c
> -endif
> -endif
>
>  include $(SND_TOPDIR)/alsa-kernel/i2c/other/Makefile

AFAICS snd-tea575x-tuner is not compiled at all; it should have:

obj-$(CONFIG_SND_FM801_TEA575X) += snd-tea575x-tuner.o

And it looks as if the usual dependencies for patched files are missing:

tea575x-tuner.c: tea575x-tuner.patch $(SND_TOPDIR)/alsa-kernel/i2c/other/tea575x-tuner.c


Regards,
Clemens
