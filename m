From: Uli Franke <uli.franke@weiss.ch>
Subject: Test device for automated testing
Date: Wed, 16 Sep 2015 14:32:58 +0200
Message-ID: <55F9617A.6040301@weiss.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server11.hostfactory.ch (server11.hostfactory.ch
 [62.146.13.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 971682614D6
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2015 14:32:59 +0200 (CEST)
Received: from [192.168.1.112] (165.90.0.85.dynamic.wline.res.cust.swisscom.ch
 [85.0.90.165])
 by server11.hostfactory.ch (Postfix) with ESMTPA id 40FD460036620
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2015 14:32:59 +0200 (CEST)
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

Hi everybody,

we're currently writing a lot of ALSA user space applications. In order
to test this code with our unit testing and other test environments we'd
like to know if there's a dummy PCM device which provides the
fundamental operations like reading/writing and setting the common
hardware parameters. It doesn't even have to supply some useful
functionality like loop back or similar.

Neither the docs nor the goo led us to something useful.

Thanks and regards
Uli
