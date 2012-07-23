From: "Liu, George" <yueliu@lab126.com>
Subject: Re: virtual sound driver
Date: Mon, 23 Jul 2012 14:44:46 -0700
Message-ID: <164969DEADC6FB4E8F1494DA3D34E98B034658B8D3@EX-SEA19-A.ant.amazon.com>
References: <164969DEADC6FB4E8F1494DA3D34E98B034641ADAB@EX-SEA19-A.ant.amazon.com>
 <s5htxx1wmb1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-fw-9101.amazon.com (smtp-fw-9101.amazon.com
 [207.171.184.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 1120C264F4B
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 23:45:19 +0200 (CEST)
In-Reply-To: <s5htxx1wmb1.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I'm still lost looking at the code. I understand the part to register/remove driver and card. 
One thing on my head is what exactly are the functions in snd_pcm_ops do, and what event will trigger them? 

.open	
.close
.ioctl	(use snd_pcm_lib_ioctl implementation, nothing I need to do)
.hw_params
.hw_free
.prepare
.trigger
.pointer


I added printk in each of the function in aloop, and right after loading the module, dmesg reports whole bunch of pcm_ops. 

* The sequence for each pcm seems to be:   Open -> hw_params -> hw_free -> close
* What determines how many times open->hw_params->hw_free->close is going to be called? Number of snd_pcm or substreams?
*Why pcm_trigger_start is being called?
*If I want to capture playback audio, should I capture the substream associated with the trigger (playback)? 

Thanks so much.
George



-----Original Message-----
From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Takashi Iwai
Sent: Saturday, July 21, 2012 1:28 AM
To: Liu, George
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] virtual sound driver

At Fri, 20 Jul 2012 18:05:40 -0700,
Liu, George wrote:
> 
> I'm trying to write a virtual sound driver to capture PCM data.
> How do I modify dummy.c to capture PCM into buffer?
> 
> Does the PCM data ever sent to any of the pcm_op call backs? There's no read/write callbacks?

Did you take a look at aloop driver?


Takashi
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
