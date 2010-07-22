From: =?GB2312?B?bG9uZ2VyIHpob3UgKNbcwfop?= <longer.zhou@gmail.com>
Subject: problems about converting sample rate when using ALSA
	lib
Date: Thu, 22 Jul 2010 11:38:16 +0800
Message-ID: <AANLkTincHzTzp9dWM33gDFf19NPTlWjJwvoXhztstDbj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C5B024456
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 05:38:21 +0200 (CEST)
Received: by yxm8 with SMTP id 8so2385473yxm.38
	for <alsa-devel@alsa-project.org>; Wed, 21 Jul 2010 20:38:17 -0700 (PDT)
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

Hi all,

I have a problem when using ALSA lib . The problem is :

My ALSA driver only support a special sample rate , so ALSA lib must

convert sample rates. But My driver don't get any audio data. When tracing
the

code of ALSA lib (alsa-driver-1.0.23), I found that : It mmap a address from
my

driver , but writting audio data to another address instead of that mmaped
address.



I think this is why my driver don't get any audio data .But I don't know why
it don't

write audo data to that mmaped address.


Can you help me ? Any advices would help me a lot.

Thank you,

longer.zhou
