From: "Bill Merrill" <bmerrill@cert.ucr.edu>
Subject: BrookTree
Date: Thu, 25 Apr 2002 01:05:29 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <003801c1ec2f$f762a620$0501a8c0@bill>
References: <Pine.LNX.4.44.0204241639410.10208-100000@volamar.theswamp.priv>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

How's everyone doing? Another student and I are planning on implementing
some new sound-card driver support under Linux.  We both possess an ATI TV
Wonder, so we were interested in implementing driver support for the
BrookTree bt878 chipset.  We have OS experience, but have not had experience
implementing sound drivers.

If anyone has some good documentation that could provide some help in
getting started, we'd greatly appreciate it.  The online documentation
hasn't given us much to go with, so we're open for any info someone is
willing to give is.

Thanks alot for reading

- Bill Merrill & Scott Paffrat

----- Original Message -----
From: "Tom Prado" <tprado@charter.net>
To: <alsa-devel@lists.sourceforge.net>
Sent: Wednesday, April 24, 2002 1:47 PM
Subject: Re: [Alsa-devel] [PATCH] configure prob with MDK82 kernel


> Thanks!  I try to run the release versions of the kernel so third party
> apps (like vmware for instance) will be sure to work.  I've
> attached the patch inline this time.  It's only one line to be added to
> configure.in.  alsa 0.5.12 had this in it, it's gone from 0.9.0rc1.
>
> --- alsa-driver-0.9.0rc1/configure.in Wed Apr 24 11:29:55 2002
> +++ alsa-driver-0.9.0rc1.tom/configure.in Wed Apr 24 14:16:31 2002
> @@ -82,6 +82,7 @@ EOF
>    exit 1
>  fi
>  AC_CACHE_VAL(kaversion,
> +CFLAGS="$CFLAGS -I$CONFIG_SND_KERNELDIR/include"
>  [AC_TRY_RUN([
>  #include <stdio.h>
>  #include <ctype.h>
>
> On Wed, 24 Apr 2002, Thierry Vignaud wrote:
>
> > Tom Prado <tprado@charter.net> writes:
> >
> > > I had a problem running configure against the Linux Mandrake 8.2 UP
> > > kernel.  It would fail when trying to determine the kernel version.
> > > This patch for rc1 adds the needed includes so that linux/rhconfig.h
> > > can be found when configure checks for the kernel version.
> >
> > use a 2.4.18-10mdk kernel and above: we've updated alsa from 0.5 upto
> > 0.9 in 10mdk.
> > note that this is a cooker kernel, not a mdk8.2 release kernel.
> >
>
> --
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
