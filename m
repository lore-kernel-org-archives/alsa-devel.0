From: jfm3 <jfm3@ouroboros-complex.org>
Subject: Re: [PD] PD 0.36-0 and Jack 0.61.0 doesn't work?
Date: 17 Mar 2003 22:42:46 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1047958977.1859.84.camel@localhost.localdomain>
References: <Pine.LNX.4.31.0303171457270.22119-100000@xdv.org>
	<200303171908.26855.lt@westnet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200303171908.26855.lt@westnet.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: PD List <pd-list@iem.kug.ac.at>
Cc: jackit-devel@sourceforge.net, alsa-devel@sourceforge.net
List-Id: alsa-devel@alsa-project.org

Nothing for nothing, but I'm having the same problems. I just attributed
it to the fact that I was on a Crusoe processor. I'm using alsa and jack
from Planet CCRMA. The sound card is ALi 5451. All jack apps have the
same problem.

There was a hint from Paul Davis to the ALSA list rthat this might have
something to do with ALSA. I'm too busy with other projects to figure
out how to debug device drivers right now, but since I don't need jack
until this summer I'm to let it be.

On Mon, 2003-03-17 at 19:08, Larry Troxler wrote:
> On Monday 17 March 2003 08:59, guenter geiger wrote:
> > Hi Larr
> >
> > thanks for reporting the problem. Could it be that pd gets stuck
> > because it loads all the libraries ?
> > I have just tested the setup and pd works with the latest
> > CVS version of jack ..
> > I am a bit at a loss at this one :(
> >
> > Guenter
> 
> Hello Guenter - I tried today's CVS of jack and have the same result.
> Which version of pd are you using? I'm using pd 0.36-0 directly from the CCRMA 
> binary RPM. (I did try last night to compile PD from CVS but it seems the 
> build is/was broken - failed at fiddle~).
> 
> Larry Troxler
> 
-- 
(jfm3  2838 BCBA 93BA 3058 ED95  A42C 37DB 66D1 B43C 9FD0)



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
