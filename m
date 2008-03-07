From: bruce@azbarclay.com
Subject: Trigger problems while writing Alsa Shim
Date: Fri, 07 Mar 2008 10:10:05 -0600
Message-ID: <20080307101005.vg3idkwoyokco84w@69.49.230.6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smh01.opentransfer.com (smh01.opentransfer.com [71.18.216.112])
	by alsa0.perex.cz (Postfix) with ESMTP id BFBE8103866
	for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2008 17:10:13 +0100 (CET)
Content-Disposition: inline
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

I am writing a shim from alsa to our own sound card drivers.  I was  
able to get the init driver working and our sound card recognized.   
Things seem to be set up correctly.  When I do aplay to my device (USB  
device works find), it calls my copy callback twice and then it calls  
the trigger and fails.  The call that fails is in pcm_write  
(writei_func) with a -5.  I know that my callback returns zero but  
there must be something else under the covers since that gets to be  
zero.  Any help would be appreciated.
T
