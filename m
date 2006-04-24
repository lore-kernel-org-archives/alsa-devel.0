From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Subject: Re: Remove xrun debugging?
Date: Mon, 24 Apr 2006 11:42:04 +0100
Message-ID: <20060424104203.GA11683@palantir8>
References: <1145767405.21377.20.camel@mindpipe> <20060423174534.1dd2cb44@mango.fruits> <1145809115.21377.34.camel@mindpipe> <20060423210329.3725f5c5@mango.fruits> <Pine.LNX.4.61.0604241042280.10174@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0604241042280.10174@tm8103.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 24, 2006 at 10:55:02AM +0200, Jaroslav Kysela wrote:
> On Sun, 23 Apr 2006, Florian Schmidt wrote:
> 
> > On Sun, 23 Apr 2006 12:18:34 -0400
> > Lee Revell <rlrevell@joe-job.com> wrote:
> > 
> > > > It still might prove useful for non -rt users. I don't know exactly how
> > > > useful, but maybe it's really a documentation bug. Put a note in the
> > > > helpfile that much finer debugging can be done with the -rt kernels.
> > > 
> > > I don't think it's useful at all - any bugs that it could have found
> > > were fixed long ago.  I have not seen useful output from it in a year
> > > and a half.
> > 
> > That doesn't mean it won't prove useful in the future. But i don't know.
> > Takashi? Jaroslav?
> 
> I think that we can make the code optional for now. Patch for review is 
> attached.

I think this is a good approach. I do expect there are still bugs out there
in non-x86 land, and this code would be usefull for that.

Jaroslav, a small typo in your additions:
-	  It is no usually required, but if you have trouble with
+	  It is usually not required, but if you have trouble with

Thanks,
Martin


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
