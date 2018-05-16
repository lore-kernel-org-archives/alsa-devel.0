From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/2] slimbus: Add QCOM SLIMBus NGD driver
Date: Wed, 16 May 2018 17:51:16 +0100
Message-ID: <20180516165118.16551-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f195.google.com (mail-wr0-f195.google.com
 [209.85.128.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B88F266DF0
 for <alsa-devel@alsa-project.org>; Wed, 16 May 2018 18:54:05 +0200 (CEST)
Received: by mail-wr0-f195.google.com with SMTP id 94-v6so2178019wrf.5
 for <alsa-devel@alsa-project.org>; Wed, 16 May 2018 09:54:05 -0700 (PDT)
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, girishm@quicinc.com, linux-arm-msm@vger.kernel.org, broonie@kernel.org, linux-kernel@vger.kernel.org, bgoswami@codeaurora.org, kramasub@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, sdharia@quicinc.com
List-Id: alsa-devel@alsa-project.org

This patchset adds support to basic version of Qualcomm NGD SLIMBus
controller driver found SoCs from B family.

This controller is light-weight SLIMBus controller driver responsible for
communicating with slave HW directly over the bus using messaging
interface, and communicating with master component residing on ADSP
for bandwidth and data-channel management.

Tested this patchset on DB820c with WCD9335 codec.
I have pushed my working branch to [1] incase someone want to try.
 

Thanks,
srini

[1] https://git.linaro.org/people/srinivas.kandagatla/linux.git/log/?h=slimbus-ngd

Srinivas Kandagatla (2):
  slimbus: ngd: dt-bindings: Add slim ngd dt bindings
  slimbus: ngd: Add qcom SLIMBus NGD driver

 .../bindings/slimbus/slim-ngd-qcom-ctrl.txt        |   70 ++
 drivers/slimbus/Kconfig                            |   10 +
 drivers/slimbus/Makefile                           |    3 +
 drivers/slimbus/qcom-ngd-ctrl.c                    | 1298 ++++++++++++++++++++
 drivers/slimbus/slimbus.h                          |    8 +
 5 files changed, 1389 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
 create mode 100644 drivers/slimbus/qcom-ngd-ctrl.c

-- 
2.16.2
