From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Issue with Intel HDA Sound card 82801G
	(laptop	Medion)
Date: Sun, 08 Oct 2006 12:00:10 -0400
Message-ID: <1160323211.17615.100.camel@mindpipe>
References: <1160227460.4527aa8501646@imp1-g19.free.fr>
	<1160242659.17297.64.camel@razman> <20061008110304.GA30604@trinnov.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061008110304.GA30604@trinnov.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Remy Bruno <remy.bruno@trinnov.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 2006-10-08 at 13:03 +0200, Remy Bruno wrote:
> I have the same sound card (I posted a mail a couple of days ago) and
> I had
> indeed the same problem, but it is now partly solved. I found on my
> Windows XP
> partition a directory with various GPL code. Among it, I found a file
> called
> "alsa-driver-1.0.9b_25a.tar.bz2". I tried to include its hda part
> (alsa-kernel/pci/hda subdir) into the 1.0.13 driver part (Yes, I know,
> it's
> awful!...), and after some minor changes, I got it working, with
> sound! 

Please post the changes in the form of a patch against ALSA 1.0.13.

AFAIK all the Realtek changes (which they never bothered to submit) have
been merged already.

Lee


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
