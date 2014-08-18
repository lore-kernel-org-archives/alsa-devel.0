From: Inha Song <ideal.song@samsung.com>
Subject: [PATCH v3 0/2] mfd: arizona: add support for INn_MODE
 register control using platform data
Date: Mon, 18 Aug 2014 20:00:00 +0900
Message-ID: <20140818200000.60302a15@songinha-Samsung-DeskTop-System>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by alsa0.perex.cz (Postfix) with ESMTP id F3F362654BD
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 13:00:09 +0200 (CEST)
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NAI007B8181AZB0@mailout2.samsung.com> for
 alsa-devel@alsa-project.org; Mon, 18 Aug 2014 20:00:01 +0900 (KST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, sameo@linux.intel.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, cw00.choi@samsung.com, robh+dt@kernel.org, galak@codeaurora.org, ckeepax@opensource.wolfsonmicro.com, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

This patch series add support for INn_MODE register control using platform data.
Each input signal path can be configurated either as a Analogue or Digital using
the INn_MODE registers.

Changes for v3
- Change to use of_property_read_u32_array
- Fix a few typos
- Update commit message

Changes for v2
- Change to support
- Update commit message
- Update document content for more clarity

Inha Song (2):
  mfd: arizona: Add support for INn_Mode register control
  mfd: arizona: Update DT binding to support INn_MODE init_data

 Documentation/devicetree/bindings/mfd/arizona.txt | 8 ++++++++
 drivers/mfd/arizona-core.c                        | 8 +++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.0.0.390.gcb682f8
