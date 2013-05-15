From: Jordi Mallach <jordi@debian.org>
Subject: Debian alsa-tools patches
Date: Wed, 15 May 2013 19:19:03 +0200
Message-ID: <1368638351-29200-1-git-send-email-jordi@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tempesta.oskuro.net (tempesta.oskuro.net [92.243.30.96])
 by alsa0.perex.cz (Postfix) with ESMTP id E6014261722
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 19:19:19 +0200 (CEST)
Received: from penyagolosa.oskuro.net (169.219.14.37.dynamic.jazztel.es
 [37.14.219.169])
 by tempesta.oskuro.net (Postfix) with ESMTPSA id 1D16B62838
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 19:19:19 +0200 (CEST)
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

As previously discussed, I'm posting all Debian patches against alsa-tools
that were pending upstreaming.

Please review patch 8, as this one is new and the general state of
configure scripts in alsa-tools is less than optimal.

I've left out the patch to correct envy24control's configuration directory,
as the additional check for the old dir is not implemented. If anyone wants
to pick that up, please contact me or fetch the (trivial) patch from Debian
sources.

Thanks,
Jordi
