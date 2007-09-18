From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] cs4231: remove two auto-calibrations
 during chip initialization
Date: Tue, 18 Sep 2007 13:26:49 +0200
Message-ID: <46EFB5F9.4090909@gmail.com>
References: <20070918121758.5686aa96.krzysztof.h1@gmail.com>
	<46EFAA91.6050305@gmail.com>
	<Pine.LNX.4.61.0709181305130.8148@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id ABBB2244B5
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Sep 2007 13:27:47 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.61.0709181305130.8148@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@suse.cz>
Cc: Krzysztof Helt <krzysztof.h1@gmail.com>, Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 09/18/2007 01:08 PM, Jaroslav Kysela wrote:

> On Tue, 18 Sep 2007, Rene Herman wrote:
> 
>> On 09/18/2007 12:17 PM, Krzysztof Helt wrote:
>>
>>> From: Krzysztof Helt <krzysztof.h1@wp.pl>
>>>
>>> The initialization function did auto-calibration after each
>>> register setting. This patch merges more register changes
>>> before auto-calibration is done.
>> Seems to make sense but am a little uneasy about these -- someone very much
>> did it this way on purpose originally it seems. Jaroslav, that someone was you
>> I believe? Do you remember anything about this?
> 
> If I remember correctly, it was workaround for some CS4231 chips to fix 
> the noise audio issue (the chip was not initialized correctly in some 
> cases). I would make a whitelist for "non-buggy" tested chips to skip 
> double calibration.

Okay thanks. For reference, I have:

AD1848
AD1848KP
AD1845JP
AD1845XP
AD1846JP

CS4248-KL
CS4231
CS4231A-KL
CS4232-KQ
CS4235-XQ3
CS4236B-KQ
CS4237B-XQ3
CS4239-KQ

(Won't be testing right now, but will be generally available).

Rene.
