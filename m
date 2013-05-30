From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Improving or replacing snd_printk()
Date: Thu, 30 May 2013 14:14:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1305301411370.1137-100000@iolanthe.rowland.org>
References: <1369857112.22004.119.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
 by alsa0.perex.cz (Postfix) with SMTP id E396F261A5B
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2013 20:14:58 +0200 (CEST)
In-Reply-To: <1369857112.22004.119.camel@joe-AO722>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 29 May 2013, Joe Perches wrote:

> On Wed, 2013-05-29 at 15:27 -0400, Alan Stern wrote:
> > Has there been any thought of improving snd_printk(), or even better,
> > changing the call sites to use the dev_*() routines instead?
> 
> Perhaps better would be to add and use some combination of
> type specific logging message functions/macros like:
> 
> void snd_<level>(const struct snd_device *dev, const char *fmt, ...)
> void snd_card_<level>(const struct snd_card *card, const char *fmt, ...)
> void snd_ac97_<level>(const struct snd_ac97 *ac97, const char *fmt, ...)
> 
> allowing NULL as the type pointer when necessary/appropriate.

Almost anything would be better than the current situation.  The only 
enhancement provided by CONFIG_SND_VERBOSE_PRINTK is to print the 
filename and line number, which is relatively unhelpful (unless there 
are multiple copies of the same message in several places).

Alan Stern
