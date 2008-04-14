From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Mon, 14 Apr 2008 18:56:32 +0200
Message-ID: <20080414165632.GF22115@tango.0pointer.de>
References: <20080411204610.GA32413@tango.0pointer.de>
	<20080412133536.GC32491@tango.0pointer.de>
	<4800FC14.3060804@superbug.co.uk>
	<200804122025.57165.faber@faberman.de>
	<48010CF9.4000600@superbug.co.uk> <20080412214143.GB2828@localhost>
	<48012FD7.6050904@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 881BA2459F
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Apr 2008 18:56:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48012FD7.6050904@superbug.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Florian Faber <faber@faberman.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, 12.04.08 22:55, James Courtier-Dutton (James@superbug.co.uk) wrote:

> > That would be reasonable for consumer cards. Pro sound cards should
> > never initialise themselves to anything other than minimum gain.
> >
> > John
> >   
> 
> I think everyone is misunderstanding the issue here.
> All ALSA sound cards, without any intervention from user space, will 
> boot up with ALL SOUND MUTED.
> Most distros then have an /etc/init.d startup script that restores sound 
> card levels to the previous state before the previous power off.
> The problem is, what to do the first time the system is installed. I.e. 
> No "previous state" exists.
> a) General users will normally want some level of sound by default the 
> first time they boot into a newly installed system.
> b) Professional users want everything muted the first time.
> 
> My personal preference is ALL SOUND MUTED in ALL cases.
> I figure that if a user does not have sound, the first thing they will 
> do is go to the volume control and turn it up!

Thing is, that non-technical people usually have a very hard time to
grok a mixer crowded with all kinds of controls where most of them
actually don't have any impact on sound at all.

In PA I try to minimize the number of sliders: just one per output
device. PA is clearly not for pro-audio people, so this is the
absolute right thing to do. But for this I need to be able to
rely on that all the mixer controls of the soundcard are initialized
in a "sane" way, so that the single mixer control I have actually
makes sense.

> Most consumer distos do not agree with me and want the volume turned up 
> already by default.

Yes. in an ideal world people wouldn't have to think about the volume
control in there computers at all, since their speakers either come
with a hw vol control anyway, are a hifi stereo with hw vol controls
or are inside a laptop with hw volume controls.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
