From: Ricardo Neri <rneri@dextratech.com>
Subject: Re: [RESEND PATCH] ASoC: OMAP: HDMI: Initialize
 IEC-60958 channel status word
Date: Fri, 11 Jan 2013 19:45:47 -0600
Message-ID: <50F0C04B.2040405@dextratech.com>
References: <1357864333-18742-1-git-send-email-rneri@dextratech.com>
 <20130111235940.GC7873@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dextratech.com (spamfilter.dextratech.com [187.141.251.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 9AB0C26507F
 for <alsa-devel@alsa-project.org>; Sat, 12 Jan 2013 02:45:50 +0100 (CET)
In-Reply-To: <20130111235940.GC7873@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com, dzuniga@dextratech.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 01/11/2013 05:59 PM, Mark Brown wrote:
> On Thu, Jan 10, 2013 at 06:32:13PM -0600, Ricardo Neri wrote:
>> As the IEC-60958 channel status word is set by ANDing and ORing with
>> the appropriate definitions, the word bytes need to be initialized
>> to zero to avoid misconfiguration due to previous hw_params calls.
>>
>> Signed-off-by: Ricardo Neri <rneri@dextratech.com>
>
> You've dropped my ack from this, you should keep acks on patches you
> resubmit to save people time on review.

Sorry, I missed that. I just basically went ahead and resubmitted 
because you ack'ed it but the patch was not applied. I guess I should 
have clarified that this change was independent of the video tree.
>
> Anyway, I guess there's no need to merge via the video tree now so
> applied.
>

Thanks!

Ricardo
