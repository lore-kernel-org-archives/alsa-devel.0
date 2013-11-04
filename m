From: Nicolin Chen <b42378@freescale.com>
Subject: What about symmetric_channels and symmetric_samplebits?
Date: Mon, 4 Nov 2013 19:02:51 +0800
Message-ID: <20131104110250.GA2652@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0187.outbound.messaging.microsoft.com [213.199.154.187])
 by alsa0.perex.cz (Postfix) with ESMTP id 645AB2608EA
 for <alsa-devel@alsa-project.org>; Mon,  4 Nov 2013 12:04:06 +0100 (CET)
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

As far as I know, some SoCs can only work in mono or stereo mode at
one time. So if we let them capture a mono stream while playing a
stereo stream, there might be a problem occur to one of these two
streams: double-paced or slowed down.

I just want to ask: Is there any existing solution for the case?

In soc-pcm.c, we have soc_pcm_apply_symmetry() to solve unmatched
sample rates situation for simultaneous playback and capture. But
we don't have one for channels. Is that reasonable to add a similar
one for it?

Likewise, we can treat symmetric_rate as a solution for those SoCs
or CODECs which can not handle asymmetrical LRCLK. But it's also
impossible for them to handle asymmetrical BCLK. And accodring to
BCLK = LRCLK * channel number * slot size(fixed or sample bits),
sample bits might also be a problem if they are not using a fixed
slot size.

Thank you,
Nicolin Chen
