Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25A2C4332F
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Dec 2022 10:11:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0D31771C4;
	Fri, 23 Dec 2022 11:10:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0D31771C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1671790285;
	bh=MvokDkjhsF+ltraCTSnyoeB09ZGgGHFXSzkgyBZ5LS8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nM+ks9uxpmNg+aHq6H6a5A2xgjI/K47HaoEHnpMUSSqslZWLRoUQavAGfCJbEb9sH
	 e/409erWSROjoDjQ0loltWbimkfxi5XsB6JmpjOfX9fJERL6rGaSADaxDiunfUecOq
	 CLOco9JEeT46+zKTITfnTZiyddV07U4+T5Dvq/UI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 96F06F804B0;
	Fri, 23 Dec 2022 11:10:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C8BF6F804AD; Fri, 23 Dec 2022 11:10:31 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 4AF19F8047B
 for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2022 11:10:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4AF19F8047B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1671790229371182919-webhooks-bot@alsa-project.org>
References: <1671790229371182919-webhooks-bot@alsa-project.org>
Subject: alsaloop: confusing line of code and easier example of the use of
 snd_pcm_poll_descriptors API
Message-Id: <20221223101031.C8BF6F804AD@alsa1.perex.cz>
Date: Fri, 23 Dec 2022 11:10:31 +0100 (CET)
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/alsa-utils issue #185 was edited from anthonio9:

Hi! Recently I've been studying the `alsaloop` software, I'm trying to understand how should the `snd_pcm_poll_descriptors` api be used reliably. Reading through the `pcmjob.c` file I've noticed that in the `pcmjob_pollfds_handle` function in line 1964 there's a condition that does not exactly make sense to me. What's the purpose of variable `loopcount`? If the code is more or less

```cpp
int loopcount = 0;

do
{
// instructions
loopcount++;
} while ((ccount > 0 || pcount > 0) && loopcount > 10); // line 1964
```
isn't it equal to running the loop just once without any loops? After all, the `loopcount` will never reach 10 and the conditional statement will always turn false finishing the loop after one iteration. Correct me if I'm wrong.

I suppose that condition would make more sense if it was as below:

```cpp
} while ((ccount > 0 || pcount > 0) && loopcount < 10); // line 1964
```

then the loop would be stop for iterating too many times, assuming that 10 is "too many". With the part `loopcount < 10` deleted, the loop usually runs twice.

I'd also appreciate a simpler example than `alsaloop` focusing just on the audio parts, on transferring audio  from input to output reliably with the use of `snd_pcm_poll_descriptors`.

Thanks

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/185
Repository URL: https://github.com/alsa-project/alsa-utils
