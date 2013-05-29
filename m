From: Joe Perches <joe@perches.com>
Subject: Re: Improving or replacing snd_printk()
Date: Wed, 29 May 2013 12:51:52 -0700
Message-ID: <1369857112.22004.119.camel@joe-AO722>
References: <Pine.LNX.4.44L0.1305291516090.885-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1305291516090.885-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2013-05-29 at 15:27 -0400, Alan Stern wrote:
> Has there been any thought of improving snd_printk(), or even better,
> changing the call sites to use the dev_*() routines instead?

Perhaps better would be to add and use some combination of
type specific logging message functions/macros like:

void snd_<level>(const struct snd_device *dev, const char *fmt, ...)
void snd_card_<level>(const struct snd_card *card, const char *fmt, ...)
void snd_ac97_<level>(const struct snd_ac97 *ac97, const char *fmt, ...)

allowing NULL as the type pointer when necessary/appropriate.
