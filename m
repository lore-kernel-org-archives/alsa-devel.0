From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC] [patch 1/1] imx-sgtl5000: return
 E_PROBE_DEFER if ssi/codec not found
Date: Mon, 24 Jun 2013 20:26:34 -0300
Message-ID: <CAOMZO5Cm8RQAjK8M9AcE+Uyctb=5kBkD-96LiMF6M6pfni_Rgw@mail.gmail.com>
References: <20130620212100.075892857@rtp-net.org>
 <CAOMZO5DOTEGKe0Fm-54vkm+oyY4_tBwgzoLpnKdmvbdgb=s4pA@mail.gmail.com>
 <87y5a09d5d.fsf@lebrac.rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f54.google.com (mail-vb0-f54.google.com
 [209.85.212.54])
 by alsa0.perex.cz (Postfix) with ESMTP id E15F12651B9
 for <alsa-devel@alsa-project.org>; Tue, 25 Jun 2013 01:26:35 +0200 (CEST)
Received: by mail-vb0-f54.google.com with SMTP id q12so8802577vbe.27
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2013 16:26:35 -0700 (PDT)
In-Reply-To: <87y5a09d5d.fsf@lebrac.rtp-net.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 24, 2013 at 4:33 AM, Arnaud Patard
<arnaud.patard@rtp-net.org> wrote:

> I'm curious to know how to fix that with modules on a per board
> basis. Please, explain.

Ok, looks like a different problem than the one I handled before.
