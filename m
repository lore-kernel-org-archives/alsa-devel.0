From: Will Wagner <will_wagner@carallon.com>
Subject: softvol plugin question
Date: Wed, 07 May 2008 14:34:50 +0100
Message-ID: <4821AFFA.7010401@carallon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from carallon.f9.co.uk (carallon.force9.co.uk [80.229.37.120])
	by alsa0.perex.cz (Postfix) with ESMTP id B5C9D2465D
	for <alsa-devel@alsa-project.org>;
	Wed,  7 May 2008 15:36:33 +0200 (CEST)
Received: from [127.0.0.1] by carallon.f9.co.uk (MDaemon PRO v9.6.5)
	with ESMTP id md50000229026.msg
	for <alsa-devel@alsa-project.org>; Wed, 07 May 2008 14:35:45 +0100
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

I have successfully set up alsa for my custom hardware and am using 
sofvol plugin to do volume control as my hardware does not support it.

The problem I am having is that the softvol control does not appear to 
amixer until I have first used the softvol plugin with aplay. Is there a 
simple way of 'loading' the softvol plugin at startup so that the 
control gets created immediately?

Thanks,

Will.
-- 
------------------------------------------------------------------------
Will Wagner                                     will_wagner@carallon.com
Senior Project Engineer                  Office Tel: +44 (0)20 7371 2032
Carallon Ltd, Studio G20, Shepherds Building, Rockley Rd, London W14 0DA
------------------------------------------------------------------------
