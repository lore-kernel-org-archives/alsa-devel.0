From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Debian Bug#410163: alsa-base: Recording with
	Intel	82801FB/FBM/FR/FW/FRW (ICH6 Family) needs additional
	module	parameter
Date: Fri, 16 Feb 2007 14:44:34 +0100
Message-ID: <20070216134434.GC3162@aragorn.home.lxtec.de>
References: <20070208094834.3995.33509.reportbug@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20070208094834.3995.33509.reportbug@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: 410163-submitter@bugs.debian.org, 410163@bugs.debian.org
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

forwarded 410163 alsa-devel@lists.sourceforge.net

thanks

On Thu, 08 Feb 2007 the mental interface of
Fabian Fagerholm told:

> Package: alsa-base
> Version: 1.0.13-3
> Severity: normal
> 
> The audio device described by lspci below needs the following in
> /etc/modprobe.d/alsa-base:
> 
> options snd-hda-intel model=ref
> 
> Otherwise sound recording through the microphone jack doesn't work.

Hmm, snd-hda-intel is used by different sound cards. So I am not
sure wether all these need that option? If yes, it would be
hardcoded, though.

I don't have an ICH chip available handy, so maybe we need some
input from alsa-devel?

Elimar

-- 
  Numeric stability is probably not all that 
  important when you're guessing;-)

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
