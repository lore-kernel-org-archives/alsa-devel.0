From: mick <mick37@gmx.de>
Subject: Re: Tenor TE8802,
 USB : clics and crackles during music play
Date: Mon, 14 Apr 2014 12:44:40 +0200
Message-ID: <op.xeaysqhpwx6sbz@ws00534.pq>
References: <CA+T9nP_hcPQBoQwike7oB5TfECax2MvARv0dTG9qB-RdFMuy=w@mail.gmail.com>
 <CA+T9nP-=ffsy9ftnxynUhdJK_Eev+S-MRznLz7CED-Yp3DiOjg@mail.gmail.com>
 <20140114143417.GB23764@tamtam.fritz.box>
 <loom.20140404T165417-983@post.gmane.org> <533ECF3C.3020404@ladisch.de>
 <op.xdya5wmiwx6sbz@ws00534.pq> <534305F1.8040805@ladisch.de>
 <op.xdznse1cwx6sbz@ws00534.pq> <5343CF9B.8020202@ladisch.de>
 <op.xd3dibs3wx6sbz@ws00534.pq> <53466319.7010606@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by alsa0.perex.cz (Postfix) with ESMTP id D165C26164C
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 12:44:43 +0200 (CEST)
In-Reply-To: <53466319.7010606@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens,

I figured out what the problem is.
When I said the quirk code gets called I made a mistake. It did not.
What happens is this:
You are setting udh01_fb_quirk in the sync endpoint but at the line where
you query it you are asking the data endpoint. So the patch of the patch  
is:

-	if (unlikely(ep->udh01_fb_quirk)) {
+	if (unlikely(sender->udh01_fb_quirk)) {

With this change everything works fine with my TEAC A-H01.
The crackle is gone and grep for the momentary frequency shows no jumps  
anymore.

Regards,
Mick
