From: "Feng Ye" <fye@broadcom.com>
Subject: Re: ASoC legacy i2c client driver probing issue
Date: Tue, 3 May 2011 22:52:36 -0700
Message-ID: <9383297B60843144AC17878B479520F1164B624B63@SJEXCHCCR01.corp.ad.broadcom.com>
References: <9383297B60843144AC17878B479520F1164B62450F@SJEXCHCCR01.corp.ad.broadcom.com>
	<4DC0DC4D.4020905@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from MMS3.broadcom.com (mms3.broadcom.com [216.31.210.19])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E50510381B
	for <alsa-devel@alsa-project.org>;
	Wed,  4 May 2011 07:52:56 +0200 (CEST)
In-Reply-To: <4DC0DC4D.4020905@st.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: rajeev <rajeev-dlh.kumar@st.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I didn't call i2c_attach_client(), it's called from i2c_add_numbered_adapter().

I think the problem is in I2C side: i2c_add_numbered_adapter() is a new interface while attach_adapter() is legacy interface, these two can not work together.
I am trying to port the kernel to newer version so the drivers in sound/soc/codecs uses the new interface (probe()).


Feng


-----Original Message-----
From: rajeev [mailto:rajeev-dlh.kumar@st.com] 
Sent: Tuesday, May 03, 2011 9:56 PM
To: Feng Ye
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] ASoC legacy i2c client driver probing issue

Hi Freg

On 5/2/2011 11:48 PM, Feng Ye wrote:
> Hello,
> 
> I have a legacy i2c client driver probing issue.
> I use kernel version 2.6.27, and wm8750 external codec. The wm8750.c in sound/soc/codecs has a legacy i2c interface (e.g. use attach_adapter() callback). The callback just calls to i2c_probe(). Inside i2c_probe() it checks if the i2c address already been used, and fails there.
> 
> In our i2c bus driver, we used i2c_register_board_info() with a static i2c_board_info structure. And then i2c_add_numbered_adapter() is called.

>>From code trace, it eventually calls i2c_attach_client(). So I think the probe function will for sure to fail.
>
How does these two related ? You are calling  i2c_attach_client() then why your probe function will fail.
In fact it will never called. 


 
> I wonder how this would work? How can i2c_probe() succeed if it checks for address in use?
If it is not called then how can you decide whether it succeeded or not?

Rgds
Rajeev
> This question is more related to i2c instead of alsa soc. I am sure the SoC part is good, the i2c address is passed to wm8750 through snd_soc_codec_device.
>
> 
> 
> Thanks,
> Feng
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
