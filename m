From: "Liu, George" <yueliu@lab126.com>
Subject: Re: virtual sound driver
Date: Mon, 23 Jul 2012 17:15:02 -0700
Message-ID: <164969DEADC6FB4E8F1494DA3D34E98B034658BAC1@EX-SEA19-A.ant.amazon.com>
References: <164969DEADC6FB4E8F1494DA3D34E98B034641ADAB@EX-SEA19-A.ant.amazon.com>
 <s5htxx1wmb1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-fw-9101.amazon.com (smtp-fw-9101.amazon.com
 [207.171.184.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D367264F4A
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2012 02:15:08 +0200 (CEST)
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

I installed aloop driver, and selected it as the default Audio input and output device.

Then, I played a pcm file while also started recording (using the sound recorder in Ubuntu 11.04). I'm expected to record what I'm playing, but there's no sound in the captured wav file. 
Did I do anything wrong?

I want to use aloop or dummy driver as the starting point to write my own driver. 
Thanks for helping me out.
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
