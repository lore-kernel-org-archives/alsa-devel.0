From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Multi ice1712 .asoundrc problem
Date: Sun, 13 Nov 2005 18:08:12 -0500
Message-ID: <1131923292.27215.1.camel@mindpipe>
References: <E1EbIYV-00019A-4u@localhost.localdomain>
	 <20051113223105.GA4822@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20051113223105.GA4822@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: John Rigg <ad@sound-man.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 2005-11-13 at 22:31 +0000, John Rigg wrote:
> This fails with a poll time out. If I add the -C or -P option to start
> in capture- or playback-only mode, it starts and runs. 
> Setup is 2.6.14-rt6 x86_64 SMP kernel (alsa-driver-1.0.10rc1),
> alsa-lib-1.0-10rc2, jack-0.100.7 + MMAP_COMPLEX patch, 
> Debian unstable amd64.

What happens if you supply both the -P and -C options?  That will give
you full duplex without the need to use the asym plugin.

Lee



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
