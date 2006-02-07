From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH] hda: minor correction to fujitsu ALC260 initverbs
Date: Wed, 8 Feb 2006 09:03:29 +1030 (CST)
Message-ID: <200602072233.k17MXTuD016803@auster.physics.adelaide.edu.au>
References: <s5h64nqyime.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h64nqyime.wl%tiwai@suse.de> from "Takashi Iwai" at Feb 07, 2006 10:16:41 PM
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi

> > The following patch changes the initverbs associated with the output sum
> > widgets 0x08, 0x09 and 0x0a used with the fujitsu model in patch_realtek.c.
> > It is against alsa 1.0.11rc3.
> > 
> > Currently these widgets have their output muted, but a close reading of the
> > datasheet suggests that they don't actually have an output mute.  They have
> > an *input* mute for each of their two inputs and a single output gain. This
> > patch therefore activates the input mutes and zeros the output gain.  It has
> > not yet been tested but the above interpretation of the ALC260 datasheet
> > seems correct.
> 
> So, should this be applied even without your patch?

Yes, it applies irrespective of whether my other patches go in or not. Among
other things, it ensures the mixer comes up in a predictable state. Without
this change the mutes of the sum widgets are not explicitly set on loading,
so they come up in whatever state they were in prior to loading the module.

Regards
  jonathan


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
