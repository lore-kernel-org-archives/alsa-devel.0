From: Alan Young <Alan.Young@IEE.org>
Subject: Difference between boundary and buffer_size
Date: Thu, 3 Nov 2016 09:11:04 +0000
Message-ID: <581AFF28.5060500@IEE.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
 by alsa0.perex.cz (Postfix) with ESMTP id CD151266702
 for <alsa-devel@alsa-project.org>; Thu,  3 Nov 2016 10:11:06 +0100 (CET)
Received: by mail-wm0-f43.google.com with SMTP id a197so190868739wmd.0
 for <alsa-devel@alsa-project.org>; Thu, 03 Nov 2016 02:11:06 -0700 (PDT)
Received: from [192.168.11.11] (13.110.6.51.dyn.plus.net. [51.6.110.13])
 by smtp.googlemail.com with ESMTPSA id 18sm7822526wmr.6.2016.11.03.02.11.05
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Nov 2016 02:11:05 -0700 (PDT)
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

The code in the kernel, in /pcm_lib.c/ and /pcm_native.c/, uses fields 
buffer_size and boundary in struct snd_pcm_runtime. As far as I can see, 
there are always initialized to the same value. In what circumstance 
might they be different? There is clearly some relationship to 
hw_ptr_base, as illustrated by this repeated snipped from 
snd_pcm_update_hw_ptr0()

		hw_base += runtime->buffer_size;
		if (hw_base >= runtime->boundary) {
			hw_base = 0;
			crossed_boundary++;
		}
		new_hw_ptr = hw_base + pos;

Alan.
