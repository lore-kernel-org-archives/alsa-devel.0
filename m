From: "Banajit Goswami" <bgoswami@codeaurora.org>
Subject: compress: adding support for hardware dependent params
Date: Sun, 2 Feb 2014 02:50:36 -0000
Message-ID: <655481c83253b83c0c7b902829eabfa6.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.11.231])
 by alsa0.perex.cz (Postfix) with ESMTP id 635D42608CA
 for <alsa-devel@alsa-project.org>; Sun,  2 Feb 2014 03:57:21 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vinod.koul@linux.intel.com, pierre-louis.bossart@linux.intel.com
Cc: alsa-devel@alsa-project.org, plai@codeaurora.org
List-Id: alsa-devel@alsa-project.org

Hi,

 We have a requirement, where we need to set a number of hardware specific
parameters for compressed offload use-cases, before starting a stream. As
these parameters need to be set once for the entire session, we would
like to explore the best way to set these additional parameters somewhere
before calling trigger() function.
 Below are few of the proposed solutions that we could think of at this
point for getting this done-


1. Adding new IOCTL call: Add a new ioctl control in compress-offload.c
file to handle hardware specific parameters setting. This new ioctl
control will call into soc-compress.c and eventually call into platform
driver ioctl to set those hardware specific parameters. In this case, we
will add a new structure, let's say "snd_compr_hw_ctrl_params", with the
same fields as "snd_compr_metadata" struct.


2. Adding a function hw_dependant_hw_params(), which will be called after
hw_params() and before prepare() function. The new function will
eventually call into the platform driver to get the hardware specific
parameters set. Once implemented, this would look something like-
  hw_params();
  hw_dependant_hw_params();
  prepare();


3. Add a function "hw_dependant_hw_params()", as _part_ of the hw_params()
function. This new function will be called after the (existing) generic
parameters are set. So once implemented, the proposed function calls would
look like-
  hw_params() {
	generic_hw_params();
	hw_dependant_hw_params();
  }
  prepare();


We would like to get feedback on these proposed solutions and get a
discussion going to see how best these requirements can be fitted in the
current Compressed ALSA framework (for mainlining).

Thanks and Regards,
Banajit Goswami

The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
