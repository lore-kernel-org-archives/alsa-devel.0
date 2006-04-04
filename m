From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: Patch for AICA sound support on SEGA Dreamcast
Date: Tue, 04 Apr 2006 17:23:58 -0400
Message-ID: <1144185840.2887.98.camel@mindpipe>
References: <1144075522.11511.20.camel@localhost.localdomain>
	 <443162B4.60500@kenati.com> <s5hzmj28q8k.wl%tiwai@suse.de>
	 <200604040116.13732.s0348365@sms.ed.ac.uk>
	 <1144110986.22082.4.camel@mindpipe>
	 <1144134722.9270.4.camel@localhost.localdomain>
	 <1144159056.22082.38.camel@mindpipe>
	 <1144185444.9472.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1144185444.9472.17.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-04-04 at 22:17 +0100, Adrian McMenamin wrote:
> On Tue, 2006-04-04 at 09:57 -0400, Lee Revell wrote:
> > On Tue, 2006-04-04 at 08:12 +0100, Adrian McMenamin wrote:
> > > I wrote the code, however, against the 2.6.15 kernel, not an
> > > unreasonable proposition given that it was the current kernel until
> > > about 2 weeks ago.
> > > 
> > 
> > The ALSA version in the kernel lags behind the current ALSA version by a
> > month or two - ALSA driver development should be done against the ALSA
> > CVS tree.
> > 
> > Lee
> 
> Can I drop the alsa-driver sources over any particular part of the
> kernel tree? As this is all a cross-compiled embedded-like environment I
> don't have a lot of flexibility
> 
> 

It's probably not that simple, ALSA does a lot of patch-o-magic to make
it backwards compatible with any kernel... I think the best solution is
to make the ALSA build process work in such environments.  What happens
if you try it?

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
