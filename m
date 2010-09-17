From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/5] fix SIU and Migo-R sound for 2.6.37
Date: Fri, 17 Sep 2010 12:29:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1009171129550.4988@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-sh@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Conversion to the multi-component design has broken the SIU driver and its 
users. This patch series fixes the breakages. All patches against 
next/master, but one of them (#4) shall also go into 2.6.36.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
