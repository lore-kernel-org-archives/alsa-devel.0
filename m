From: Matt Flax <flatmax@flatmax.org>
Subject: [TDM help please] multiplex out a stereo I2S line
Date: Fri, 14 Oct 2016 15:34:18 +1100
Message-ID: <fafbe67e-a126-f682-5d5c-cae9b5c09fc4@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nskntmtas02p.mx.bigpond.com (nskntmtas02p.mx.bigpond.com
 [61.9.168.140]) by alsa0.perex.cz (Postfix) with ESMTP id 4978F2659AA
 for <alsa-devel@alsa-project.org>; Fri, 14 Oct 2016 06:34:23 +0200 (CEST)
Received: from nskntcmgw07p ([61.9.169.167]) by nskntmtas02p.mx.bigpond.com
 with ESMTP
 id <20161014043420.IAES2042.nskntmtas02p.mx.bigpond.com@nskntcmgw07p>
 for <alsa-devel@alsa-project.org>; Fri, 14 Oct 2016 04:34:20 +0000
Received: from monstilationax2 ([192.168.0.51]) by meb with esmtp (Exim 4.84_2)
 (envelope-from <flatmax@flatmax.org>) id 1buuGc-0000zm-K4
 for alsa-devel@alsa-project.org; Fri, 14 Oct 2016 15:38:47 +1100
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
List-Id: alsa-devel@alsa-project.org

Hi there,

Problem is that I need multiplex all 6 channels out a stereo I2S line.

I have a working system ... the CPU thinks it is stereo I2S, but the 
codec thinks it is TDM multichannel. When I aplay a pre-interleaved wav 
file, it works ! Check the video here : 
https://www.kickstarter.com/projects/1250664710/1299781340?token=e465b540

Problem is that I need to multiplex all 6 channels down the stereo I2S 
line. I have tried to do this with the asoundrc by attempting to declare 
the same device 3 times and interleaving there, however have failed.

I am happy to alter my machine driver to implement this ... Is there a 
way to present 3 stereo subdevices to the user, where each of these 
subdevcies is interleaved to form the TDM before sending to the codec ?

Is there perhaps a better or more elegant way to go about this ?

thanks

Matt
