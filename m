From: Patrick Lai <plai@codeaurora.org>
Subject: Handle large period size end-of-stream situation
Date: Wed, 03 Apr 2013 08:07:06 -0700
Message-ID: <515C459A.5070209@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine02.qualcomm.com (wolverine02.qualcomm.com
 [199.106.114.251])
 by alsa0.perex.cz (Postfix) with ESMTP id ECDCB265D66
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 17:07:09 +0200 (CEST)
Received: from [10.64.200.147] (pdmz-ns-snip_218_1.qualcomm.com
 [192.168.218.1])
 by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 4D97A10004AB
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 08:07:07 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I am dealing with a use case requiring passing large buffer down to the
DSP. Application in the user-space passes PCM through mmap interface.
Per my understanding, ALSA is designed to work with DMA. Data is
transferred in chunk equal to period size. At the end of playback,
there may not be enough audio data left in the music stream to fill
entire period. If remaining audio data only takes up very small chunk
of period, playback takes longer to stop. Given that period size I have
to deal with is quite large, this problem is observed easily. If my
understanding is correct, what is the standard/recommended way of
handling end of stream case?

Thanks
Patrick

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
