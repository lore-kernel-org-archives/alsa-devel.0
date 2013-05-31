From: Joe Perches <joe@perches.com>
Subject: Re: Improving or replacing snd_printk()
Date: Fri, 31 May 2013 00:30:09 -0700
Message-ID: <1369985409.10556.51.camel@joe-AO722>
References: <Pine.LNX.4.44L0.1305301411370.1137-100000@iolanthe.rowland.org>
 <51A79F25.6040007@perex.cz> <s5hr4gniri4.wl%tiwai@suse.de>
 <1369983967.10556.48.camel@joe-AO722> <s5hip1zipde.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from labridge.com (perches-mx.perches.com [206.117.179.246])
 by alsa0.perex.cz (Postfix) with ESMTP id E8C54261684
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2013 09:30:10 +0200 (CEST)
In-Reply-To: <s5hip1zipde.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Alan Stern <stern@rowland.harvard.edu>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2013-05-31 at 09:23 +0200, Takashi Iwai wrote:
> At Fri, 31 May 2013 00:06:07 -0700, Joe Perches wrote:
> > On Fri, 2013-05-31 at 08:37 +0200, Takashi Iwai wrote:
> > > I think most of snd_printd() and snd_printdd() can be kept as is.
> > > These are just debug messages, after all.
> > Some of those are emitted at levels other than KERN_DEBUG.
> > I think that odd.
> Yeah, they aren't good, but it's a different topic.

Not really, I think it's systemic and fallout from
accretive implementation rather than design.
