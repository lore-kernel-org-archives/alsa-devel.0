From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [ALSA - lib 0000396]: /dev/mixer problem with
	alsa-lib 1.0.5
Date: Fri, 24 Sep 2004 15:20:12 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1096053611.10831.12.camel@krustophenia.net>
References: <20040924113645.54CC1101DE@server.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 3E1611CD
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 21:20:14 +0200 (MEST)
In-Reply-To: <20040924113645.54CC1101DE@server.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: bugtrack@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2004-09-24 at 07:36, bugtrack@alsa-project.org wrote:
> Description: 
> When I try to play a movie in Mplayer (tried with version 1.0pre5 and
> 1.0pre4) i receive this output:
> ALSA lib control.c:654:(snd_ctl_open_noupdate) Invalid CTL /dev/mixer
> alsa-control: mixer attach /dev/mixer error: No such file or directory

These mplayer issues are getting to be a FAQ.  If anyone else reports
mplayer issues, they need to use Mplayer CVS.  ALSA support is just
plain broken in all released versions.  If the user cannot upgrade the
only workaround is to use the OSS emulation.

Lee 



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
