From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_pcm_multi_rewind
Date: Tue, 24 Aug 2010 09:35:53 +0200
Message-ID: <4C737659.8020902@ladisch.de>
References: <AANLkTinY8Q1d2Bo4HSVQYKAeRy0K_xPHU9Y-bT=m1t9i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id E9B2224627
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Aug 2010 09:35:45 +0200 (CEST)
Received: from compute3.internal (compute3.internal [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C57C23EA
	for <alsa-devel@alsa-project.org>; Tue, 24 Aug 2010 03:35:44 -0400 (EDT)
Received: from [10.1.2.56] (srv004.schk01.int.dmc-one.com [85.232.8.141])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 675CE408E67
	for <alsa-devel@alsa-project.org>; Tue, 24 Aug 2010 03:35:44 -0400 (EDT)
In-Reply-To: <AANLkTinY8Q1d2Bo4HSVQYKAeRy0K_xPHU9Y-bT=m1t9i@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Raymond Yau wrote:
>     snd_pcm_uframes_t pos[multi->slaves_count];

> why the pos array can be assigned dimension by multi->slaves_count ?

Because the C standard says so.

> does sizeof(pos) return the correct size ?

Yes.

> why input parameter "frames" can be modified ?
> 
>         frames = f;

Because the C standard says so.


Regards,
Clemens
