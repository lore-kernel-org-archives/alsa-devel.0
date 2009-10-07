From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-cvslog] alsa-kernel: Official ALSA project
 GIT repository for Linux 2.6 branch, master now at v2.6.31-rc8-407-gfc9e4a3
Date: Wed, 07 Oct 2009 08:31:14 +0200
Message-ID: <4ACC35B2.5030508@ladisch.de>
References: <20091006063609.B06E110381F@alsa0.perex.cz>
	<s5hab05role.wl%tiwai@suse.de> <4ACAF4AC.3000608@ladisch.de>
	<Pine.LNX.4.64.0910061955510.18975@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id B800E24452
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Oct 2009 08:31:19 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.0910061955510.18975@artax.karlin.mff.cuni.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jmal8295 <jmal8295@artax.karlin.mff.cuni.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

jmal8295 wrote:
> On Tue, 6 Oct 2009, Clemens Ladisch wrote:
> > Takashi Iwai wrote:
> > > noreply-git@alsa-project.org wrote:
> > > > commit fc9e4a3811567f8d1d4c263a89e27b52c90d6098

http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=fc9e4a3811567f8d1d4c263a89e27b52c90d6098

> > > > Author:     Clemens Ladisch <clemens@ladisch.de>
> > > > AuthorDate: Tue Oct 6 08:21:04 2009 +0200
> > > > 
> > > >     sound: via82xx: move DXS volume controls to PCM interface
> > > >     
> > > >     The "VIA DXS" controls are actually volume controls that apply to the
> > > >     four PCM substreams, so we better indicate this connection by moving the
> > > >     controls to the PCM interface.
> 
> By "moving" you mean removing them or will there appear somewhere else?

Changing the interface from MIXER to PCM means that the controls will
not appear in most mixer applications.

> > Honza, are you still using this driver?
> 
> Yes I do (there is a different driver for this codec?).

No, it's just rather old.
I hoped you'd be using newer hardware by now.  ;-)

> And I _will_ be regarding it as regression if I lose possibility to
> change volume of the four streams independently.
> On the other hand, I do change the volume only manually (not
> automatically by program), so if only thing which changes is the way how
> to modify that volume I would not see problem in that.

With the new controls, the only way to change them would be on the
command line:
  amixer cset iface=PCM,name="PCM Playback Volume",subdevice=x yy

BTW: How do you determine which of the four controls is associated with
a specific application?


In any case, the main purpose of the patch was to rename the controls to
prevent "alsactl restore" from restoring the old wrong volume setting,
so it would suffice to just change the controls' name in some way, such
as from "VIA DXS" to "DXS".


Best regards,
Clemens
