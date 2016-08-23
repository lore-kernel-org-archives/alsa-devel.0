From: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Subject: Re: [PATCH 2/2] MAINTAINERS: document ASoC header files
Date: Tue, 23 Aug 2016 13:20:16 +0200
Message-ID: <c93b698e-fa0d-8442-3306-bd85a1e10274@m4x.org>
References: <20160823085122.5859-1-nicolas.iooss_linux@m4x.org>
 <20160823085247.6158-1-nicolas.iooss_linux@m4x.org>
 <874m6biz23.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 6739F266181
 for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2016 13:20:19 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id i138so17619751wmf.3
 for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2016 04:20:19 -0700 (PDT)
In-Reply-To: <874m6biz23.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 23/08/16 12:09, Kuninori Morimoto wrote:
> Hi Nicolas
> 
>> include/sound/simple_card_utils.h is handled by ASoC maintainers, as
>> stated in https://lkml.org/lkml/2016/8/22/307, and
>> include/sound/simple_card.h seems to be an ASoC file too.
>>
>> Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
>> ---
>>  MAINTAINERS | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 0bbe4b105c34..c840582d1439 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -11012,6 +11012,8 @@ S:	Supported
>>  F:	Documentation/devicetree/bindings/sound/
>>  F:	Documentation/sound/alsa/soc/
>>  F:	sound/soc/
>> +F:	include/sound/simple_card.h
>> +F:	include/sound/simple_card_utils.h
>>  F:	include/sound/soc*
> 
> We will have more simple_xxx_card in the future I think.
> (I posted simple_scu_card, for example)
> So, how about this or similar ? It can be just 1 line :)
> 
> 	include/sound/simple*card*

I can't tell whether all files matching this pattern in the future will
be supported by the ASoC maintainers, which is why I kept the full file
names in my patch. Nevertheless if you are confident about this, I can
modify the patch accordingly.

Thanks,
Nicolas
