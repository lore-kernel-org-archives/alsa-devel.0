From: Christian Gruber <christian.gruber@voiceinterconnect.de>
Subject: Missing snd_pcm_link() for the rate plugin
Date: Fri, 11 Sep 2015 09:42:24 +0200
Message-ID: <55F285E0.7030100@voiceinterconnect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dd27002.kasserver.com (dd27002.kasserver.com [85.13.145.216])
 by alsa0.perex.cz (Postfix) with ESMTP id 14641261555
 for <alsa-devel@alsa-project.org>; Fri, 11 Sep 2015 09:19:22 +0200 (CEST)
Received: from Mail-Gateway (ip923450f2.dynamic.kabel-deutschland.de
 [146.52.80.242])
 by dd27002.kasserver.com (Postfix) with ESMTPSA id 4A4C11120355
 for <alsa-devel@alsa-project.org>; Fri, 11 Sep 2015 09:19:21 +0200 (CEST)
Received: from kepler.vic.site ([192.168.13.149])
 by Mail-Gateway with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.80) (envelope-from <christian.gruber@voiceinterconnect.de>)
 id 1ZaIcA-0002Ea-HC
 for alsa-devel@alsa-project.org; Fri, 11 Sep 2015 09:19:20 +0200
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

does anybody know, why the rate plugin does not support the snd_pcm_link() function?

As I can see from the ALSA-Lib source code, snd_pcm_link() calls the fast_op "link", which 
is a function pointer, whose destination depends on the type of pcm device/plugin to be 
linked.

If the device is a HW-device for instance, the function snd_pcm_hw_link() is called. 
Several other plugins (e.g. mmap_emul, linear, lfloat, mulaw, alaw, route) use the generic 
function snd_pcm_generic_link(), which forwards the function call to their slave 
devices/plugins.

The rate plugin instead does not support snd_pcm_link(), since the function pointer "link" 
is not assigned in the definition of snd_pcm_rate_fast_ops.

Is their any reason to not use the generic function snd_pcm_generic_link() within the rate 
plugin?

Thanks in advance for answering this question,

Christian
