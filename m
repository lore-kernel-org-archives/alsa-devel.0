From: Peter Rosin <peda@axentia.se>
Subject: Regression with .set_bias_level in pcm512x?
Date: Tue, 13 Jan 2015 22:49:07 +0000
Message-ID: <0bea1026e90a46769a573470a3efc935@EMAIL.axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EMAIL.axentia.se (axentia.se [87.96.186.132])
 by alsa0.perex.cz (Postfix) with ESMTP id 8487926054D
 for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2015 23:49:05 +0100 (CET)
Content-Language: sv-SE
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi!

I'm working on adding support for DAIFMT_CBM_CFM and DAIFMT_CBM_CFS
to pcm512x, and it works nicely in the 3.10 kernel + Atmel-patches were I have
developed the code. Now I'm trying to forward-port it and test it on
3.18 + other-Atmel-patches in preparation for submission. However, there
seems to be a regression in that the (pre-existing) pcm512x_set_bias_level
callback is never called in the 3.18 version.

I see that there has been some core work on set_bias_level, and suspect
it has something to do with dapm and components, but I think someone else
will find the problem much quicker than I am able to.

I have feebly tried to revert 0bd2ac3dae74ee25c5ea171cb572731c7a89c248
and 68f831c2724ab72c0088471b2ed1dc99e81948ef, but that didn't help. That
also seems a bit backwards. So, what needs to be done in the pcm512x driver
to have set_bias_level called?

Please help.

Cheers,
Peter
