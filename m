From: Qiao Zhou <zhouqiao@marvell.com>
Subject: [DAPM question] DAPM support for single input multiple
	outputs
Date: Mon, 9 Mar 2015 16:38:53 +0800
Message-ID: <54FD5C1D.9030909@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 464DA2605EA
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2015 09:38:35 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, "tiwai@suse.de" <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

I have one question and need your suggestion. Thanks in advance.

In our DSP, one stream path is like this: There is one bit controlling 
whether a signal A goes to A_out or B_out. That's the reverse case of 
DAPM_MUX(multiple inputs, single output).

One way is to use two switches but it seems not good since two switches 
control the same bit. It's strange. Do you have any opinion about such 
requirement support?
-- 

Best Regards
Qiao
