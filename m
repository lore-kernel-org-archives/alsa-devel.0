From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: GIT: Regarding the issue we are facing in the
 commit 37728639ae05de702825d96bd1d42e24ae772248
Date: Thu, 4 Jul 2019 12:18:24 +0200
Message-ID: <556614e1-acba-635c-beed-6484fb887299@perex.cz>
References: <1561976891-17886-1-git-send-email-vanitha.channaiah@in.bosch.com>
 <645a08c3-0e40-6148-3831-4987bf7d0673@perex.cz>
 <8292ab7db32e4621865c2180a0a808a1@in.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 86D86F800E8
 for <alsa-devel@alsa-project.org>; Thu,  4 Jul 2019 12:18:28 +0200 (CEST)
In-Reply-To: <8292ab7db32e4621865c2180a0a808a1@in.bosch.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "Channaiah Vanitha (RBEI/ECF3)" <Vanitha.Channaiah@in.bosch.com>
Cc: "Wischer Timo (ADITG/ESS)" <twischer@de.adit-jv.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dne 03. 07. 19 v 14:17 Channaiah Vanitha (RBEI/ECF3) napsal(a):
> Hello Jaroslav-san,
> 
>> I think that it would be probably best to force the parameters for your hardware (--period-size and --buffer-size arguments for aplay or the time counterparts - --period-time and --buffer-time). The refining rules might not select the perfect configuration in some cases.
> 
> I tried to force parameters "period-size" in multiples of 2ms as our hardware supports 2ms period time data and buffer-size=twice period size.
> But still I face the issue.

There is no exact 2ms period size for the rate 11025Hz, because it's float
number 21.9780 (period size)... You may try values like 15,35,45,105 (anything
which can match 11025 / PERIOD_SIZE without the remainder).

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
