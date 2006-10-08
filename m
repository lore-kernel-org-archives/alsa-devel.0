From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Issue with Intel HDA Sound card
	82801G	(laptop	Medion)
Date: Sun, 08 Oct 2006 13:24:05 -0700
Message-ID: <1160339045.17297.118.camel@razman>
References: <1160227460.4527aa8501646@imp1-g19.free.fr>
	<1160242659.17297.64.camel@razman> <20061008110304.GA30604@trinnov.com>
	<1160323211.17615.100.camel@mindpipe>
	<1160323875.17297.94.camel@razman>
	<1160326355.17615.109.camel@mindpipe>
	<1160327744.17297.108.camel@razman>
	<1160336468.17615.118.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1160336468.17615.118.camel@mindpipe>
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



On Sun, 2006-10-08 at 15:41 -0400, Lee Revell wrote:
> On Sun, 2006-10-08 at 10:15 -0700, Tobin Davis wrote:
> > Realtek takes a snapshot of the stable branches, then temporarily forks
> > for a while.  I'd expect to see a submission from them before 1.0.14
> > (but why wait).  Their latest package is
> > realtek-linux-audiopack-4.05b.tar.bz2, which has alsa-driver-1.0.12
> > (plus their changes), lib & utils are version 1.0.9.  There are
> > differences between their code and 1.0.13, and other users have reported
> > that the Realtek version works where 1.0.13 doesn't.
> 
> I don't think Realtek ever submitted anything.  Users figured out that
> they had forked ALSA and extracted the useful changes themselves.

Ok, Guess I'm it then.

At any rate, I've been studying the changes that Medion made, and I
think I have a better solution to merging.  It appears that they pulled
patches that suited them, leaving others out (figures).  Some of their
patches are already in the mainstream.  The easiest way to get this
working is to create new configurations under ALC883 (I'm thinking
ALC883_TEST and ALC883_MEDION).  I should have something tonight or
tomorrow for testing.

-- 
Tobin Davis <tdavis@dsl-only.net>


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
