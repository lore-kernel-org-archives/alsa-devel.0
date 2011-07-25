From: Tim Blechmann <tim@klingt.org>
Subject: snd_mask_min
Date: Mon, 25 Jul 2011 19:33:29 +0200
Message-ID: <j0k9da$p5j$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C425103858
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Jul 2011 19:33:52 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1QlP2G-0005Uq-BU
	for alsa-devel@alsa-project.org; Mon, 25 Jul 2011 19:33:44 +0200
Received: from rg-v34.acc.mdw.ac.at ([193.171.89.208])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 25 Jul 2011 19:33:44 +0200
Received: from tim by rg-v34.acc.mdw.ac.at with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 25 Jul 2011 19:33:44 +0200
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

i've got a problem using params_format():

it uses an inline function snd_mask_min, which is declared in 
sound/pcm_params.h, but this file is not included by sound/pcm.h, where it 
is defined. including it manually, causes a huge number of errors. it would 
be very helpful, if pcm.h would be self-contained.

cheers, tim
