From: Patrick Lai <plai@codeaurora.org>
Subject: Passing audio info from HDMI EDID beside speaker
	allocation
Date: Thu, 04 Oct 2012 23:50:20 -0700
Message-ID: <506E832C.50702@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine02.qualcomm.com (wolverine02.qualcomm.com
 [199.106.114.251])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F30B2615FE
 for <alsa-devel@alsa-project.org>; Fri,  5 Oct 2012 08:50:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

You proposed snd_pcm_query_chmaps() to query underlying hardware
speaker allocation. Please correct me if I have wrong understanding of
this API. On the other hand, HDMI EDID contains audio data other than
speaker allocation such as audio formats(LPCM, AC3, and etc). How are
these information other than speaker allocation passed back to the
user-space? Are there a standard kernel and alsa query interfaces now?

Thanks
Patrick

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
