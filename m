From: Ryan Underwood <nemesis-lists@icequake.net>
Subject: Re: cs4248 / thinkpad 755 / 755c , patch suggestions
Date: Thu, 3 Jul 2003 11:38:32 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030703163832.GC24005@dbz.icequake.net>
References: <20030702202955.GW24005@dbz.icequake.net> <s5hwuezequq.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hwuezequq.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hi Takashi,

On Thu, Jul 03, 2003 at 02:29:01PM +0200, Takashi Iwai wrote:
> At Wed, 2 Jul 2003 15:29:55 -0500,
> Ryan Underwood wrote:
> > 
> > 1) What is ALSA's policy on module options?  For example, would it be
> > okay to add an option like "thinkpad" to the ad1848 module, so that
> > inserting it with "thinkpad=1" would cause the necessary ports to be
> > prodded?
> 
> this looks like a feasible solution.

Ok, I will post a patch soon.

> > 2) Since the chip's power mode can be controlled through a write to that
> > port (bit 2 on, cs4248 power on; bit 2 off, cs4248 power off), would it
> > be a good idea to add the _suspend, _resume, and _set_power_state
> > functions within a #ifdef CONFIG_PM block, like in other drivers?
> 
> yep.  we haven't done that just becase of lack of hardware.
> if you can write and test it, it would be greatly appreciated.

Fine, it will be modelled after the other code for ISA chips like
OPL3-SA2.  The code will only be called if a thinkpad is being used, because
only the thinkpad has the hardware to disable and enable the chip.

I don't even know for sure if it is a power management feature since there
is no documentation for it, but I'm having trouble coming up with
another explanation for what i've found out about cs4248 in the thinkpad.


For power management code, I had another idea which is probably stupid.
What about a generic ALSA "aggressive power management" setting for
laptops.  The difference would be that instead of paying attention to
the system's power management state, the sound chips would be turned off
(suspend) when the open count reaches zero as well as immediately after
initialization, and only resumed when a device open is attempted.  It
would introduce some delay on device opens, but it would ensure that the
sound chips are only enabled when they are actually being in use.

Of course, there are probably complications I didn't think of, but it is
a feature I would like to have to maximize battery life.

Thanks!

-- 
Ryan Underwood, <nemesis at icequake.net>, icq=10317253


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
