From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv2 0/6] One simple card use case
Date: Mon, 13 Jan 2014 13:53:52 +0800
Message-ID: <1389592438-13761-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 by alsa0.perex.cz (Postfix) with ESMTP id C30F32619E5
 for <alsa-devel@alsa-project.org>; Mon, 13 Jan 2014 07:51:04 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

This patch series is one use case of simple card driver based on dts.
For some audio cards they need to add some off-CODEC widgets. For the
audio card, if it needs off-CODEC widgets, some explict code for a
simple audio is needed, if not, just ignore of this.

This can make the audio card driver simpler and easier to debug by using
the simple card driver and some explict code if needed.
