From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Recording problem with ALSA: trying to set up some
 constraints
Date: Thu, 22 May 2008 13:03:33 +0200
Message-ID: <48355305.1090808@ladisch.de>
References: <48353DEE.1020502@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 7E5421037F7
	for <alsa-devel@alsa-project.org>;
	Thu, 22 May 2008 13:03:35 +0200 (CEST)
In-Reply-To: <48353DEE.1020502@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sedji Gaouaou wrote:
> I have a problem with my recording driver.
> I have set up a pcm_hardware structure in which I define the format
> supported by my hardware:
> ...
>     .formats        = (SNDRV_PCM_FMTBIT_S16_LE
>                    | SNDRV_PCM_FMTBIT_S16_BE
>                    | SNDRV_PCM_FMTBIT_S20_3LE
>                    ...
>
> Then in my open function I pass it to the runtime struct.
>
> Nevertheless if  I try to run arecord with this option: arecord -d 1
> test.wav, I will have a kernel oops.
> The default format is U8, but it is not supported by my Hardware, abd it
> is not defined in my structure, so I though that it should exit arecord
> but not crash.

The default device will do automatic sample format conversion, i.e.,
your driver will see a request for S16_LE.

This looks like a bug somewhere else in your driver.


Regards,
Clemens
