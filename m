From: Hunter S <ovariegata@yahoo.com>
Subject: alsa-plugins slibtool build failure
Date: Wed, 29 Nov 2017 23:31:33 +0000 (UTC)
Message-ID: <551192022.6017011.1511998293979@mail.yahoo.com>
References: <551192022.6017011.1511998293979.ref@mail.yahoo.com>
Reply-To: Hunter S <ovariegata@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sonic301-4.consmr.mail.bf2.yahoo.com
 (sonic301-4.consmr.mail.bf2.yahoo.com [74.6.129.43])
 by alsa0.perex.cz (Postfix) with ESMTP id C4D8C267960
 for <alsa-devel@alsa-project.org>; Thu, 30 Nov 2017 00:31:42 +0100 (CET)
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

Hi
I tired to build alsa-plugins on Slackware64-current with slibtool instead of the GNU libtool and received this build failure.
Full log - https://pastebin.com/ebjG60wk

With help from #midipix @ freenode which maintains slibtool I found that adding '-pthread' to arcam-av/Makefile.am will allow building alsa-plugins with both libtool and slibtool.
Here is a patch that does that, can it be applied to future versions of alsa-plugins?
https://pastebin.com/w5T6FkZy

Thanks,Hunter
