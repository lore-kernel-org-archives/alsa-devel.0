From: Eran Guendelman <erang@stanford.edu>
Subject: probing state of high definition audio card in windows
 / SigmaTel STAC9221 microphone problems
Date: Fri, 08 Jun 2007 03:36:12 -0700
Message-ID: <4669311C.6020800@stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from agp.stanford.edu (agp.Stanford.EDU [171.67.73.10])
	by alsa0.perex.cz (Postfix) with ESMTP id F1978244D7
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Jun 2007 12:37:08 +0200 (CEST)
Received: from window.stanford.edu ([171.64.77.10])
	by agp.stanford.edu with esmtp (Exim 4.43) id 1Hwbq7-0004qZ-1r
	for alsa-devel@alsa-project.org; Fri, 08 Jun 2007 03:37:07 -0700
Received: from c-69-181-74-191.hsd1.ca.comcast.net ([69.181.74.191]
	helo=[192.168.1.200])
	by window.Stanford.EDU with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.43) id 1Hwbq6-0006tq-AM
	for alsa-devel@alsa-project.org; Fri, 08 Jun 2007 03:37:06 -0700
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

Hi, I am struggling to get the (external) microphone working on a 
SigmaTel STAC9221 A1 device on my Dell XPS M1210 laptop.  I saw other 
emails indicating that this was still problematic, and the latest 
drivers from alsa 1.0.14 did not seem to fix the problem.

So now that I've started reading and trying to understand the basics 
behind the hda codec in an effort to fix this problem, I was wondering 
if it was possible for me to boot into windows (I've got a dual-boot 
setup), get into a state where the microphone is working, and somehow 
probe the codec's state at that time (all of the pin configurations, 
etc.)... then theoretically, if I reproduce that configuration on the 
linux side, it should work (right?).

So the question is, does anyone have a ready-made utility for Windows to 
do this probe of the high definition audio codec?  I could probably try 
writing one myself, but thought I'd check if it already exists.

Thanks.

Please send responses by email too (not subscribed).
