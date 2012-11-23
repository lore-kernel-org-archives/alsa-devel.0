From: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
Subject: missing link to uapi in alsa-driver-build
Date: Sat, 24 Nov 2012 08:59:16 +1300
Message-ID: <50AFD594.8050709@blennerhassett.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id DE6B426260B
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2012 20:59:30 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1TbzPX-0001LJ-53
 for alsa-devel@alsa-project.org; Fri, 23 Nov 2012 20:59:39 +0100
Received: from 121-72-250-62.cable.telstraclear.net ([121.72.250.62])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2012 20:59:39 +0100
Received: from eliot by 121-72-250-62.cable.telstraclear.net with local
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2012 20:59:39 +0100
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I'm building in alsa-driver-build, (local kernel 3.2.0)

I found I had to add the following for a successful build

  cd alsa-kernel
  ln -s [checkout of kernel/git/tiwai]/sound/include/uapi/sound uapi


I don't know where this should be fixed in the build system...

--
Eliot
