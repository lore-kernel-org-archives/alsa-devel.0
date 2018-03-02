From: <twischer@de.adit-jv.com>
Subject: [PATCH - JACK plugin 1/4] jack: Do not Xrun the ALSA
	buffer
Date: Fri, 2 Mar 2018 17:21:11 +0100
Message-ID: <1520007674-14618-1-git-send-email-twischer@de.adit-jv.com>
References: <s5hfu5jizsv.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id BBB90267408
 for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2018 17:21:35 +0100 (CET)
In-Reply-To: <s5hfu5jizsv.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Takashi,

The following patches introduce two helper functions:
- snd_pcm_ioplug_hw_avail() Provides the available frames for the hardware/DMA
- snd_pcm_areas_copy_wrap() considers the buffer_size to split the copy operation into several parts

With the usage of this helper functions the complexity of the JACK plugin is reduced.
Please have a look and give some feedback.

I have not yet compiled nor tested it.

Best regards

Timo
