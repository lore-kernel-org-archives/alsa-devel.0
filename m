From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Audigy2 Microphone capture: alsa-driver-1.0.9rc1
	works, alsa-driver-1.0.9rc2 doesn't
Date: Thu, 31 Mar 2005 17:20:58 -0500
Message-ID: <1112307658.2509.7.camel@mindpipe>
References: <20050330230127.47575.qmail@web52903.mail.yahoo.com>
	 <424C6145.20703@pobox.sk>  <1112304520.2509.5.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1112304520.2509.5.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Zubaj <pzad@pobox.sk>
Cc: Chris Rankin <rankincj@yahoo.com>, James Courtier-Dutton <James@superbug.co.uk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-03-31 at 16:28 -0500, Lee Revell wrote:
> On Thu, 2005-03-31 at 22:44 +0200, Peter Zubaj wrote:
> > Problem is, that your card was not detected correctly and ac97 mixer 
> > initialization is was not run.
> > Looks like card identification broke lot of cards and things.
> 
> Does this patch fix the problem?
> 

Never mind, Peter's patch is obviously more complete.

Lee



-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
