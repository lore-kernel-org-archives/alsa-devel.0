From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: Re: How to do pause/resume in ALSA application
Date: Thu, 6 Mar 2008 00:44:13 +0530
Message-ID: <010C7BAE6783F34D9AC336EE5A01A0880575FA06@dbde01.ent.ti.com>
References: <010C7BAE6783F34D9AC336EE5A01A0880575F767@dbde01.ent.ti.com>
	<47CEC1F7.3040709@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id EED0210387A
	for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2008 20:15:27 +0100 (CET)
Content-class: urn:content-classes:message
In-Reply-To: <47CEC1F7.3040709@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, suresh.raj@gmail.com
List-Id: alsa-devel@alsa-project.org

Clemens,

Are you suggesting a bug in the driver or in the library? 

I passed "plughw:0,0" as the device name. We have our own driver for the
audio codec, written as per the ALSA framework.  

Thanks & Regards,
Anuj Aggarwal
 
 

-----Original Message-----
From: alsa-devel-bounces@alsa-project.org
[mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Clemens
Ladisch
Sent: Wednesday, March 05, 2008 9:23 PM
To: Aggarwal, Anuj
Cc: alsa-devel@alsa-project.org; suresh.raj@gmail.com
Subject: Re: [alsa-devel] How to do pause/resume in ALSA application

Aggarwal, Anuj wrote:
> I am using the snd_pcm_pause API in my application but it is returning
> error: Invalid argument.

This indicates that the driver (or some PCM plugin) does not support
pausing.

> I checked whether the pause functionality is supported, using
> snd_pcm_hw_params_can_pause() and it returned me success.

This is a bug.  What device name did you use when opening the device,
and which driver are you using?


Regards,
Clemens
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
