From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Tenor TE8802,
 USB : clics and crackles during music play
Date: Thu, 10 Apr 2014 11:23:37 +0200
Message-ID: <53466319.7010606@ladisch.de>
References: <CA+T9nP_hcPQBoQwike7oB5TfECax2MvARv0dTG9qB-RdFMuy=w@mail.gmail.com>
 <CA+T9nP-=ffsy9ftnxynUhdJK_Eev+S-MRznLz7CED-Yp3DiOjg@mail.gmail.com>
 <20140114143417.GB23764@tamtam.fritz.box>
 <loom.20140404T165417-983@post.gmane.org> <533ECF3C.3020404@ladisch.de>
 <op.xdya5wmiwx6sbz@ws00534.pq> <534305F1.8040805@ladisch.de>
 <op.xdznse1cwx6sbz@ws00534.pq> <5343CF9B.8020202@ladisch.de>
 <op.xd3dibs3wx6sbz@ws00534.pq>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id ABD6B265AD9
 for <alsa-devel@alsa-project.org>; Thu, 10 Apr 2014 11:23:37 +0200 (CEST)
In-Reply-To: <op.xd3dibs3wx6sbz@ws00534.pq>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mick <mick37@gmx.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

mick wrote:
> I tried the patch but it does not help. Still crackles.

Do you get changing values, and any out-of-range values, when you execute
this while it's playing?

  (while sleep 0.123; do grep 'Momentary freq' /proc/asound/card*/stream0; done) | uniq


Regards,
Clemens
