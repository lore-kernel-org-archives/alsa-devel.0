From: "Alexey Dobriyan" <adobriyan@gmail.com>
Subject: Re: ALSA regression: oops on shutdown
Date: Sun, 23 Apr 2006 19:37:08 -0700
Message-ID: <b6fcc0a0604231937h6f2754f9k68ec76dc19c7ddb9@mail.gmail.com>
References: <20060423235730.GA7934@mipter.zuzino.mipt.ru>
	 <20060423185721.39ff4207.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from uproxy.gmail.com (uproxy.gmail.com [66.249.92.170])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9722617E
	for <alsa-devel@alsa-project.org>; Mon, 24 Apr 2006 04:37:09 +0200 (MEST)
Received: by uproxy.gmail.com with SMTP id q2so595512uge
        for <alsa-devel@alsa-project.org>; Sun, 23 Apr 2006 19:37:08 -0700 (PDT)
In-Reply-To: <20060423185721.39ff4207.akpm@osdl.org>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, perex@suse.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 4/23/06, Andrew Morton <akpm@osdl.org> wrote:
> Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > ALSA oops I reported against 2.6.16-rc1-mm4 [1] sneaked into mainline
> >  after release.
>
> One wonders why the ALSA developers merged up which was known to cause
> oopses.

To be fair, I bisected it only to git-alsa.patch back then and only
now found enough time, so
blame me.


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
