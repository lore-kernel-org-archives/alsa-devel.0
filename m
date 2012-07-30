From: Kaskinen Tanu <tanu.kaskinen@digia.com>
Subject: Shipping UCM configuration files in upstream alsa-lib
Date: Mon, 30 Jul 2012 11:38:52 +0300
Message-ID: <1343637532.4283.27.camel@IT-D-4QB9Z4J>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.digia.com (smtp1.digia.com [82.118.214.156])
 by alsa0.perex.cz (Postfix) with ESMTP id 513F126526D
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2012 10:38:52 +0200 (CEST)
Received: from smtp1.digia.com (unknown [127.0.0.1])
 by IMSVA80 (Postfix) with ESMTP id C70DB370036
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2012 11:38:53 +0300 (EEST)
Received: from IT-EXCAS02-HKI.it.local (unknown [10.9.52.71])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by smtp1.digia.com (Postfix) with ESMTP id B69CE370034
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2012 11:38:53 +0300 (EEST)
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

Hi,

It seems that there are no UCM configuration files in the alsa-lib
tarball (or am I not looking hard enough?). Has it been decided that
alsa-lib should not ship with UCM configuration files, or is it just
that nobody has so far submitted such files for inclusion? I'm about to
start learning about UCM by writing some configuration files for the
Nokia N900, and I'd like to get those files eventually to upstream.

I think it makes sense to ship the UCM files in upstream, because that
way when you port a new Linux distribution on a piece of hardware,
there's a better chance for audio to "just work". And even if Mer (which
I'm using) will be the only distribution that is going to be interested
in the UCM files for N900, Mer can avoid maintaining any patches on top
of alsa-lib if everything is in upstream.

-- 
Tanu
