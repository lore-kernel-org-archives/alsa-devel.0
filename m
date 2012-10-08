From: Patrick Lai <plai@codeaurora.org>
Subject: Re: Passing audio info from HDMI EDID beside speaker
 allocation
Date: Sun, 07 Oct 2012 23:18:24 -0700
Message-ID: <50727030.20806@codeaurora.org>
References: <506E832C.50702@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
 [199.106.114.254])
 by alsa0.perex.cz (Postfix) with ESMTP id 8030D2615D1
 for <alsa-devel@alsa-project.org>; Mon,  8 Oct 2012 08:18:42 +0200 (CEST)
In-Reply-To: <506E832C.50702@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 10/4/2012 11:50 PM, Patrick Lai wrote:
> Hi Takashi,
>
> You proposed snd_pcm_query_chmaps() to query underlying hardware
> speaker allocation. Please correct me if I have wrong understanding of
> this API. On the other hand, HDMI EDID contains audio data other than
> speaker allocation such as audio formats(LPCM, AC3, and etc). How are
> these information other than speaker allocation passed back to the
> user-space? Are there a standard kernel and alsa query interfaces now?
>
> Thanks
> Patrick
>

Does anyone else have feedback for my query to Takashi?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
