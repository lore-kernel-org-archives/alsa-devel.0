From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] ALSA: get rid of CONFIG_SND_VERBOSE_PRINTK
Date: Mon, 03 Jun 2013 13:24:40 -0700
Message-ID: <1370291080.2385.8.camel@joe-AO722>
References: <Pine.LNX.4.44L0.1306031612520.1304-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from labridge.com (perches-mx.perches.com [206.117.179.246])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F9A526500C
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2013 22:24:42 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.44L0.1306031612520.1304-100000@iolanthe.rowland.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2013-06-03 at 16:18 -0400, Alan Stern wrote:
> According to Takashi Iwai, CONFIG_SND_VERBOSE_PRINTK is "useless".  All 
> it does is add filenames and line numbers to certain log messages.
> This patch gets rid of it.
[]
> Updating all the snd_printk() and snd_printd() calls will be a huge
> job.  Getting rid of the verbose logging is a lot easier, so that's
> where I'm starting.

cocci and emacs can make this pretty simple.

> --- usb-3.10.orig/include/sound/core.h
[]
> -#if defined(CONFIG_SND_DEBUG) || defined(CONFIG_SND_VERBOSE_PRINTK)
> +#if defined(CONFIG_SND_DEBUG)
>  __printf(4, 5)
>  void __snd_printk(unsigned int level, const char *file, int line,
>                   const char *format, ...);
> @@ -349,7 +349,7 @@ void __snd_printk(unsigned int level, co
>   * @fmt: format string
>   *
>   * Works like printk() but prints the file and the line of the caller
> - * when configured with CONFIG_SND_VERBOSE_PRINTK.
> + * when configured with CONFIG_SND_DEBUG.
>   */
>  #define snd_printk(fmt, args...) \
>         __snd_printk(0, __FILE__, __LINE__, fmt, ##args)

Please change the __snd_printk macros to remove __FILE__ and
__LINE__ (or 0, and 0) to remove some text from the objects.
