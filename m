From: Reiner <reiner1210@googlemail.com>
Subject: mm functions vs. normal IO
Date: Mon, 03 Mar 2008 23:40:45 +0100
Message-ID: <47CC7E6D.4030704@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.190])
	by alsa0.perex.cz (Postfix) with ESMTP id 4AB49243AB
	for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2008 23:40:48 +0100 (CET)
Received: by mu-out-0910.google.com with SMTP id i10so525274mue.3
	for <alsa-devel@alsa-project.org>; Mon, 03 Mar 2008 14:40:47 -0800 (PST)
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

Hello,

I'am new for using ALSA API.
I was astonished that a simple wav playback example does not exist. But 
after reading the pcm examples I have managed to make one (if I will 
finish it I can post it so it can be added to the examples)

Now my question:

What should be used:

snd_pcm_mmap_commit 
<http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m___direct.html#g3e3d8bb878f70e94a746d17410e93273> 
(I think snd_pcm_mmap_writei 
<http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m___direct.html#g3a811efcd9d64b60e6a25df6924d26b0>  
is the same with an additional copy behind ?)
or
snd_pcm_writei 
<http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m.html#gf13067c0ebde29118ca05af76e5b17a9>

I think mmap will have better performance, but will it work with all 
soundcards? Or should it be in a config what to use?

I'am also looking for a function to get the number of played frames. I 
have played around with "snd_pcm_status" but it seems not to have a 
counter for this.

By the way is there a detailed tutorial (introduction) for ALSA 
available? The online help is a little bit too short for newbies. ;-)

Reiner
