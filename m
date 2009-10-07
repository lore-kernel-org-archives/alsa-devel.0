From: jmal8295 <jmal8295@artax.karlin.mff.cuni.cz>
Subject: Re: [alsa-cvslog] alsa-kernel: Official ALSA project
 GIT repository for Linux 2.6 branch, master now at v2.6.31-rc8-407-gfc9e4a3
Date: Wed, 7 Oct 2009 09:07:55 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0910070840250.20794@artax.karlin.mff.cuni.cz>
References: <20091006063609.B06E110381F@alsa0.perex.cz>
	<s5hab05role.wl%tiwai@suse.de> <4ACAF4AC.3000608@ladisch.de>
	<Pine.LNX.4.64.0910061955510.18975@artax.karlin.mff.cuni.cz>
	<4ACC35B2.5030508@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from artax.karlin.mff.cuni.cz (artax.karlin.mff.cuni.cz
	[195.113.26.195])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A8E424483
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Oct 2009 09:07:56 +0200 (CEST)
In-Reply-To: <4ACC35B2.5030508@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> jmal8295 wrote:
> > On Tue, 6 Oct 2009, Clemens Ladisch wrote:
> > > Takashi Iwai wrote:
> > > > noreply-git@alsa-project.org wrote:
> > > > > commit fc9e4a3811567f8d1d4c263a89e27b52c90d6098
> 
> http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=fc9e4a3811567f8d1d4c263a89e27b52c90d6098
> 
> > > > > Author:     Clemens Ladisch <clemens@ladisch.de>
> > > > > AuthorDate: Tue Oct 6 08:21:04 2009 +0200
> > > > > 
> > > > >     sound: via82xx: move DXS volume controls to PCM interface
> > > > >     
> > > > >     The "VIA DXS" controls are actually volume controls that apply to the
> > > > >     four PCM substreams, so we better indicate this connection by moving the
> > > > >     controls to the PCM interface.
> > 
> > By "moving" you mean removing them or will there appear somewhere else?
> 
> Changing the interface from MIXER to PCM means that the controls will
> not appear in most mixer applications.
> 
> > > Honza, are you still using this driver?
> > 
> > Yes I do (there is a different driver for this codec?).
> 
> No, it's just rather old.
> I hoped you'd be using newer hardware by now.  ;-)
> 
Its true I plan to buy new computer soon, but I will be still using this 
one.

> > And I _will_ be regarding it as regression if I lose possibility to
> > change volume of the four streams independently.
> > On the other hand, I do change the volume only manually (not
> > automatically by program), so if only thing which changes is the way how
> > to modify that volume I would not see problem in that.
> 
> With the new controls, the only way to change them would be on the
> command line:
>   amixer cset iface=PCM,name="PCM Playback Volume",subdevice=x yy
> 
Hmmm ... that is almost as cumbersome as it could be. Is it at least 
planed to add it to some other mixer, like alsamixer? Another view 
perhaps?

Still better that removing them.

> BTW: How do you determine which of the four controls is associated with
> a specific application?
> 

Trial and error :-). Usually I know what started first and if I get it 
wrong, I'll try another one.
I don't suppose any change could help me with it. I mean, only syntax 
which I imagine would help is
  amixer cset iface=PCM,name="PCM Playback Volume",subdevice=pid:17345
but don't suppose someone will be adding code for examining pid 17345's 
descriptors in that case to amixer, much less alsamixer.

> 
> In any case, the main purpose of the patch was to rename the controls to
> prevent "alsactl restore" from restoring the old wrong volume setting,
> so it would suffice to just change the controls' name in some way, such
> as from "VIA DXS" to "DXS".
> 

I would propose to use this oportunity to rename them to something more 
descriptive, but I have no idea what that could be (considering limited 
space in mixer programs).
	Honza

> 
> Best regards,
> Clemens
> 
