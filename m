From: =?UTF-8?Q?Hauke_Kr=c3=bcger?= <public-hk@ind.rwth-aachen.de>
Subject: Alsa Application using the "default" plugin
Date: Sun, 7 Aug 2016 18:29:54 +0200
Message-ID: <57A76202.9040304@ind.rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx-out-2.rwth-aachen.de (mx-out-2.rwth-aachen.de
 [134.130.5.187])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DC71265B3F
 for <alsa-devel@alsa-project.org>; Sun,  7 Aug 2016 18:29:55 +0200 (CEST)
Received: from [192.168.178.121] (aftr-88-153-6-101.unity-media.net
 [88.153.6.101])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.ind.rwth-aachen.de (Postfix) with ESMTP id A48061674131
 for <alsa-devel@alsa-project.org>; Sun,  7 Aug 2016 18:29:54 +0200 (CEST)
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

Hi everyone,

I have created an ALSA audio application which works fine for any kind 
of hardware device (all devices addressed by "hw:n,m").

Today, I planned to implement the functionality to also address plugins. 
My test case is the "default" plugin.
When using this, I see significant differences:

1) Function "snd_pcm_hw_params_any" returns a value of 1. For hardware 
devices it returns 0. There is no documentation of the return type from 
that function. What does the 1 say?
2) I want to simultaneously capture and playback. Therefore I call 
"snd_pcm_link". This function fails with the error saying that this 
function is not implemented. Is that the intended behavior and how would 
I synchronize input and output? What I do to fix this is to start input 
and output ("snd_pcm_start") independently if "snd_pcm_link" fails.
3) The program stops working on the second call to "snd_pcm_writei": The 
function call simply never returns. I guess that the pcm output 
interface does not run at this moment and the output buffer has been 
completely filled before.

All other functions calls work as expected but the described behavior 
prevents the application from working properly. And - to repeat - the 
same code works for all hardware soundcards "hw:n,m" which I tested.

What is the recommended way to address the "default" plugin pcm device?

Best regards

Hauke
