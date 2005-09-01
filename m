From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: [Alsa-user] CS4232 Sound & Fedora Core3
Date: Thu, 1 Sep 2005 20:25:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0509012023410.12210@tm8103.perex-int.cz>
References: <Pine.HPX.4.33n.0508081559130.1089-100000@studcom.urz.uni-halle.de>
  <42F8D075.3030307@optimus.co.uk> <43141A58.5070001@rambler.ru>
 <200508302148.20909.cave.dnb@tiscali.fr>  <4316D8B7.1030601@rambler.ru>
 <1125598881.4464.19.camel@mindpipe>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1125598881.4464.19.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Yury Aliaev <mutab0r@rambler.ru>, alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 1 Sep 2005, Lee Revell wrote:

> On Thu, 2005-09-01 at 14:32 +0400, Yury Aliaev wrote:
> > I read some description of IBM TP600E, it says that CS4232 chip is used 
> > for the compatibility with old MS-DOS games, and CS4610 -- for sound in 
> > modern apps (but not Linux :( )
> 
> OK, so let's write a driver.  Where's the CS4610 datasheet?

We have already driver snd-cs46xx, but it does only support AC97 codec as 
mixer and AD/DA chip. The CS46xx->CS423x connection is unsupported 
(because it is rare and probably no developer has this hardware and
we don't have the documented DSP code which supports this connection).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
