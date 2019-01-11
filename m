From: Sameer Pujar <spujar@nvidia.com>
Subject: Re: [PATCH 1/5] ALSA: hda: add verbs for stripe control
Date: Fri, 11 Jan 2019 17:00:34 +0530
Message-ID: <cbb717e8-0f2f-f99e-9d64-fb8074693a7c@nvidia.com>
References: <1547139805-1904-1-git-send-email-spujar@nvidia.com>
 <s5h1s5jo2v5.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com [216.228.121.64])
 by alsa0.perex.cz (Postfix) with ESMTP id 829A62668B2
 for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2019 12:30:40 +0100 (CET)
In-Reply-To: <s5h1s5jo2v5.wl-tiwai@suse.de>
Content-Language: en-GB
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org


On 1/11/2019 4:52 PM, Takashi Iwai wrote:
> On Thu, 10 Jan 2019 18:03:21 +0100,
> Sameer Pujar wrote:
>> Controllers can support multiple Serial Data Out(SDO) lines, for
>> extended outbound bandwidth, to pump data to all codecs on the link.
>> Codecs can sample data present on SDO.
>>
>> Add verbs AC_VERB_GET_STRIPE_CONTROL and AC_VERB_SET_STRIPE_CONTROL
>> These can be used to program usage of SDO lines for codec.
>>
>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>> Reviewed-by: Mohan Kumar D <mkumard@nvidia.com>
>> Reviewed-by: Ravindra Lokhande <rlokhande@nvidia.com>
> Could you put a cover letter at the next submission?

Sorry for the naive question.
Could you please point me to a reference how cover letter for a patch 
should look like?

Thanks,
Sameer.

>
> thanks,
>
> Takashi

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
