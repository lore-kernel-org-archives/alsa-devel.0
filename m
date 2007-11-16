From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: No sound on Intel DQ965GF motherboard
Date: Fri, 16 Nov 2007 14:58:48 -0500
Message-ID: <20071116195848.GD17927@thyrsus.com>
References: <20071116061042.C5E9D830734@snark.thyrsus.com>
	<1195195147.6392.15.camel@razman.gruemaster.com>
	<20071116161619.GA6292@thyrsus.com> <s5h4pfmma4t.wl%tiwai@suse.de>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from snark.thyrsus.com (static-71-162-243-5.phlapa.fios.verizon.net
	[71.162.243.5]) by alsa0.perex.cz (Postfix) with ESMTP id 638EC2454E
	for <alsa-devel@alsa-project.org>; Fri, 16 Nov 2007 20:58:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h4pfmma4t.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Eric S. Raymond" <esr@snark.thyrsus.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de>:
> In most cases, the problem will be gone after unloading all snd*
> modules and ac97* modules once, then reload the again.  alsasound init
> script sometimes doesn't do that correctly (depending on distro).

I'll try again when the Ubuntu backports packages get updated, thanks.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
