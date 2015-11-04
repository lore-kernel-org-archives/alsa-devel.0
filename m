From: "Fang, Yang A" <yang.a.fang@intel.com>
Subject: Re: [PATCH] ASoC: nau8825: fix stream_name conflicting
Date: Wed, 4 Nov 2015 22:14:23 +0000
Message-ID: <0485FB02182A4744A8B06D69AB7BF8E718E3B2A7@ORSMSX113.amr.corp.intel.com>
References: <1446596019-83464-1-git-send-email-yang.a.fang@intel.com>
 <20151104112623.GY20228@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B185426073E
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 23:14:32 +0100 (CET)
In-Reply-To: <20151104112623.GY20228@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: 'Mark Brown' <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Sripathi,
 Srinivas" <srinivas.sripathi@intel.com>, "Koul, Vinod" <vinod.koul@intel.com>, "Konno, Joe" <joe.konno@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Nujella,
 Sathyanarayana" <sathyanarayana.nujella@intel.com>, "M,
 Naveen" <naveen.m@intel.com>, "Patel, Vedang" <vedang.patel@intel.com>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Wednesday, November 04, 2015 3:26 AM
> To: Fang, Yang A
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; Nujella,
> Sathyanarayana; Koul, Vinod; M, Naveen; Sripathi, Srinivas; Konno, Joe; Patel,
> Vedang
> Subject: Re: [PATCH] ASoC: nau8825: fix stream_name conflicting
> 
> On Tue, Nov 03, 2015 at 04:13:39PM -0800, yang.a.fang@intel.com wrote:
> > From: M Naveen <naveen.m@intel.com>
> >
> > There is naming conflict with dai stream_name defined in dmic.c so
> > assign different name
> 
> What sort of conflict?  All names are scoped within their device, conflicts are
> inevitable since we support havig more than one instance of a device in the
> system.
Hi Mark,
For skylake there are two cpu BE dai  1)ssp1 Rx 2) DMIC01 Rx
In our machine driver we want to connect ssp1 Rx to Nuvuton codec and Connect DMIC01 Rx
To DMIC codec(sound/soc/codecs/dmic.c)

In our machine driver route table is like below
static const struct snd_soc_dapm_route skylake_map[] = {
{ "ssp1 Rx", NULL, " Capture" }, 
{ "DMIC01 Rx", NULL, "Capture" },
}
If we use same Capture name. When we open dmic capture we saw it is connected to SSP1-Codec
Instead of dmic01

[   53.594602]  Skl Audio Capture Port: ASoC: found 3 audio capture paths
[   53.601910]  Skl Audio Capture Port: connected new DPCM capture path Skl Audio Capture Port <- dmic01
[   53.612234]  Skl Audio Capture Port: connected new DPCM capture path Skl Audio Capture Port <- SSP1-Codec
[   53.622929]  Skl Audio Capture Port: ASoC: found 2 new BE paths
[   53.629550]  SSP1-Codec: ASoC: open capture BE SSP1-Codec

Is there a better way to differentiate the name in route map?
Thanks
