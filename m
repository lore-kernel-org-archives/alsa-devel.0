From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH v3 2/3] ALSA SoC: Add mpc5200-psc I2S driver
Date: Tue, 22 Jul 2008 14:28:12 -0400
Message-ID: <9e4733910807221128h4a425c37qd9a86e8d9458d005@mail.gmail.com>
References: <20080722065352.7306.60679.stgit@trillian.secretlab.ca>
	<20080722065358.7306.9412.stgit@trillian.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.153])
	by alsa0.perex.cz (Postfix) with ESMTP id C0CFA1038A1
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Jul 2008 20:28:13 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 36so364275yxh.2
	for <alsa-devel@alsa-project.org>; Tue, 22 Jul 2008 11:28:12 -0700 (PDT)
In-Reply-To: <20080722065358.7306.9412.stgit@trillian.secretlab.ca>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, timur@freescale.com, liam.girdwood@wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

What about the mpc5200b?

+/* Match table for of_platform binding */
+static struct of_device_id psc_i2s_match[] __devinitdata = {
+       { .compatible = "fsl,mpc5200-psc-i2s", },
+       {}
+};
+MODULE_DEVICE_TABLE(of, psc_i2s_match);
+

I'm just being grumpy because updating to linus/master made me fix
over a hundred merge conflicts, now I have to test everything again.

-- 
Jon Smirl
jonsmirl@gmail.com
