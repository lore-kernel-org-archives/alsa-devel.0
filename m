From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [alsa-devel] [PATCH 0/4] ASoC: add graph base connection on
 simple-card
Date: Wed, 20 Apr 2016 18:18:55 +0200
Message-ID: <20160420181855.38a9dc6dfb4eaeb538a7d5ee@free.fr>
References: <871t68wxxe.wl%kuninori.morimoto.gx@renesas.com>
	<20160414110128.56a0da97d526cdcb8d5f1ddf@free.fr>
	<87h9f3jq3m.wl%kuninori.morimoto.gx@renesas.com>
	<87fuunjkio.wl%kuninori.morimoto.gx@renesas.com>
	<20160415133158.9c5c0dc7367325606c53ce17@free.fr>
	<87r3e3ej5t.wl%kuninori.morimoto.gx@renesas.com>
	<20160418093827.65b9f8a5bd2ec17cde2e7b5b@free.fr>
	<87shyhngdd.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87shyhngdd.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, Laurent <laurent.pinchart@ideasonboard.com>, Lars-Peter Clausen <lars@metafoo.de>, Jose Abreu <Jose.Abreu@synopsys.com>, Linux-DT <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On Wed, 20 Apr 2016 02:55:39 +0000
Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> wrote:

> I could understand your idea,
> and had read previous some discussions.
> I would like to have it on upstream too.
> Can you show me about your plan for next step ?

Hi Kuninori,

I have no plan.
My Cubox machine has too many specific code and it is used in an organ
as the sound synthesizer. I will not do any more development in its
kernel.
In my new machine, an Orange PI 2, while audio on HDMI is working for
me, there is still a lot of job to do aside (YUV video, analog
audio, embedded wifi...) and I am blocked by the HDMI driver which has
no free license nor documentation about the hardware. So, I have not
submitted yet a patch series about audio for this machine.

Otherwise, if you read the previous discussions, I think the most
important is Mark's remark (Sat, 7 Feb 2015 16:33:55 +0800 in the
alsa-devel mailing-list):

> We already have simple-card to provide a binding for trivial
> systems and don't want to end up with a never ending series of slight=
ly
> more complicated bindings which each cover slightly different sets of
> systems in ways that users struggle to differentiate between.

--=20
Ken ar c'henta=F1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
