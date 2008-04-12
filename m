From: John Rigg <aldev@sound-man.co.uk>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Sat, 12 Apr 2008 23:43:32 +0100
Message-ID: <20080412224332.GA2967@localhost>
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
Received: from mail3.uklinux.net (mail3.uklinux.net [80.84.72.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F9D32448D
	for <alsa-devel@alsa-project.org>;
	Sun, 13 Apr 2008 00:34:10 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 12, 2008 at 10:55:35PM +0100, James Courtier-Dutton wrote:
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
> My personal preference is ALL SOUND MUTED in ALL cases.

Mine too.

> I figure that if a user does not have sound, the first thing they will 
> do is go to the volume control and turn it up!
> I do believe that a general user should only have to touch one "Master" 
> volume control to do this "turn it up" step.
> 
> Most consumer distos do not agree with me and want the volume turned up 
> already by default.
> The problem is deciding on a generally good level for these distros.

Fair point. Actually there is an easy workaround for those of us who
prefer everything muted every time: remove or disable the init.d 
script.

John
