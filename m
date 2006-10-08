From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Issue with Intel HDA Sound card 82801G
	(laptop	Medion)
Date: Sun, 08 Oct 2006 10:15:44 -0700
Message-ID: <1160327744.17297.108.camel@razman>
References: <1160227460.4527aa8501646@imp1-g19.free.fr>
	<1160242659.17297.64.camel@razman> <20061008110304.GA30604@trinnov.com>
	<1160323211.17615.100.camel@mindpipe>
	<1160323875.17297.94.camel@razman>
	<1160326355.17615.109.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1160326355.17615.109.camel@mindpipe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Realtek takes a snapshot of the stable branches, then temporarily forks
for a while.  I'd expect to see a submission from them before 1.0.14
(but why wait).  Their latest package is
realtek-linux-audiopack-4.05b.tar.bz2, which has alsa-driver-1.0.12
(plus their changes), lib & utils are version 1.0.9.  There are
differences between their code and 1.0.13, and other users have reported
that the Realtek version works where 1.0.13 doesn't.

Remy's tarball that he sent is alsa-driver-1.0.9b_25a.tar.bz2, which I
assumed was based on 1.0.9b, but I'm now finding patches I submitted
prior to 1.0.11 release.  I'm slowly walking up the hg tree to try to
pinpoint the snapshot, otherwise there will be some ugly patch changes
(and I hate editing patch files directly - never could get the line
numbers to match).  The other thing they did was remove all other codec
references (patch_sigmatel.c, patch_analog.c, etc) from all of the hda
directory and hda support files (hda_codec.c, etc).  Right now I'm
focusing on the patch_realtek.c to hopefully get a patch against 1.0.13.
I'll then look over the other changes if Remy and albox still aren't
working.

It would be nice if vendors would upload their changes to the
mainstream.  Maybe I'm hoping for too much.

Tobin

On Sun, 2006-10-08 at 12:52 -0400, Lee Revell wrote:
> On Sun, 2006-10-08 at 09:11 -0700, Tobin Davis wrote:
> > 
> > > AFAIK all the Realtek changes (which they never bothered to submit) have
> > > been merged already.
> > > 
> > Not true.  I have the latest Realtek drivers as well.  Major changes
> > were added to 1.0.12 and aren't in HG yet.  I'm also looking at that
> > this week.
> > 
> 
> Do you mean 1.0.12 of the Realtek drivers?  IOW, is Realtek still
> maintaining their forked ALSA as recently as ALSA 1.0.12?
> 
> Lee
> 
-- 
Tobin Davis <tdavis@dsl-only.net>


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
