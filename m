From: Christian Gruber <christian.gruber@voiceinterconnect.de>
Subject: Support for snd_pcm_link() on the rate plugin
Date: Mon, 10 Aug 2015 14:48:11 +0200
Message-ID: <55C89D8B.6060503@voiceinterconnect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dd27002.kasserver.com (dd27002.kasserver.com [85.13.145.216])
 by alsa0.perex.cz (Postfix) with ESMTP id 36DA52608BC
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2015 14:25:34 +0200 (CEST)
Received: from Mail-Gateway (ip923450f2.dynamic.kabel-deutschland.de
 [146.52.80.242])
 by dd27002.kasserver.com (Postfix) with ESMTPSA id 61E3D11201EB
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2015 14:25:33 +0200 (CEST)
Received: from kepler.vic.site ([192.168.13.149])
 by Mail-Gateway with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.80) (envelope-from <christian.gruber@voiceinterconnect.de>)
 id 1ZOm8w-0001an-Ml
 for alsa-devel@alsa-project.org; Mon, 10 Aug 2015 14:25:32 +0200
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

Dear ALSA community,

I have a question regarding the usage of the function snd_pcm_link() on the rate plugin.

As can be seen from its implementation (see pcm.c, line 1368), the function snd_pcm_link() 
calls the fast_op "link" of the first pcm device/plugin to be linked, which is a function 
pointer, whose destination depends on the type of pcm device/plugin to be linked.

If the device is a HW-device, the function snd_pcm_hw_link() is called for instance (see 
pcm_hw.c). Several other plugins use the generic function snd_pcm_generic_link() (see 
pcm_generic.c, line 212), which forwards the function call to their slave devices/plugins, 
e.g. the plugins mmap_emul, linear, lfloat, mulaw, alaw, route, etc.

The rate plugin instead does not support snd_pcm_link(), since the function pointer "link" 
is not assigned in the definition of snd_pcm_rate_fast_ops (see pcm_rate.c, line 1153).

Why does the rate plugin not support snd_pcm_link()? Is their any reason to not use the 
generic function snd_pcm_generic_link() within the rate plugin? If yes, what's the reason 
for it?


Thanks in advance for answering this question,

Christian
