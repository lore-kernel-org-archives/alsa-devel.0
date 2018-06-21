From: Harald Schuster <schuster@technikum-wien.at>
Subject: poll blocked after prepare state
Date: Thu, 21 Jun 2018 10:42:24 +0000
Message-ID: <20180621104224.Horde.WJU_RKtLDLoAGMPfW3FREnA@webmail.technikum-wien.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="Yes"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bifrost.technikum-wien.at (bifrost.technikum-wien.at
 [195.245.225.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 54BE9267610
 for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2018 12:42:25 +0200 (CEST)
Received: from mail.technikum-wien.at (groupware.technikum-wien.at
 [10.127.0.250])
 by bifrost2.technikum-wien.at (Postfix) with ESMTPS id 6520722A6
 for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2018 12:42:24 +0200 (CEST)
Content-Disposition: inline
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


Hi
I have a problem when I got an underrun that my playback path is not  
working correctly any longer.
I debugged the problem and see that the snd_pcm_direct_prepare  
function is called and than the snd_pcm_dshare_start function. After  
this the snd_pcm_write_areas is called and the snd_pcm_wait_nocheck  
never returns. He is blocked in the poll function. Is there any  
solution for this problem?!
best regards
Harald
