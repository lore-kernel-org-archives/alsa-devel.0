From: "Jin-Young Park" <parkjy@mtekvision.com>
Subject: What does fifo_size mean in struct snd_pcm_hardware?
Date: Tue, 11 Mar 2008 09:19:09 +0900
Message-ID: <280b69ac0803101719w1c09b350hea532394471688e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.168])
	by alsa0.perex.cz (Postfix) with ESMTP id 17DF524378
	for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2008 01:19:10 +0100 (CET)
Received: by wf-out-1314.google.com with SMTP id 25so2858742wfa.23
	for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2008 17:19:09 -0700 (PDT)
Content-Disposition: inline
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

Hello.

Struct snd_pcm_hardware have fifo_size field.
The fifo place in audio interface(AC97, I2S) or in ALSA architecture?
What does it meaning?
I could not find it that related implementation in ALSA source code.

Thanks.
