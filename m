From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Lots of BUG alerts with latest CVS and Audigy2
Date: Thu, 10 Mar 2005 19:16:21 -0500
Message-ID: <1110500181.15895.1.camel@mindpipe>
References: <20050311001056.21034.qmail@web52903.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050311001056.21034.qmail@web52903.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Rankin <rankincj@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-03-11 at 00:10 +0000, Chris Rankin wrote:
> Hi,
> 
> I don't know what this means, but it's a very persistent error!
> 
> Mar  9 23:06:22 volcano kernel: BUG (or not enough voices), number 1, next free 30!
> Mar  9 23:06:53 volcano last message repeated 556 times
> Mar  9 23:07:07 volcano last message repeated 268 times
> 
> Mar 11 00:06:23 volcano kernel: BUG (or not enough voices), number 1, next free 38!
> Mar 11 00:06:54 volcano last message repeated 546 times
> 
> I am using the latest alsa CVS, with Linux 2.6.11-SMP (dual P4 with HT). My soundcard is an Audigy
> 2.

Ugh.  That is a bug in the voice allocator.  It was thought to be fixed.

Can you provide a method to reproduce the problem?

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
