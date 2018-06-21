From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/2] slimbus: Add Stream Support
Date: Thu, 21 Jun 2018 14:40:07 +0100
Message-ID: <20180621134009.27116-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f196.google.com (mail-wr0-f196.google.com
 [209.85.128.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FF002673F2
 for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2018 15:42:22 +0200 (CEST)
Received: by mail-wr0-f196.google.com with SMTP id w7-v6so3258855wrn.6
 for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2018 06:42:22 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: gregkh@linuxfoundation.org, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, ctatlor97@gmail.com, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, sdharia@quicinc.com
List-Id: alsa-devel@alsa-project.org

This patchset adds basic stream support for SLIMbus devices and
controllers. Mostly inspired by soundwire stream patches. But slimbus
stream is much simpler compared to soundwire

>From slim_device side, we have below 6 new apis.
slim_stream_allocate() - allocating runtime slim stream
slim_stream_prepare() - to configure runtime stream with config
slim_stream_enable() - enable channels/ports for data
slim_stream_disable() - disable channels/ports.
slim_stream_unprepare() - un configure runtime stream
slim_stream_free() - free all associated memory.

>From Controller side:
Data channel Management and reconfiguration messages are applicable for
all the controllers which are inline with SLIMbus specs. However light
weight controller like NGD which have user specific implementation of
some messages need to be invoked instead of standard message commands.
For usecases like this simple enable/disable stream apis are provided.

Assumptions:
1> Current design assumes that the channel and ports are statically allocated
to the device during SoC integration, which is the case with all the
Qualcomm SoCs.
2> One-to-One mapping between Port and Channel, SLIMBus versions earlier
than 2.0 has only one endpoint per port. Current patchset can be extended
to support more than one endpoints per port.
3> Only audio usecase, This patchset only supports Isochronous and Push/Pull
transport protocols, which are sufficient for audio use cases.
4> DSP does all the data handling for the allocated channels. Which is true
for Qcom SoCs.

TODO:
	Bandwidth management.

Dependency:
	This patchset has dependency on the NGD driver
	https://patchwork.kernel.org/patch/10474959/

Tested this patchset with WCD9335 codec playback on DB820c on
top of 4.18-rc1 with qdsp6.

I have pushed my working branch to [1] incase someone want to try.

[1]:https://git.linaro.org/people/srinivas.kandagatla/linux.git/log/?h=slimbus-ngd


Thanks,
srini

Srinivas Kandagatla (2):
  slimbus: stream: add stream support
  slimbus: ngd: add stream support

 Documentation/driver-api/slimbus.rst |   5 +
 drivers/slimbus/Makefile             |   2 +-
 drivers/slimbus/core.c               |   2 +
 drivers/slimbus/qcom-ngd-ctrl.c      | 144 +++++++++-
 drivers/slimbus/slimbus.h            | 206 +++++++++++++++
 drivers/slimbus/stream.c             | 493 +++++++++++++++++++++++++++++++++++
 include/linux/slimbus.h              |  56 ++++
 7 files changed, 905 insertions(+), 3 deletions(-)
 create mode 100644 drivers/slimbus/stream.c

-- 
2.16.2
