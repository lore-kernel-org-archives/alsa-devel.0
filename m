From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [2.6.17-rc1] ALSA oops with multiple OSS clients
Date: Wed, 05 Apr 2006 13:44:32 -0400
Message-ID: <1144259073.10626.2.camel__49674.6770958$1144259154$gmane$org@mindpipe>
References: <20060405173002.GA5306@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 64FBF176
	for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2006 19:44:36 +0200 (MEST)
In-Reply-To: <20060405173002.GA5306@dreamland.darkstar.lan>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Luca <kronos.it@gmail.com>
Cc: linux-kernel@vger.kernel.org, perex@suse.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-04-05 at 19:30 +0200, Luca wrote:
> Hello,
> I've a reproducible OOPS when starting multiple OSS clients.
> To reproduce I do this:
> mpg123 song.mp3
> mpg123 song.mp3 (another time)
> 
> At this point the song restart from the beginning (i.e. I think that 
> the second mpg123 takes over the device). When the second instance
> terminates the song I get the following OOPS:

Known bug, please try the patch:

http://bugzilla.kernel.org/show_bug.cgi?id=6329

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
