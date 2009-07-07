From: Susan Cragin <susancragin@earthlink.net>
Subject: No incoming sound indigo iox
Date: Tue, 7 Jul 2009 11:28:08 -0400 (EDT)
Message-ID: <30136324.1246980488566.JavaMail.root@elwamui-ovcar.atl.sa.earthlink.net>
Reply-To: Susan Cragin <susancragin@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from elasmtp-banded.atl.sa.earthlink.net
	(elasmtp-banded.atl.sa.earthlink.net [209.86.89.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 0D9602449E
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 17:28:12 +0200 (CEST)
Received: from [209.86.224.44] (helo=elwamui-ovcar.atl.sa.earthlink.net)
	by elasmtp-banded.atl.sa.earthlink.net with esmtpa (Exim 4.67)
	(envelope-from <susancragin@earthlink.net>) id 1MOCaW-0000Ab-Kt
	for alsa-devel@alsa-project.org; Tue, 07 Jul 2009 11:28:08 -0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I just purchased the indigoaudio iox. 
Outgoing shows up on Volume Control, incoming does not.
In Audacity, incoming shows up as: ALSA: Indigo IOx (hw:1,0)
but recording does not work. 

Here's the catch. My problem may be due to my kernel. 
I am running Ubuntu-Studio and have the 29.5-2-rt experimental kernel, which is the 5-1 recompiled with alsadriver support for 30 kernels. 
So you may just tell me to go away until the kernel's better, but I don't think the kernel is the problem. 

FYI
winecfg says:
fixme:mixer:ALSA_MixerInit No master control found on Indigo IOx, disabling mixer
