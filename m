From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: dapm: Use card_list during DAPM
	shutdown
Date: Fri, 9 Nov 2012 16:17:08 +0000
Message-ID: <509D2C84.4080206@ti.com>
References: <1352397792-2233-1-git-send-email-misael.lopez@ti.com>
 <20121109160232.GL23807@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 45279261744
 for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2012 17:17:12 +0100 (CET)
In-Reply-To: <20121109160232.GL23807@opensource.wolfsonmicro.com>
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
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/11/12 16:02, Mark Brown wrote:
> On Thu, Nov 08, 2012 at 12:03:12PM -0600, Misael Lopez Cruz wrote:
>> DAPM shutdown incorrectly uses "list" field of codec struct while
>> iterating over probed components (codec_dev_list). "list" field
>> refers to codecs registered in the system, "card_list" field is
>> used for probed components.
>
>> Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
>> Signed-off-by: Liam Girdwood <lrg@ti.com>
>
> Applied, with Liam's signoff changed to an ack - please don't add
> signoffs for other people, the signoff means something fairly specific.
> Please see SubmittingPatches for details.
>

Fwiw, We both worked on this hence the dual sign-off, I would have complained 
anyway if my ack/sob had been added by mistake.

Liam
