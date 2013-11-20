From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 00/11] codecs: Use IS_ENABLED() macro
Date: Wed, 20 Nov 2013 15:37:40 -0200
Message-ID: <1384969072-25906-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f44.google.com (mail-yh0-f44.google.com
 [209.85.213.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DE61261A1F
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 18:38:04 +0100 (CET)
Received: by mail-yh0-f44.google.com with SMTP id f64so1947548yha.17
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 09:38:03 -0800 (PST)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Using the IS_ENABLED() macro can make the code shorter and simpler.

Mark,

There are still more ocurrences that can be converted to IS_ENABLED.

If you are happy with this series I will send another one with the remaining
pieces.
