From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Re: 1.0.13rc3: relocation error: mocp:
	symbol	snd_pcm_hw_params_get_channels_min ..
Date: Thu, 28 Sep 2006 21:15:13 +0200
Message-ID: <20060928191513.GC2855@samweis.home.lxtec.de>
References: <20060926201319.GA3067@samweis.home.lxtec.de>
	<s5h1wpwpa49.wl%tiwai@suse.de>
	<20060928180207.GA2855@samweis.home.lxtec.de>
	<200609281416.41419.vapier@gentoo.org>
	<20060928184436.GB2855@samweis.home.lxtec.de>
	<1159469533.7086.51.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1159469533.7086.51.camel@mindpipe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: pkg-alsa-devel <pkg-alsa-devel@lists.alioth.debian.org>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 28 Sep 2006 the mental interface of
Lee Revell told:

> On Thu, 2006-09-28 at 20:44 +0200, Elimar Riesebieter wrote:
> > --enable--shared=no \
> 
> Was this typo pasted from your actual build script?

Why is that a typo? This I've done as adviced from Jaroslav:

"If you would like to use the static ALSA library, you need to use
these options for the configure script:

        ./configure --enable-shared=no --enable-static=yes

Unfortunately, due to bug in the libtool script, the shared and
static library cannot be built together."

Elimar


-- 
  On the keyboard of life you have always
  to keep a finger at the escape key;-)

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
