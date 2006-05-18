From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: strace and ALSA ioctls
Date: Thu, 18 May 2006 12:12:06 -0400
Message-ID: <1147968727.12531.69.camel@mindpipe>
References: <1147966909.12531.65.camel@mindpipe>
	 <s5h4pzn2v2r.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4pzn2v2r.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-05-18 at 17:47 +0200, Takashi Iwai wrote:
> At Thu, 18 May 2006 11:41:48 -0400,
> Lee Revell wrote:
> > 
> > I have never seen strace correctly identify a single ALSA ioctl.  This
> > makes debugging a serious PITA.  Is it fixable?
> 
> Quite unlikely.  Some ioctl commands are indeed identical with these
> USBDEVFS_*.  This happened since we didn't care about the collision
> and found it too late.
> 
> In the kernel side this is no problem because the ioctl cmd is bound
> to each driver's ioctl op.  But, from user-space, there is no way to
> distinguish properly.
> 

But for some ioctls it says:

ioctl(1, SNDCTL_TMR_TIMEBASE or TCGETS, {B38400 opost isig icanon
echo ...}) = 0
ioctl(1, SNDCTL_TMR_TIMEBASE or TCGETS, {B38400 opost isig icanon
echo ...}) = 0

So it seems that strace is aware of some of the collisions but not
others?

Lee



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
