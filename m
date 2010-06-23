From: dv <dv@pseudoterminal.org>
Subject: Pause functionality
Date: Wed, 23 Jun 2010 17:08:31 +0200
Message-ID: <4C22236F.6040101@pseudoterminal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pseudoterminal.org (pseudoterminal.org [213.239.220.147])
	by alsa0.perex.cz (Postfix) with ESMTP id BF907244A4
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jun 2010 17:08:30 +0200 (CEST)
Received: from [10.1.14.70] (83-64-248-68.inzersdorf.xdsl-line.inode.at
	[83.64.248.68])
	by pseudoterminal.org (Postfix) with ESMTPSA id 9372E8BCD6F
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jun 2010 17:08:30 +0200 (CEST)
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

Hi,

it is stated in the documentation that I need to check with 
snd_pcm_hw_params_can_pause() to see if the device can pause or not. If 
it can, I can use snd_pcm_pause() to pause/resume.

But what if snd_pcm_hw_params_can_pause() tells me it can't pause? What 
does one usually do then? Continue writing to pcm, with a buffer 
containing zeroed samples?
