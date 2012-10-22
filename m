From: Patrick Lai <plai@codeaurora.org>
Subject: Re: Passing audio info from HDMI EDID beside speaker
	allocation
Date: Mon, 22 Oct 2012 11:00:02 -0700
Message-ID: <508589A2.4080309@codeaurora.org>
References: <506E832C.50702@codeaurora.org> <s5hzk3xjryl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine02.qualcomm.com (wolverine02.qualcomm.com
 [199.106.114.251])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A3B626525B
 for <alsa-devel@alsa-project.org>; Mon, 22 Oct 2012 20:00:20 +0200 (CEST)
In-Reply-To: <s5hzk3xjryl.wl%tiwai@suse.de>
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

On 10/8/2012 1:20 AM, Takashi Iwai wrote:

> In the case of HD-audio, it's passed via the normal IEC958 status bits
> controls separately.  ELD itself is exposed as a byte array in a
> control element, but it's read-only.

Thanks for the reply. Couple more questions

1. Is kcontrol "ELD" being read directly by application or there is
ALSA library API to parse the information.

2. Also, I see you submit this patch [PATCH 3/3] ELD proc interface for
HDMI sinks in 2008. I presume it's just for information purpose. You
still expect application to query for HDMI sink capability through
"ELD" kcontrol. Am I correct?

>
>
> Takashi
>


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
