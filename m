From: "Bishop, Mark" <Mark.Bishop@cooperindustries.com>
Subject: ALSA driver issue with the ssm2602.c
Date: Thu, 3 May 2012 15:30:45 -0400
Message-ID: <5D308BD40154E4439D82454FE483A5020698F4F3@EVS4.nam.ci.root>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cooperlighting-sw.cooperlighting.com
	(cooperlighting-sw.cooperlighting.com [216.130.131.68])
	by alsa0.perex.cz (Postfix) with ESMTP id 8839E1044E2
	for <alsa-devel@alsa-project.org>;
	Thu,  3 May 2012 21:31:43 +0200 (CEST)
Content-class: urn:content-classes:message
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

When I enable the 'Output Mixer HiFi' using amixer it also powers up the
Mic input on this codec.  I believe this is incorrect.  I would like to
modify the driver to fix it but am having issues with the ALSA
structures in the driver.

 

Would I be off if I attempt to make my changes in the snd_soc_dapm_route
structures?  I am unsure how everything is hooked together in all those
structs{}.
