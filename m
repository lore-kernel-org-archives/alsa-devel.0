From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH 0/2] ASoC: codec: add DT support to dmic codec
Date: Tue, 25 Jul 2017 10:48:12 +0200
Message-ID: <1500972494-10696-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 53302266A8A
 for <alsa-devel@alsa-project.org>; Tue, 25 Jul 2017 10:48:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.de>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

These patches add of_table description in dmic codec to support DT probing.
As this codec is a generic code to support simple digital microphone,
compatibility field is generic.

Arnaud Pouliquen (2):
  ASoC: Add bindings for DMIC codec driver
  ASoC: codec: add DT support in dmic codec

 Documentation/devicetree/bindings/sound/dmic.txt | 12 ++++++++++++
 sound/soc/codecs/dmic.c                          |  6 ++++++
 2 files changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/dmic.txt

-- 
2.7.4
