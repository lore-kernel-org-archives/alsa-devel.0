From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCHv2 2/3] ASoC: io: New signature for
	snd_soc_codec_set_cache_io()
Date: Sat, 01 Mar 2014 14:05:34 +0100
Message-ID: <5311DB1E.30008@metafoo.de>
References: <1393578267-18255-1-git-send-email-Li.Xiubo@freescale.com>
 <1393578267-18255-3-git-send-email-Li.Xiubo@freescale.com>
 <20140301043458.GR29849@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-167.synserver.de (smtp-out-186.synserver.de
 [212.40.185.186])
 by alsa0.perex.cz (Postfix) with ESMTP id D58E0265334
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 14:05:08 +0100 (CET)
In-Reply-To: <20140301043458.GR29849@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 03/01/2014 05:34 AM, Mark Brown wrote:
> On Fri, Feb 28, 2014 at 05:04:26PM +0800, Xiubo Li wrote:
>> Now that all users have been converted to regmap and the config.reg_bits
>> and config.val_bits can be setted by each user through regmap core API.
>> So these two params are redundant here.
>
> Actually, I think the way to fix the issue with CODECs doing I/O in
> probe is to provide a way for drivers to specify a regmap when
> registering the CODEC (rather than during probe) and then move the
> initialisation of the regmap before the probe function is called.  That
> would make set_cache_io() go away entirely.

Yep, that's actually my preference as well.
