From: Tim Blechmann <tim@klingt.org>
Subject: route plugin issue
Date: Thu, 12 Aug 2010 13:28:26 +0200
Message-ID: <i40lsq$lq0$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 2202524488
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Aug 2010 13:28:36 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OjVxa-0003dO-OY
	for alsa-devel@alsa-project.org; Thu, 12 Aug 2010 13:28:34 +0200
Received: from 85-127-248-5.dynamic.xdsl-line.inode.at ([85.127.248.5])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 12 Aug 2010 13:28:34 +0200
Received: from tim by 85-127-248-5.dynamic.xdsl-line.inode.at with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 12 Aug 2010 13:28:34 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

hi all,

when trying to use the route plugin with an lx6464es soundcard, it seems 
that only gain values of 1 work correctly. if i apply a different gain, the 
specific channel is silent. when i was trying this on another computer (with 
an hdsp and internal hda chip), it was working fine, though ...

the only difference that i found is, that i am aware of is, that the 
lx6464es was used with 24bit samples, while the hdsp/hda were using 32bit 
samples ...

is it possible that the route plugin has an issue with 24bit samples? or may 
there be another reason, explaining this behavior?

thanks, tim

-- 
tim@klingt.org
http://tim.klingt.org

Just what the hell is the experimental tradition?
  Morton Feldman
