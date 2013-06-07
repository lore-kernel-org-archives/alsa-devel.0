From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/2] ALSA: convert "snd_printk(KERN_INFO"
	to "pr_info("
Date: Fri, 7 Jun 2013 11:51:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1306071136290.1366-100000@iolanthe.rowland.org>
References: <s5hr4geqxz9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
 by alsa0.perex.cz (Postfix) with SMTP id 825602610CA
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2013 17:51:15 +0200 (CEST)
In-Reply-To: <s5hr4geqxz9.wl%tiwai@suse.de>
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

On Fri, 7 Jun 2013, Takashi Iwai wrote:

> > > I agree conversion in this way.  But looking at the patch, some places
> > > should be better convert with pr_warning() or pr_err().
> > 
> > How often do those places get printed?  I would assume that warnings 
> > and errors are relatively infrequent, in which case there would be no 
> > harm in changing "snd_printk(KERN_INFO" to "snd_printk(KERN_WARN" or 
> > "snd_printk(KERN_ERR".
> 
> Yes.  That's my intention, too.  These shouldn't have been KERN_INFO
> from the beginning.

Okay.

> > > Also, many places miss proper prefix, thus you'll still see the
> > 
> > What exactly do you mean by "proper prefix"?  KBUILD_MODNAME?  The 
> > filename and line number?  The device and driver names?  Or something 
> > else?
> 
> I don't mind any way if it's unique enough to identify from where the
> message comes, but some people prefer (over-)unification.
> Usually KBUILD_MODNAME should suffice, I guess, but still function
> name or file name might be needed in addition if similar messages
> appear multiple times in the same driver.  This must be all
> case-by-case decision.

For the messages that get converted to "snd_printk(KERN_ERR", the 
prefix added by snd_printk() when CONFIG_SND_VERBOSE_PRINTK is enabled 
should be sufficient.  Following the 2/2 patch in this series, that 
symbol will effectively _always_ be enabled.  Therefore these messages 
shouldn't need any extra prefix.

The ones that get converted to pr_info() probably will need a short
prefix of some kind, though.

> > > These need proper prefix, and should be rather pr_warning().
> > 
> > I don't understand.  pr_warning doesn't print any prefixes, by default.  
> > They would have to added to the format string.  Why not change it to 
> > "snd_printk(KERN_WARN"?
> 
> Yes, this should be snd_printk(KERN_WARN) *and* it needs a proper
> prefix depending on CONFIG_SND_VERBOSE_PRINTK:
> 
> #ifdef CONFIG_SND_VERBOSE_PRINTK
> #define PREFIX	""
> #else
> #define PREFIX	"miro: "
> #endif
> ....
> 	snd_printk(KERN_WARNING PFX "found unsupported aci card\n");

There's no point using PREFIX (or PFX) here, since the 2/2 patch would
eliminate the second #define anyway.

> The same check should be applied to all snd_printk() lines.
> 
> Once after all snd_printk() have the unified prefix, we can convert
> straightforwardly like
> 
> #define pr_fmt	"miro: "
> ....
> 	pr_warn("found unsupported aci card\n");

Ultimately, it will be better to change these to dev_warn() or
something equivalent.  Then the "miro:" prefix wouldn't be needed.  
However, doing what you suggest might be a reasonable intermediate 
step, aside from for all the additional work required.

> In other words, toward the final conversions, we need to audit:
> - Whether each message is really marked properly with KERN_* level,
> - Whether messages have consistent prefix through the whole module,
> - whether messages are unique enough to be identified,
> - optionally, check typos

I'm willing to do the first step for the messages that were altered in
the 1/2 patch (but I don't want to audit every message under sound/).  
The second step shouldn't be needed, according to the reasoning above.

The third step is something that will have to be done on a 
driver-by-driver basis, since it requires looking through all the 
messages in each driver at once to determine if there are any 
duplicates.  I don't want to tackle that (except perhaps for the USB 
drivers).

Finally, typos can be fixed separately.

Alan Stern
