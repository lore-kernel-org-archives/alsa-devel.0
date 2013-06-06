From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/2] ALSA: convert "snd_printk(KERN_INFO"
	to "pr_info("
Date: Thu, 6 Jun 2013 16:54:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1306061643290.878-100000@iolanthe.rowland.org>
References: <s5hppw1rtnx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
 by alsa0.perex.cz (Postfix) with SMTP id 70212261ABB
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2013 22:54:07 +0200 (CEST)
In-Reply-To: <s5hppw1rtnx.wl%tiwai@suse.de>
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

On Wed, 5 Jun 2013, Takashi Iwai wrote:

> At Tue, 4 Jun 2013 13:20:40 -0400 (EDT),
> Alan Stern wrote:
> > 
> > The snd_printk() function prints kernel log messages, including the
> > filename and line number if CONFIG_SND_PRINTK_VERBOSE is enabled.
> > This may make sense for errors and warnings, but not for informational
> > messages.  For those, a simple pr_info() is what we want.
> > 
> > This patch mechanically converts all occurrences of
> > "snd_printk(KERN_INFO" to "pr_info(".  It doesn't try to tell whether
> > the message really is informational; it relies on the existing
> > KERN_INFO tag.
> 
> I agree conversion in this way.  But looking at the patch, some places
> should be better convert with pr_warning() or pr_err().

How often do those places get printed?  I would assume that warnings 
and errors are relatively infrequent, in which case there would be no 
harm in changing "snd_printk(KERN_INFO" to "snd_printk(KERN_WARN" or 
"snd_printk(KERN_ERR".

> Also, many places miss proper prefix, thus you'll still see the

What exactly do you mean by "proper prefix"?  KBUILD_MODNAME?  The 
filename and line number?  The device and driver names?  Or something 
else?

> original issue the thread started from (no clue who prints the stuff).
> This is because originally snd_printk() printed the prefix and line
> number always.  CONFIG_SND_VERBOSE_PRINTK was introduced later since
> some people complained about too verbose output, IIRC, while many
> codes weren't fixed to give a proper prefix with
> CONFIG_SND_VERBOSE_PRINTK=n.

After this patch (or after an updated version of this patch), none of 
the snd_printk calls will be informational.  They will all be things 
like errors and warnings.  This means they won't get printed very 
often, so always using the verbose form shouldn't make things too bad.

> Just taking a quick glance:
> 
> > --- usb-3.10.orig/sound/isa/opti9xx/miro.c
> > +++ usb-3.10/sound/isa/opti9xx/miro.c
> > @@ -1346,11 +1346,11 @@ static int snd_miro_probe(struct snd_car
> >  		default:
> >  			sprintf(card->shortname, 
> >  				"unknown miro");
> > -			snd_printk(KERN_INFO "unknown miro aci id\n");
> > +			pr_info("unknown miro aci id\n");
> >  			break;
> >  		}
> >  	} else {
> > -		snd_printk(KERN_INFO "found unsupported aci card\n");
> > +		pr_info("found unsupported aci card\n");
> >  		sprintf(card->shortname, "unknown Cardinal Technologies");
> 
> These need proper prefix, and should be rather pr_warning().

I don't understand.  pr_warning doesn't print any prefixes, by default.  
They would have to added to the format string.  Why not change it to 
"snd_printk(KERN_WARN"?

Alan Stern
