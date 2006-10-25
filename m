From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: snd_hda_intel with software suspend
Date: Tue, 24 Oct 2006 20:31:13 -0400
Message-ID: <1161736274.3982.219.camel@mindpipe>
References: <20061024230225.GB10156@gelma.net>
	<1161731425.3982.195.camel@mindpipe>
	<20061025000039.GA17447@li14-150.members.linode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061025000039.GA17447@li14-150.members.linode.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Andrea Gelmini <gelma_mailinglist@gelma.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-10-25 at 00:00 +0000, Andrea Gelmini wrote:
> On Tue, Oct 24, 2006 at 07:10:24PM -0400, Lee Revell wrote:
> > Are you using the latest ALSA and kernel versions?  I think that driver
> Linux jnb 2.6.19-rc2-git7 #2 SMP Mon Oct 23 14:06:02 CEST 2006 i686 GNU/Linux
> 
> > should support suspend.  I see you use suspend2, does it work with
> > regular in-kernel suspend?
> with vanilla kernel I've got same problem.
> 

Can you suspend if you kill all processes using the sound card but do
not remove the module?

Lee


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
