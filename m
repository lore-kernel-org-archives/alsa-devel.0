From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Getting actual sample rate
Date: Tue, 10 Jun 2003 20:45:20 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306102041070.1320-100000@pnote.perex-int.cz>
References: <3EE61792.2070702@iis.fhg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3EE61792.2070702@iis.fhg.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Eric Allamanche <alm@iis.fhg.de>
Cc: Martin Langer <martin-langer@gmx.de>, Paul Davis <paul@linuxaudiosystems.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 10 Jun 2003, Eric Allamanche wrote:

> >>the ALSA hardware parameter model doesn't include the notion of an
> >>"external rate". 
> 
> Is this is a design flaw? How to tell the input frequency? Need some 
> additionnal hardware?

No. It is not. As Paul mentioned, we have universal control for this 
purpose. It can notify the application about rate change independently 
from the PCM layer and multiple applications might react to this state
change.

Also, the official behaviour for external rate is: compare the external
rate by rate given by application; when the driver handles new samples and
and stream trigger time; if rate does not match, fail with error. This
behaviour assures that application does not get samples with wrong rate.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
