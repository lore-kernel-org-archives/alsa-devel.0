From: John John <tobler_one@hotmail.it>
Subject: how many processed frames? + various thoughts
Date: Thu, 30 Sep 2010 20:49:53 +0200
Message-ID: <BAY148-w10DFB4C223E0F94E5ABEB58A680@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bay0-omc3-s4.bay0.hotmail.com (bay0-omc3-s4.bay0.hotmail.com
	[65.54.190.142])
	by alsa0.perex.cz (Postfix) with ESMTP id 3050A103960
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Sep 2010 20:49:55 +0200 (CEST)
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


Hello all,
I'm rather new to ALSA development. I would like to build a little loop-player driven by a beat counter 
and a good mail exchange from linuxaudio.org gave me a smart solution: to count the beat bars into the 
audio thread. Knowing the sample rate and the processed samples, I'm able to calculate the clock (what do you 
think about this approach?). And now my question: is there a good function into alsa API which returns 
the number of processed frames? Or even better, is it possibile to fire a callback after N frames?
Thank you in advance (and sorry for my English)!

JJ
 		 	   		  
