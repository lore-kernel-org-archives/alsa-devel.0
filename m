From: Jos Hulzink <josh@stack.nl>
Subject: Re: XMMS ALSA extension problems
Date: Fri, 15 Feb 2002 15:42:38 +0100
Message-ID: <20020215144214.ZNFQ19280.amsfep15-int.chello.nl@there>
References: <Pine.LNX.4.31.0202151311120.608-200000@pnote.perex-int.cz> <20020215142830.ZLJO1211.amsfep11-int.chello.nl@there> <20020215143456.GF13853@jesus>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Received: from amsfep15-int.chello.nl (amsfep15-int.chello.nl [213.46.243.27])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA30330
	for <alsa-devel@alsa-project.org>; Fri, 15 Feb 2002 15:42:46 +0100
In-Reply-To: <20020215143456.GF13853@jesus>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Andy Wingo <wingo@pobox.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Friday 15 February 2002 15:34, Andy Wingo wrote:
> On Fri, 15 Feb 2002, Jos Hulzink wrote:
> > Hi,
> >
> > The xmms ALSA extension doesn't work. It returns errors in the ALSA lib:
> >
> > ALSA lib dlmisc.c:97:(snd_dlsym_verify) unable to verify version for
> > symbol snd_config_hook_load
> > ALSA lib conf.c:2285:(snd_config_hooks_call) symbol snd_config_hook_load
> > is not defined inside (null)
> > ALSA lib conf.c:2671:(snd_config_update) hooks failed, removing
> > configuration xmms: pcm_params.c:2084: snd_pcm_hw_refine: Assertion `pcm
> > && params' failed. Aborted
> >
> > Can anybody tell if this is a problem in the ALSA lib, or is it the XMMS
> > plugin that causes this problem ?
>
> both really. as i understand it alsa-lib uses dlopen(3) to resolve some
> of its internal symbols. these are not properly resolved if the xmms
> plugin isn't loaded RTLD_GLOBAL. you need to get xmms to open the alsa
> plugin RTLD_GLOBAL for it to work.

On the XMMS ALSA plugin site, it is stated that this only holds for XMMS v 
1.2.5. I'll try if this works, and contact the author about it, if it works.

Jos


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
