From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: ASOC and 12 bit volume control
Date: Sat, 19 Jul 2008 22:18:55 -0400
Message-ID: <9e4733910807191918w24558b25o783da05843499580@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 73C64247DB
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Jul 2008 04:18:56 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so308363ywk.2
	for <alsa-devel@alsa-project.org>; Sat, 19 Jul 2008 19:18:55 -0700 (PDT)
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
To: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

How do I define a volume control that is the bottom 12 bits of a 32
bit register?

#define SOC_SINGLE_VALUE(reg, shift, max, invert) ((reg) | ((shift) << 8) |\
	((shift) << 12) | ((max) << 16) | ((invert) << 24))

This looks like it only support an 8 bit max. Is there another way to do it?

-- 
Jon Smirl
jonsmirl@gmail.com
