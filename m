From: ecmk <info@ecmk.org>
Subject: Kernel patch needed for Asus Q325UAR
Date: Fri, 12 Apr 2019 14:43:50 -0700
Message-ID: <1887e6cb-0c33-664c-d3be-c282d8b797de@ecmk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 882E2F80716
 for <alsa-devel@alsa-project.org>; Fri, 12 Apr 2019 23:43:55 +0200 (CEST)
Received: from [10.20.2.178] ([12.37.157.226]) by mrelay.perfora.net
 (mreueus001 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Mgdfd-1hTiYx2UvX-00OANT
 for <alsa-devel@alsa-project.org>; Fri, 12 Apr 2019 23:43:52 +0200
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

No sound combined with quickly fading sounds for a few seconds. Randomly 
working but with low quality distorted sound. The model needs to be 
added to the kernel patch listed bellow.


Asus Q325UAR suffers from the same issues as discussed here:


[alsa-devel] [PATCH] ALSA: hda/realtek: Enable audio jacks of ASUS 
UX391UA with, ALC294

https://mailman.alsa-project.org/pipermail/alsa-devel/2018-December/143282.html


A detailed issue of the problem plus the solution is described here

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1784485?comments=all


Thanks
