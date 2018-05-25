From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/2] slimbus: Add QCOM SLIMBus NGD driver
Date: Fri, 25 May 2018 12:15:45 +0100
Message-ID: <20180525111547.18556-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C219F26765F
 for <alsa-devel@alsa-project.org>; Fri, 25 May 2018 13:18:05 +0200 (CEST)
Received: by mail-wm0-f65.google.com with SMTP id l1-v6so13638375wmb.2
 for <alsa-devel@alsa-project.org>; Fri, 25 May 2018 04:18:05 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: gregkh@linuxfoundation.org, robh+dt@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, girishm@quicinc.com, linux-arm-msm@vger.kernel.org, broonie@kernel.org, linux-kernel@vger.kernel.org, bgoswami@codeaurora.org, kramasub@codeaurora.org, srinivas.kandagatla@linaro.org, sdharia@quicinc.com
List-Id: alsa-devel@alsa-project.org

This patchset adds support to basic version of Qualcomm NGD SLIMBus
controller driver found SoCs from B family.

This controller is light-weight SLIMBus controller driver responsible for
communicating with slave HW directly over the bus using messaging
interface, and communicating with master component residing on ADSP
for bandwidth and data-channel management.

Tested this patchset on DB820c with WCD9335 codec.
I have pushed my working branch to [1] incase someone want to try.

This patch has dependency on https://lkml.org/lkml/2018/5/17/251

Changes sinc v1 (https://lwn.net/Articles/754679):
- Fixed DT binding making NGD slave of the slim controller.
- Fixed few typos spotted by Vinod.
- Removed unnessary dmaengine_slave_config suggested by Vinod
- Removed few unnessary initializations.
- fixed commit log to remove reference to B family suggested by Trilok

Thanks,
srini

[1] https://git.linaro.org/people/srinivas.kandagatla/linux.git/log/?h=slimbus-ngd

Srinivas Kandagatla (2):
  slimbus: ngd: dt-bindings: Add slim ngd dt bindings
  slimbus: ngd: Add qcom SLIMBus NGD driver

 .../bindings/slimbus/slim-ngd-qcom-ctrl.txt        |   84 ++
 drivers/slimbus/Kconfig                            |   11 +
 drivers/slimbus/Makefile                           |    3 +
 drivers/slimbus/qcom-ngd-ctrl.c                    | 1342 ++++++++++++++++++++
 drivers/slimbus/slimbus.h                          |    8 +
 5 files changed, 1448 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
 create mode 100644 drivers/slimbus/qcom-ngd-ctrl.c

-- 
2.16.2
