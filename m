From: Andrew Bell <andrew.bell.ia@gmail.com>
Subject: EPIPE and underruns
Date: Mon, 4 Oct 2010 15:39:45 -0500
Message-ID: <AANLkTi=3phX8UtGd0wbrfv7gYHYYV1TitWE4bvm4CTAi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E97B51038E8
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Oct 2010 22:39:45 +0200 (CEST)
Received: by yxs7 with SMTP id 7so1137080yxs.38
	for <alsa-devel@alsa-project.org>; Mon, 04 Oct 2010 13:39:45 -0700 (PDT)
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

Hi,

Can somebody explain precisely the circumstances leading to an EPIPE
as the result of a pcm_snd_writei()?

What buffer has been underrun that leads to this error?  Does
providing more data to pcn_snd_writei() help alleviate the issue?

Thanks,

-- 
Andrew Bell
andrew.bell.ia@gmail.com
