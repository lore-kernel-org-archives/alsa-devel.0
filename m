From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [RFC] question regarding codec DAI ops
Date: Fri, 20 Jun 2014 16:07:03 +0200
Message-ID: <53A44007.1000008@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id A59DE265019
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 16:07:14 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Hello,

I have a platform with several audio IOs (DAC , HDMI...) and I2S In/out 
connectors.
I'm using my codec driver but for this I2S output i used dummy codec 
driver with the snd-soc-dummy-dai dai.

On platform side I have several instances of CPU DAI, and  i'm using 
helpers function like snd_soc_dai_set_tdm_slot to configure associated 
codec DAIs.

My issue is that these functions return error for my I2S output because 
ops functions are not implemented in dummy driver.

I see 3 solutions:
- implement ops in dummy drivers ( soc-utils)
- return 0 instead of error when ops is not implemented ( soc-core)
- Add a test  in my driver on ops before calling it.

First one seems the best compromise to avoid to accumulate tests in 
platform drivers.

 From your point of view, what should be best solution?

BR

Arnaud
