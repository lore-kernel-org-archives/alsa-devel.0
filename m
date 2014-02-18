From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 000/105] Rename soc_enum.max field
Date: Tue, 18 Feb 2014 17:11:14 +0100
Message-ID: <53038622.8050309@metafoo.de>
References: <1392722967-12472-1-git-send-email-tiwai@suse.de>
 <20140218155816.GB5438@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-025.synserver.de (smtp-out-137.synserver.de
 [212.40.185.137])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BAC32651CB
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 17:11:06 +0100 (CET)
In-Reply-To: <20140218155816.GB5438@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 02/18/2014 04:58 PM, Charles Keepax wrote:
> On Tue, Feb 18, 2014 at 12:29:24PM +0100, Takashi Iwai wrote:
>> Hi,
>>
>> this is the first chunk of the whole patch serires, preliminary works
>> for renaming the confusing field name and minor clean ups in the
>> relevant places.
>>
>> After this chunk, SOC_ENUM_*_DECL() macro cleanup and the actual fixes
>> for the wrong number of enum items will follow.
>>
>> Then introduce SOC_ENUM_SINGLE_CONST() & co for omitting the explicit
>> ARRAY_SIZE() call, and apply it in the later patches.
>>
>>
>> Takashi
>
> For all the Wolfson related patches:
>
> Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
>
> Although as Liam said please feel free to leave it out rather
> than editing all the patches.

Same here. Looks all trivial and correct if you need a ack from me for any 
of the patches, feel free to add it.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>
