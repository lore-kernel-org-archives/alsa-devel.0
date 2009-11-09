From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH V2] ASoC - Add support for upto 16 channels
	on OMAP MCBSP
Date: Mon, 9 Nov 2009 08:57:22 +0200
Message-ID: <200911090857.22203.peter.ujfalusi@nokia.com>
References: <1257454808.3576.397.camel@odin>
	<6ed0b2680911071211g311e6399va88ff7daff7b8ed1@mail.gmail.com>
	<1257712022.15162.2.camel@vega>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C7DD10384C
	for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2009 08:37:20 +0100 (CET)
In-Reply-To: <1257712022.15162.2.camel@vega>
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
Cc: Graeme Gregory <gg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Grazvydas Ignotas <notasas@gmail.com>, ext Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sunday 08 November 2009 22:27:01 ext Liam Girdwood wrote:
> =

> Any chance we could have your Ack before applying.

Well, I have tried it on a system, where the McBSP is slave (codec provides=
 the =

bit and FS clock) with the following result:


aplay -Dplughw:0 /usr/share/sounds/alsa/Front_Center.wav -q
omap_mcbsp_dai_hw_params: not enough bandwidth for desired rate and channels
asoc: interface omap-mcbsp-dai-0 hw params failed
aplay: set_params:1022: Unable to install hw params:

So this patch definitely breaks McBSP slave mode.
In case when McBSP is slave, the SRG is not in use, and there is no point o=
f =

passing some bogus information in order to pass the test in =

omap_mcbsp_dai_hw_params introduced by this patch.

I think if I set the mcbsp_data->in_freq to be:
params_rate(params) * sample_bits * channels, and configure the mcbsp_data-
>clk_div to be 1, might work in this case.

But after this patch the beagle board and boards which has the McBSP as sla=
ve =

will stop working.

I'm afraid, I can not give my Ack for this :(

> =

> Thanks
> =

> Liam

-- =

P=E9ter
