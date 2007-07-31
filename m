From: Vadim Lebedev <vadim@mbdsys.com>
Subject: Output to Input routing
Date: Tue, 31 Jul 2007 14:33:04 +0000 (UTC)
Message-ID: <loom.20070731T162636-233@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id BB81E24572
	for <alsa-devel@alsa-project.org>;
	Tue, 31 Jul 2007 16:50:08 +0200 (CEST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IFt2w-0005LW-62
	for alsa-devel@alsa-project.org; Tue, 31 Jul 2007 16:50:02 +0200
Received: from LAubervilliers-153-52-29-171.w217-128.abo.wanadoo.fr
	([217.128.124.171])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2007 16:50:02 +0200
Received: from vadim by LAubervilliers-153-52-29-171.w217-128.abo.wanadoo.fr
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2007 16:50:02 +0200
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

Hello,

I remember reading AC97 specs that there si possibility to configure it
in such a way, that when doing stereo capture, left input channel will get
actual MIC input and  right input channel will get the copy of speaker output.
This setting is ideal for echo cancellation algorithm.
To my grand dismay i'm unable to find a doc of ALSA mixer API so i'm
unsucessuful  writing code to put mixer in such mode.  
Can some kind soul please contibuite a code snippet....


Thanks
Vadim 
