From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l52: Fixes for Beep Volume
	kcontrol (fwd)
Date: Mon, 5 Aug 2013 13:21:05 -0500
Message-ID: <alpine.DEB.2.10.1308051318580.5288@heelrod.ad.cirrus.com>
References: <alpine.DEB.2.10.1308051050270.5288@heelrod.ad.cirrus.com>
 <20130805162016.GR9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 044BA265179
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 20:20:43 +0200 (CEST)
In-Reply-To: <20130805162016.GR9858@sirena.org.uk>
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
Cc: Brian Austin <brian.austin@cirrus.com>, lars@metafoo.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

>> This patch reorders the min/max values for BEEP Volume.
>> Also changes SOC_SINGLE_TLV to SOC_SINGLE_SX_TLV
>> Add DB_SCALE beep_tlv for volume control
>
> Can you split this into two paches please?  The reordering is a bug fix
> which should go to the stable kernels but the new TLV isn't.
>
In trying to split up this patch wouldn't the TLV also be a bugfix? 
Currently it is using a scale that is not correct for this control. So 
really it seems this is 2 bug fixes in 1 patch. Correct? Shouldn't they 
both go to stable?
