From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: What is /dev/snd/hwC0D0 used for ?
Date: Thu, 30 Mar 2006 21:47:10 -0500
Message-ID: <1143773231.22771.15.camel@mindpipe>
References: <442C2CCE.5070207@kenati.com>
	 <1143754662.22530.9.camel@mindpipe>
	 <1143769524.7539.54.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1143769524.7539.54.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: paul@linuxaudiosystems.com
Cc: Carlos Munoz <carlos@kenati.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-03-30 at 20:45 -0500, Paul Davis wrote:
> On Thu, 2006-03-30 at 16:37 -0500, Lee Revell wrote:
> > > Is there a document explaining what all the devices are used for ? I 
> > > searched but didn't find anything.
> > > 
> > 
> > No because these interfaces are intended to be private to alsa-lib.  The
> > source code is authoritative.
> 
> is this confirmed policy?
> 

Nope, just my understanding of the situation.  Corrections are welcome.

> what happens about support for devices that have classes of control
> that do not fit into the existing ALSA schema and have traditionally
> been handled via device-specific ioctl's on /dev/snd/hwFOO ?
> 

Good question.  I know the upstream kernel policy is "no new ioctls,
period"...

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
