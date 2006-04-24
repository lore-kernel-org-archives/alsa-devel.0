From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: ALSA regression: oops on shutdown
Date: Sun, 23 Apr 2006 22:39:19 -0400
Message-ID: <1145846360.31507.50.camel__44547.6924222477$1145846419$gmane$org@mindpipe>
References: <20060423235730.GA7934@mipter.zuzino.mipt.ru>
	 <20060423185721.39ff4207.akpm@osdl.org>
	 <b6fcc0a0604231937h6f2754f9k68ec76dc19c7ddb9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id BDF9117E
	for <alsa-devel@alsa-project.org>; Mon, 24 Apr 2006 04:39:22 +0200 (MEST)
In-Reply-To: <b6fcc0a0604231937h6f2754f9k68ec76dc19c7ddb9@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, perex@suse.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2006-04-23 at 19:37 -0700, Alexey Dobriyan wrote:
> On 4/23/06, Andrew Morton <akpm@osdl.org> wrote:
> > Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > >
> > > ALSA oops I reported against 2.6.16-rc1-mm4 [1] sneaked into mainline
> > >  after release.
> >
> > One wonders why the ALSA developers merged up which was known to cause
> > oopses.
> 
> To be fair, I bisected it only to git-alsa.patch back then and only
> now found enough time, so
> blame me.

Do you have procfs disabled?  Full config is needed to debug this more.

Lee



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
