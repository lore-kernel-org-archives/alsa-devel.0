From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Declaring HDMI channel allocation to kernel
Date: Mon, 23 Jul 2012 09:18:37 -0500
Message-ID: <500D5D3D.2060108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f44.google.com (mail-qa0-f44.google.com
 [209.85.216.44])
 by alsa0.perex.cz (Postfix) with ESMTP id B031E265CEB
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 16:18:46 +0200 (CEST)
Received: by qadz3 with SMTP id z3so1179742qad.17
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 07:18:48 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Is there an established way for me (from userspace) to pass the HDMI 
Channel Allocation (1 byte) to the driver?  If not, can you recommend an 
approach?

In most of the drivers that I've inspected, the drivers seem to assume 
that there's a 1:1 mapping of Number-of-Channels to Channel-Allocation. 
  However, the HDMI sink declares which speakers it has attached in the 
EDID.  If I can match this in userspace... I need a way to communicate 
it to the driver.

-gabriel
