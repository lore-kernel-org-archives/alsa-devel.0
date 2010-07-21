From: Raul Xiong <raulxiong@gmail.com>
Subject: Question for ALSA I/O Plugin
Date: Wed, 21 Jul 2010 15:16:23 +0800
Message-ID: <AANLkTimGr0u6_kO4ksIDz9s3qpxFCc5AMM8WEGZhNP06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 9F39B24491
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jul 2010 09:16:24 +0200 (CEST)
Received: by vws9 with SMTP id 9so7075321vws.38
	for <alsa-devel@alsa-project.org>; Wed, 21 Jul 2010 00:16:23 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

I know that there are two kinds of ALSA external Plugin: filter-type and I/O
type.
Now I have an I/O Plugin named phone. Can it be a slave of a internal
Plugin? E.g. can I use this way: aplay -Dplug:phone wav.

Thanks!
