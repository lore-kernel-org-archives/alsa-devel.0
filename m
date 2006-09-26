From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: 1.0.13rc3: relocation error: mocp:
	symbol	snd_pcm_hw_params_get_channels_min ..
Date: Tue, 26 Sep 2006 17:03:29 -0400
Message-ID: <1159304610.2899.231.camel@mindpipe>
References: <20060926201319.GA3067@samweis.home.lxtec.de>
	<1159302210.2899.227.camel@mindpipe>
	<20060926204053.GB3067@samweis.home.lxtec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060926204053.GB3067@samweis.home.lxtec.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Elimar Riesebieter <riesebie@lxtec.de>
Cc: pkg-alsa-devel <pkg-alsa-devel@lists.alioth.debian.org>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-09-26 at 22:40 +0200, Elimar Riesebieter wrote:
> On Tue, 26 Sep 2006 the mental interface of
> Lee Revell told:
> 
> > On Tue, 2006-09-26 at 22:13 +0200, Elimar Riesebieter wrote:
> > > Hi all,
> > > 
> > > I am testing 1.0.13rc3 (lib/driver/utils) on PPC/2.6.18
> > > 
> > > Starting a soundapp like moc gives:
> > > 
> > > "relocation error: mocp: symbol snd_pcm_hw_params_get_channels_min,
> > > version ALSA_0.9.0rc4 not defined in file libasound.so.2 with link
> > > time reference"
> > > 
> > > Any hints?
> > > 
> > 
> > Application was compiled against a different alsa-lib version than is
> > present.
> 
> This was my idea as well, but apps compiled with versions << 1.0.12
> are running with 1.0.13rc2?

It's not guaranteed that using a wrong library version won't work.  It
may or may not.  Just use the same version.

Lee


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
