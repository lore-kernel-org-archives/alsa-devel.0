From: Martin Langer <martin-langer@gmx.de>
Subject: Re: Getting actual sample rate
Date: Tue, 10 Jun 2003 21:10:57 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030610191057.GB501@tuba.home>
References: <3EE61792.2070702@iis.fhg.de> <20030610175122.25712gmx1@mx019.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20030610175122.25712gmx1@mx019.gmx.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Eric Allamanche <alm@iis.fhg.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 10, 2003 at 01:56:55PM -0400, Paul Davis wrote:
> >Is this is a design flaw? How to tell the input frequency? Need some 
> >additionnal hardware?
> 
> the ALSA h/w parameters are things set by an application (and
> perhaps later read by the same or a different application). 
> 
> what ALSA supports (and the hdsp driver in particular; the digi9652 is
> not so good here) is the notion of defining the clock source. if the
> clock source is internal, then some h/w (i think this applies to the
> digi9652) can't tell you the external rate for the ADAT signal. if the
> clock source is external, then you can't set the rate from an
> application. of course, you might want to know what it is. in which
> case, you have to read the relevant control, which is called "External
> Rate" on the hdsp series. unfortunately, an equivalent control does
> not exist for the digi9652 series, though it would be easy to write (i
> would do it if i wasn't so busy with other projects right now).
> 
> i think it would have been good for ALSA to have considered this more
> early on; as it is, only a few cards support external clocking, and
> the drivers for those cards have had to make it up as they were written.
> 

Maybe we can add some rme9652 switches to rmedigicontrol!?
But I need at first the output of "amixer contents".
.. and what is "cat /proc/asound/card0/id"? Is it "Digi9652"?

BTW: ... I'm still searching for rme96 users who can check rmedigicontrol
version 0.3.5a together with a patched rme96 driver. 
Hey rme96 crowd! Does it work? 

See http://www.langerland.de/rme32/control.html


martin


-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
