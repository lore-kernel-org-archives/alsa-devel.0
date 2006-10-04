From: Remy Bruno <remy.bruno@trinnov.com>
Subject: Re: RME 9632
Date: Wed, 4 Oct 2006 11:41:16 +0200
Message-ID: <20061004094116.GA9390@trinnov.com>
References: <17698.30808.300932.447608@boromir.ci.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <17698.30808.300932.447608@boromir.ci.tuwien.ac.at>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

OK, I downgraded the firmware and it works now perfectly!
Thanks a lot!

So to summarize:
HDSP9632 with rev <= 151 works OK with current alsa drivers
HDSP9632 with rev >= 152 doesn't work with current alsa drivers

Regards
Remy

PS: I just received an email from RME, maybe it will allow to modify the alsa
driver to support rev >= 152, but the simplest for now is to downgrade the
firmware.

On Tuesday 03 October at 16:48, Karl Grill wrote:
> I'm not quite sure (only started working on this), but your problem
> might be a firmware incompatibility. If so, it might help to downgrade
> (using http://rme-audio.com/download/treiber_archiv/fut_win_dsp.zip ).
> Could you supply your output from lspci?
> regards
> kg
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
