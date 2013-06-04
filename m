From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] ALSA: get rid of CONFIG_SND_VERBOSE_PRINTK
Date: Tue, 4 Jun 2013 10:49:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1306041041430.1093-100000@iolanthe.rowland.org>
References: <s5h8v2qxmqp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
 by alsa0.perex.cz (Postfix) with SMTP id 2D878265134
 for <alsa-devel@alsa-project.org>; Tue,  4 Jun 2013 16:49:24 +0200 (CEST)
In-Reply-To: <s5h8v2qxmqp.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Joe Perches <joe@perches.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 4 Jun 2013, Takashi Iwai wrote:

> At Mon, 3 Jun 2013 16:18:49 -0400 (EDT),
> Alan Stern wrote:
> > 
> > According to Takashi Iwai, CONFIG_SND_VERBOSE_PRINTK is "useless".  All 
> > it does is add filenames and line numbers to certain log messages.
> 
> No, I did't mean it.  The file name and line number are useful.
> What's useless is to let user select CONFIG_SND_VERBOSE_PRINTK.
> If the extra information can be annoying, the driver should use the
> plain printk() or whatever from the beginning.  If the driver code
> chooses snd_printk(), it implies that it wants extra information.

Although most of the calls to snd_printk() are for errors and warnings,
some of them are just informational.  You don't mind having those
messages suddenly including the filename and line number?  (At least, 
until someone gets around to changing them to printk() or something 
else...)

Alan Stern
