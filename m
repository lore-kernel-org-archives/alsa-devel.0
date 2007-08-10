From: "Wei Kai" <kai.wei.cn@gmail.com>
Subject: Why there is no SNDRV_PCM_RATE_24000 in pcm.h
Date: Fri, 10 Aug 2007 14:35:53 +0800
Message-ID: <579fa30a0708092335w4c2383e5se192b96e112dce81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.231])
	by alsa0.perex.cz (Postfix) with ESMTP id B276A10386B
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Aug 2007 08:35:54 +0200 (CEST)
Received: by qb-out-0506.google.com with SMTP id f9so2131654qba
	for <alsa-devel@alsa-project.org>; Thu, 09 Aug 2007 23:35:53 -0700 (PDT)
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

hi, guys
I checked the include/sound/pcm.h in kernel and find this problem, it
seemed strange, so many codecs support the 24000 sample rate, why
there is no such definition. Any special concern?
