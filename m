From: Daniel Mack <daniel@zonque.org>
Subject: Re: Tenor TE8802,
 USB : clics and crackles during music play
Date: Thu, 17 Apr 2014 09:27:37 +0200
Message-ID: <534F8269.6000005@zonque.org>
References: <CA+T9nP_hcPQBoQwike7oB5TfECax2MvARv0dTG9qB-RdFMuy=w@mail.gmail.com>
 <CA+T9nP-=ffsy9ftnxynUhdJK_Eev+S-MRznLz7CED-Yp3DiOjg@mail.gmail.com>
 <20140114143417.GB23764@tamtam.fritz.box>
 <loom.20140404T165417-983@post.gmane.org> <533ECF3C.3020404@ladisch.de>
 <op.xdya5wmiwx6sbz@ws00534.pq> <534305F1.8040805@ladisch.de>
 <op.xdznse1cwx6sbz@ws00534.pq> <5343CF9B.8020202@ladisch.de>
 <op.xd3dibs3wx6sbz@ws00534.pq> <53466319.7010606@ladisch.de>
 <op.xeaysqhpwx6sbz@ws00534.pq>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id A113E2608E8
 for <alsa-devel@alsa-project.org>; Thu, 17 Apr 2014 09:27:40 +0200 (CEST)
In-Reply-To: <op.xeaysqhpwx6sbz@ws00534.pq>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mick <mick37@gmx.de>, Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Andrea Messa <andr.messa@tiscali.it>
List-Id: alsa-devel@alsa-project.org

On 04/14/2014 12:44 PM, mick wrote:
> I figured out what the problem is.
> When I said the quirk code gets called I made a mistake. It did not.
> What happens is this:
> You are setting udh01_fb_quirk in the sync endpoint but at the line where
> you query it you are asking the data endpoint. So the patch of the patch  
> is:
> 
> -	if (unlikely(ep->udh01_fb_quirk)) {
> +	if (unlikely(sender->udh01_fb_quirk)) {
> 
> With this change everything works fine with my TEAC A-H01.
> The crackle is gone and grep for the momentary frequency shows no jumps  
> anymore.

Nice catch. Clemens, with the above correction of the patch, Andrea
Messa reported success as well (had some private conversation on this).

When respinning the patch, you can add

  Tested-by: Andrea Messa <andr.messa@tiscali.it>


Many thanks, everyone!

Daniel
