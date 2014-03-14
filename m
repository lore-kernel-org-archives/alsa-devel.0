From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Staticise
 non-exported symbols
Date: Fri, 14 Mar 2014 09:31:44 +0100
Message-ID: <5322BE70.9030809@metafoo.de>
References: <1394732900-17182-1-git-send-email-broonie@kernel.org>
 <5322B93C.8080403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-088.synserver.de (smtp-out-118.synserver.de
 [212.40.185.118])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A6BC264FF9
 for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2014 09:31:03 +0100 (CET)
In-Reply-To: <5322B93C.8080403@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 03/14/2014 09:09 AM, Jyri Sarha wrote:
> On 03/13/2014 07:48 PM, Mark Brown wrote:
>> From: Mark Brown <broonie@linaro.org>
>>
>> Signed-off-by: Mark Brown <broonie@linaro.org>
>
>
> Acked-by: Jyri Sarha <jsarha@it.com>
>
> /me has added one more thing to his patch sending check list.

What I typically try to do before submitting a patch is run

make C=2 .../driver.o
make C=2 CHECK=scripts/coccicheck .../driver.o
make C=2 CHECK="smatch --full-path -p=kernel" .../driver.o

that will typically catch these little mistakes. Also of course 
scripts/checkpatch.pl on the patch itself.

- Lars
