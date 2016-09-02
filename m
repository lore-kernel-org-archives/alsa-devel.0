From: DIDIER Philippe <philippedidier@laposte.net>
Subject: missing header in last alsa-lib-1.1.2
Date: Fri, 2 Sep 2016 21:01:31 +0200
Message-ID: <57C9CC8B.4010606@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.laposte.net (smtpoutz298.laposte.net [178.22.154.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E1D1F267299
 for <alsa-devel@alsa-project.org>; Fri,  2 Sep 2016 21:01:32 +0200 (CEST)
Received: from smtp.laposte.net (localhost [127.0.0.1])
 by lpn-prd-vrout010 (Postfix) with ESMTP id 8116645AF91
 for <alsa-devel@alsa-project.org>; Fri,  2 Sep 2016 21:01:32 +0200 (CEST)
Received: from smtp.laposte.net (localhost [127.0.0.1])
 by lpn-prd-vrout010 (Postfix) with ESMTP id 7151E45AFB3
 for <alsa-devel@alsa-project.org>; Fri,  2 Sep 2016 21:01:32 +0200 (CEST)
Received: from lpn-prd-vrin002 (lpn-prd-vrin002.laposte [10.128.63.3])
 by lpn-prd-vrout010 (Postfix) with ESMTP id 6BB7245AF91
 for <alsa-devel@alsa-project.org>; Fri,  2 Sep 2016 21:01:32 +0200 (CEST)
Received: from lpn-prd-vrin002 (localhost [127.0.0.1])
 by lpn-prd-vrin002 (Postfix) with ESMTP id 5BD815BF0D2
 for <alsa-devel@alsa-project.org>; Fri,  2 Sep 2016 21:01:32 +0200 (CEST)
Received: from localhost.localdomain (vaf26-1-82-242-180-170.fbx.proxad.net
 [82.242.180.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lpn-prd-vrin002 (Postfix) with ESMTPSA id 31CEC5BF0A7
 for <alsa-devel@alsa-project.org>; Fri,  2 Sep 2016 21:01:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Since my distribution (Mageia) updated to the last alsa-lib  (1.1.2)
some packages won't build with it
For instance Bristol needs an header that exists in the previous version
(1.1.1) and disappeared in the last tarball
there was :
/alsa-lib-1.1.1.tar.bz2/alsa-lib-1.1.1/include/iatomic.h
and it exists no more in the last one

Is it a mistake ?

Thanks
