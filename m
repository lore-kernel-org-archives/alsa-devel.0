From: Sven Zeisberg <sven.zeisberg@googlemail.com>
Subject: imx-ssi in master mode?
Date: Thu, 26 Aug 2010 17:23:53 +0200
Message-ID: <4C768708.50903@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 2E3DE24997
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Aug 2010 17:24:03 +0200 (CEST)
Received: by bwz4 with SMTP id 4so1270367bwz.38
	for <alsa-devel@alsa-project.org>; Thu, 26 Aug 2010 08:24:02 -0700 (PDT)
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

  Hi

I found that the i.MX25 can not transfer multichannels frames through 
SSI when it is set up as slave.
(when the i.MX25 SSI is set up as slave, the SSI is set to "normal" mode 
in which only one word per frame is transfered)

Now I'm wondering if anybody has successfully used a codec with the 
i.MX25 SSI set up as Master. When we do this here, we can see that the 
i.MX25 is generating the bit clock but no frame sync.

BR
Sven
