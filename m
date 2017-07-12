From: =?UTF-8?q?Felix=20H=C3=A4dicke?= <felixhaedicke@web.de>
Subject: [PATCH 0/2] Patches for salsa-lib
Date: Wed, 12 Jul 2017 22:31:12 +0200
Message-ID: <20170712203114.11870-1-felixhaedicke@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id C206726705E
 for <alsa-devel@alsa-project.org>; Wed, 12 Jul 2017 22:31:23 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, =?UTF-8?q?Felix=20H=C3=A4dicke?= <felixhaedicke@web.de>
List-Id: alsa-devel@alsa-project.org

Hi,

Here are two little patches for salsa-lib. I would be happy if these could be
included in the next release.

And I saw that in the released salsa-lib 0.1.6 tarball, the generated headers
asoundlib.h, version.h and recipe.h are included. I guess this is by mistake?
This caused unexpected behaviour for me, because when performing an
out-of-tree build, these are used instead of the generated headers in the
build directory.

Regards,
Felix

-- 
2.13.2
