From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] ALSA: get rid of CONFIG_SND_VERBOSE_PRINTK
Date: Mon, 3 Jun 2013 16:40:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1306031639250.1304-100000@iolanthe.rowland.org>
References: <1370291080.2385.8.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
 by alsa0.perex.cz (Postfix) with SMTP id 4F2B426500C
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2013 22:40:45 +0200 (CEST)
In-Reply-To: <1370291080.2385.8.camel@joe-AO722>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Joe Perches <joe@perches.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 3 Jun 2013, Joe Perches wrote:

> On Mon, 2013-06-03 at 16:18 -0400, Alan Stern wrote:
> > According to Takashi Iwai, CONFIG_SND_VERBOSE_PRINTK is "useless".  All 
> > it does is add filenames and line numbers to certain log messages.
> > This patch gets rid of it.
> []
> > Updating all the snd_printk() and snd_printd() calls will be a huge
> > job.  Getting rid of the verbose logging is a lot easier, so that's
> > where I'm starting.
> 
> cocci and emacs can make this pretty simple.

I wish they could, but I sincerely doubt that this conversion can be 
mechanized.  At least, not if it is to be done correctly.

> > --- usb-3.10.orig/include/sound/core.h
> []
> > -#if defined(CONFIG_SND_DEBUG) || defined(CONFIG_SND_VERBOSE_PRINTK)
> > +#if defined(CONFIG_SND_DEBUG)
> >  __printf(4, 5)
> >  void __snd_printk(unsigned int level, const char *file, int line,
> >                   const char *format, ...);
> > @@ -349,7 +349,7 @@ void __snd_printk(unsigned int level, co
> >   * @fmt: format string
> >   *
> >   * Works like printk() but prints the file and the line of the caller
> > - * when configured with CONFIG_SND_VERBOSE_PRINTK.
> > + * when configured with CONFIG_SND_DEBUG.
> >   */
> >  #define snd_printk(fmt, args...) \
> >         __snd_printk(0, __FILE__, __LINE__, fmt, ##args)
> 
> Please change the __snd_printk macros to remove __FILE__ and
> __LINE__ (or 0, and 0) to remove some text from the objects.

Will do.  I should have realized that originally...

Alan Stern
