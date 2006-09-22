From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: [PATCH 1/5] ASoC: Build files
Date: Fri, 22 Sep 2006 17:56:11 +0100
Message-ID: <1158944171.18071.87.camel@localhost.localdomain>
References: <1158326252.22950.64.camel@localhost.localdomain>
	<s5hpsdshwuf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hpsdshwuf.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-09-19 at 14:20 +0200, Takashi Iwai wrote:
> At Fri, 15 Sep 2006 14:17:32 +0100,
> Liam Girdwood wrote:
> > 
> > Index: alsa-kernel/soc/Kconfig
> > ===================================================================
> > --- /dev/null
> > +++ alsa-kernel/soc/Kconfig
> > @@ -0,0 +1,18 @@
> > +#
> > +# SoC audio configuration
> > +#
> > +
> > +menu "SoC audio support"
> > +
> > +config SND_SOC
> > +	tristate "SoC audio support"
> 
> Don't you need dependencies?
> 

I've set the deps (for each platform) in the child (asoc) Kconfig. 

Liam


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
