From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Improving or replacing snd_printk()
Date: Thu, 30 May 2013 20:49:09 +0200
Message-ID: <51A79F25.6040007@perex.cz>
References: <Pine.LNX.4.44L0.1305301411370.1137-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E610261A5C
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2013 20:49:09 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.44L0.1305301411370.1137-100000@iolanthe.rowland.org>
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
Cc: Joe Perches <joe@perches.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Date 30.5.2013 20:14, Alan Stern wrote:
> On Wed, 29 May 2013, Joe Perches wrote:
> 
>> On Wed, 2013-05-29 at 15:27 -0400, Alan Stern wrote:
>>> Has there been any thought of improving snd_printk(), or even better,
>>> changing the call sites to use the dev_*() routines instead?
>>
>> Perhaps better would be to add and use some combination of
>> type specific logging message functions/macros like:
>>
>> void snd_<level>(const struct snd_device *dev, const char *fmt, ...)
>> void snd_card_<level>(const struct snd_card *card, const char *fmt, ...)
>> void snd_ac97_<level>(const struct snd_ac97 *ac97, const char *fmt, ...)
>>
>> allowing NULL as the type pointer when necessary/appropriate.
> 
> Almost anything would be better than the current situation.  The only 
> enhancement provided by CONFIG_SND_VERBOSE_PRINTK is to print the 
> filename and line number, which is relatively unhelpful (unless there 
> are multiple copies of the same message in several places).

I don't think that it's useless to see the origin of the source message
from the first glance. It may be improved, of course, but adding more
and more functions with minor benefits is another step to another hell.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
