From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v3] ASoC: davinci-evm: Add AM43xx-EPOS-EVM
	audio support
Date: Mon, 10 Mar 2014 12:49:56 +0200
Message-ID: <531D98D4.7080806@ti.com>
References: <5315DF41.1090302@metafoo.de>
 <1393947831-26116-1-git-send-email-jsarha@ti.com>
 <20140305014259.GR13126@sirena.org.uk> <5319BF67.3060403@ti.com>
 <20140309081102.GL28112@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F34B265113
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 11:50:01 +0100 (CET)
In-Reply-To: <20140309081102.GL28112@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, lars@metafoo.de, detheridge@ti.com
List-Id: alsa-devel@alsa-project.org

On 03/09/2014 10:11 AM, Mark Brown wrote:
> On Fri, Mar 07, 2014 at 02:45:27PM +0200, Jyri Sarha wrote:
>
>> >However, I think there is a problem with simple-card. It does not
>> >invert bitclock-master and frame-master values when converting them
>> >to CB[SM] and CF[SM] for cpu_dai as I think it should. I can get
>> >around it by setting the both cpu-dai and the codec as bclk and
>> >frame masters in the sound node. I volunteer to fix this if you
>> >agree.
> No, it shouldn't do any inversion.  If inversion is required one of the
> drivers is buggy, they are CODEC bit master and CPU bit master so for a
> CPU driver the sense should be inverted when parsing.

Yes, that is the problem. The same code in simple-card parses the codec 
node and cpu-dai node and they produce the same SND_SOC_DAIFMT_C??_C?? 
flags for both codec and cpu-dai drivers.

For example:

	simple-audio-card,cpu {
		sound-dai = <&mcasp1>;
	};

causes SND_SOC_DAIFMT_CBS_CFS flags to be set to mcasp driver in 
set_dai_fmt() call. So omitting the bitclock-master and frame-master 
parameters from cpu-dai node strangely indicates that the cpu-dai should 
be the bitclock and frame master. Can this be right?

If you do not want to have the inversion, could we at least call the 
parameters codec-bitclock-master and codec-frame-master.

Best regards,
Jyri
