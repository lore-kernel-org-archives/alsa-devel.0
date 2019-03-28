From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Subject: Re: [PATCH] ASoC: mt8183: change supported formats of
 DL2 and UL1
Date: Thu, 28 Mar 2019 08:28:08 +0800
Message-ID: <1553732888.13776.2.camel@mtksdaap41>
References: <20190327064236.144843-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 18FDCF801D9
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2019 01:28:19 +0100 (CET)
In-Reply-To: <20190327064236.144843-1-tzungbi@google.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Tzung-Bi Shih <tzungbi@google.com>
Cc: alsa-devel@alsa-project.org, cychiang@google.com, jiaxin.yu@mediatek.com, broonie@kernel.org, shunli.wang@mediatek.com, eason.yen@mediatek.com, dgreid@google.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2019-03-27 at 14:42 +0800, Tzung-Bi Shih wrote:
> DL2 and UL1 should only provide 16-bit, mono, 8kHz and 16kHz to
> userspace.  Change the formats accordingly.
> 
> Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>

Hi,
	i thought we should report hardware capabilities, not user space's
intention?
