From: "Zhong Li" <zql@glomationinc.com>
Subject: Bug? Sound support for at91sam9x5-wm8731 based boards
Date: Tue, 19 Nov 2013 11:51:23 -0500
Message-ID: <031f01cee547$950b5670$bf220350$@com>
References: <1384878685-1515-1-git-send-email-tony@atomide.com>
 <1384878685-1515-3-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway12.websitewelcome.com (gateway12.websitewelcome.com
 [69.56.144.7]) by alsa0.perex.cz (Postfix) with ESMTP id 7349A2610B1
 for <alsa-devel@alsa-project.org>; Tue, 19 Nov 2013 17:53:59 +0100 (CET)
Received: from ham03.websitewelcome.com (ham.websitewelcome.com
 [173.192.100.229])
 by gateway12.websitewelcome.com (Postfix) with ESMTP id CE351AA3D3369
 for <alsa-devel@alsa-project.org>; Tue, 19 Nov 2013 10:53:52 -0600 (CST)
Received: from gator4086.hostgator.com (gator4086.hostgator.com [192.185.4.98])
 by ham03.websitewelcome.com (Postfix) with ESMTP id 8C22ED0732BF2
 for <alsa-devel@alsa-project.org>; Tue, 19 Nov 2013 10:51:26 -0600 (CST)
In-Reply-To: <1384878685-1515-3-git-send-email-tony@atomide.com>
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When playing stereo sound on the Atmel at91sam9x5-ek board the left and
right channel would get swapped about 1 in 6 tries.
