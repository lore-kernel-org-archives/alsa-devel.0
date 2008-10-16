From: "Blacky (alsa-devel)" <alsa-devel@blackdog.shacknet.nu>
Subject: Re: Status of HDMI on Nvidia 10de:0774
	device	(AsusM3N-H	HDMI
Date: Thu, 16 Oct 2008 22:48:03 +1100
Message-ID: <assp.217580e936.59BA8640D0DC924897A613C8240D88390442BB@vex.jingella.net>
References: <59BA8640D0DC924897A613C8240D88390442B4@vex.jingella.net><s5h3aj096l4.wl%tiwai@suse.de><assp.0174c97161.59BA8640D0DC924897A613C8240D88390442BA@vex.jingella.net>
	<s5hy70pqbjx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jingella.dyndns.org (unknown [124.189.101.81])
	by alsa0.perex.cz (Postfix) with ESMTP id EAF5F24549
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Oct 2008 13:48:19 +0200 (CEST)
Received: from dalmatian.dnsdojo.net (localhost.localdomain [127.0.0.1])
	by jingella.dyndns.org (8.13.8/8.13.8) with ESMTP id m9GBlx5Q012864
	for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2008 22:47:59 +1100
Content-class: urn:content-classes:message
In-Reply-To: <s5hy70pqbjx.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Takashi,

Thank you for your help.

> >
> > The short of it is, 'aplay -Dhdmi' attempts to open the device
> > '/dev/snd/pcmC0D3p', which
> > doesn't exists. The reporting tools show the HDMI as being
> > /dev/snd/pcmC0D4p..
> 
> OK, it's a bug in Nvidia HDMI patch.  Fixed now on sound.git tree.
> 
> 
> You should check my sound.git tree to get the very latest version.
>     git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
> 
> The master branch is for the currently developed kernel, i.e. 2.6.28.
> The devel branch is for the previous one, 2.6.27.  For tracking the
> development, just check one of them.
> 
> The real patches are usually committed into topic branches like
> topic/hda.  These are merged into appropriate branches.
> 
> 
> Takashi

It will be the weekend before I have a chance to test it against a HDMI
receiver though.   

I'll let you know how I go.

I grabbed the sound-2.6 tree.  If I successfully build it, will it
generate a complete
kernel which I need to install and boot? or can it generate modules for
my existing
kernel?  My apologies for the dumb questions.


Regards
Blacky
