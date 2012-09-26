From: Grant Diffey <gdiffey@gmail.com>
Subject: Re: Merging alsa-driver and alsa-kmirror to one GIT
	repo
Date: Wed, 26 Sep 2012 12:23:40 +1000
Message-ID: <CACckToV7R_dCNJ9OFohQsHer5aKvQTj1sS7JQ9oOYe9-dA6=Kg@mail.gmail.com>
References: <500EA085.8090105@perex.cz> <s5hboj5s2o0.wl%tiwai@suse.de>
 <500EB142.5030307@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 3554F2625D1
 for <alsa-devel@alsa-project.org>; Wed, 26 Sep 2012 04:23:42 +0200 (CEST)
Received: by obblz20 with SMTP id lz20so164919obb.38
 for <alsa-devel@alsa-project.org>; Tue, 25 Sep 2012 19:23:41 -0700 (PDT)
In-Reply-To: <500EB142.5030307@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav,

This re-organise of git repos has currently broken the link from the
project website to alsa-info.sh:

http://www.alsa-project.org/alsa-info.sh this looks like a 302 redirect to
http://git.alsa-project.org/?p=alsa-driver.git;a=blob_plain;f=utils/alsa-info.shwhich
currently giving a 404

it should point to:
http://git.alsa-project.org/?p=alsa-driver.git;a=blob_plain;f=alsa/utils/alsa-info.sh;hb=refs/heads/buildI
think ? who has the access required to fix this?

Grant
