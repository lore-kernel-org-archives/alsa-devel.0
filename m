From: Russell King <rmk+alsa@arm.linux.org.uk>
Subject: Re: Re: [linux-audio-dev] snd-hdsp oddities
Date: Fri, 2 Jul 2004 08:32:07 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040702083207.A16346@flint.arm.linux.org.uk>
References: <20040702002208.KXUI17933.smtp2.fuse.net@smtp.fuse.net> <200407020216.i622GdaC002355@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200407020216.i622GdaC002355@localhost.localdomain>; from paul@linuxaudiosystems.com on Thu, Jul 01, 2004 at 10:16:39PM -0400
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: The Linux Audio Developers' Mailing List <linux-audio-dev@music.columbia.edu>, alsa-devel@lists.sourceforge.net, ico@fuse.net
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 01, 2004 at 10:16:39PM -0400, Paul Davis wrote:
> >I am using the latest 2.6.7 kernel (tried also 2.6.5) but with hdsp I cannot s
> >elect anything lower than 1024x2 buffer settings in jackd without having massi
> >ve xruns.
> 
> Give up on 2.6 for now. If you can't give up on it, then at least run
> all (audio) apps with the environment variable LD_ASSUME_KERNEL set to
> 2.4.19. 

That is a bad attitude IMHO - if everyone follows that example, it
means that 2.6 will _never_ progress.  We, as kernel, developers rely
completely on users running the thing to find any problems, so these
types of reports are invaluable.

Ico - isn't this the same device which we recently had problems with
on PCMCIA?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
