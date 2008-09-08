From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 2/5] Separate common pxa2xx-ac97 code
Date: Mon, 8 Sep 2008 09:42:50 +0000 (UTC)
Message-ID: <ga2s2q$sge$3@ger.gmane.org>
References: <20080908085339.GA31573@doriath.ww600.siemens.net>
	<1220864773-31745-1-git-send-email-dbaryshkov@gmail.com>
	<1220864773-31745-2-git-send-email-dbaryshkov@gmail.com>
	<1220866410.17091.81.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 315F72454A
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Sep 2008 11:43:04 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KcdGq-0004x9-TE
	for alsa-devel@alsa-project.org; Mon, 08 Sep 2008 09:42:56 +0000
Received: from iap-pxy-mow1.siemens.ru ([212.248.25.26])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2008 09:42:56 +0000
Received: from dbaryshkov by iap-pxy-mow1.siemens.ru with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2008 09:42:56 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote:

> On Mon, 2008-09-08 at 13:06 +0400, Dmitry Baryshkov wrote:
>> ASoC and non-ASoC drivers for ACLINK on PXA share lot's of common code.
>> Move all common code into separate file.
>> 
>> +#include "pxa2xx-ac97-lib.c"
>>  
>>  
> Any reason for not linking with pxa2xx-ac97-lib.o ?
> 

>> +#include "../../arm/pxa2xx-ac97-lib.c"
> 
> 
> ditto
> 
>>  static void pxa2xx_ac97_warm_reset(struct snd_ac97 *ac97) {
> 
> Liam


That is the interim change. In the next patch the file is fully separated
into distinct module. I can squash those patches if you'd prefer.


-- 
With best wishes
Dmitry
