From: enigma_0Z <enigma.0za@gmail.com>
Subject: Re: IRQ issue with the hda-intel module,
	2.6.19 and my mobo?
Date: Fri, 27 Oct 2006 14:55:04 -0400
Message-ID: <a6f0b350610271155q4cd20111s4f9ccd4686a7a7@mail.gmail.com>
References: <34389.86.7.220.119.1161973265.squirrel@wmbeta.mxes.net>
	<1161973651.27225.148.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1161973651.27225.148.camel@mindpipe>
Content-Disposition: inline
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
Cc: Andrew Nelless <andrew@nelless.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Actually, Andrew may be onto something.

There's a patch for hda-intel that "tdavis@dsl-only.net" has been
working on. This patch does the same thing for me with alsa 1.0.13 and
kernel 2.6.17... Of course, alsa 13 doesn't work on my system anyway.

On 10/27/06, Lee Revell <rlrevell@joe-job.com> wrote:
> On Fri, 2006-10-27 at 19:21 +0100, Andrew Nelless wrote:
> > Hi,
> >
> > I've been testing the 2.6.19 RC kernels out (I always test early new mainline kernels early)
> > and have been getting the following MCE error consistantly when I load the snd_hda_intel
> > module
> >
> > "Hardware Error
> > CPU 0 : Machine Check Exception
> > TSC 2df07369b0 4 Bank 4 b20000 00000000070f0f
> > This is not a software problem"
> >
>
> This belongs on linux-kernel - the bug cannot be in ALSA.
>
> Lee
>
>
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
