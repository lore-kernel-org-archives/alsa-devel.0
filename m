From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Patch to fix build issues on Mandriva
	2006	(2.6.12-12mdk)
Date: Sat, 21 Oct 2006 14:13:49 -0700
Message-ID: <1161465229.26400.72.camel@razman>
References: <1161460068.26400.68.camel@razman>
	<1161463377.20231.0.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1161463377.20231.0.camel@mindpipe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I suppose it could, but what's the point?  If devfs has been removed in
newer kernels, then it won't be defined, right?  Adding a kernel wrapper
would be inefficient, plus it would be harder to contain vendor kernels
that still implement devfs for compatibility.

Tobin

On Sat, 2006-10-21 at 16:42 -0400, Lee Revell wrote:
> On Sat, 2006-10-21 at 12:47 -0700, Tobin Davis wrote:
> >   
> >   static int cards_limit = 1;
> >  +#ifdef CONFIG_DEVFS_FS
> >  +static int device_mode = S_IFCHR | S_IRUGO | S_IWUGO;
> > ++static struct snd_minor *mptr;
> >  +#endif
> >    
> 
> Shouldn't this be wrapped in a version check or something?  Devfs has
> been removed from recent kernels.
> 
> Lee
> 
-- 
Tobin Davis <tdavis@dsl-only.net>


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
