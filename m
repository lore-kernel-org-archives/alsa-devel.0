From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: Noise in begnning of alsa application
Date: Mon, 21 Jan 2019 19:07:09 +0100
Message-ID: <4a800a2a-50ce-8bda-3b5c-26d782c40810@ivitera.com>
References: <CALW20Z3_KeN7c7k-zL5T0YbW6Zd2t_OUCUbfa1+8_nY6PTEAYg@mail.gmail.com>
 <CALW20Z27AZcDWANkgvu5XQMtpWo6EJWOoMCAUV43QrV72qHSBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (cable.insite.cz [84.242.75.189])
 by alsa0.perex.cz (Postfix) with ESMTP id E40E32667E7
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2019 19:07:19 +0100 (CET)
In-Reply-To: <CALW20Z27AZcDWANkgvu5XQMtpWo6EJWOoMCAUV43QrV72qHSBg@mail.gmail.com>
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
To: Chakravarthi Pradeep <doubleq7@gmail.com>, alsa-devel@alsa-project.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org


Dne 21. 01. 19 v 18:46 Chakravarthi Pradeep napsal(a):
> On Wed, Jan 16, 2019 at 5:07 PM Chakravarthi Pradeep <doubleq7@gmail.com> wrote:
>>
>> I have ALSA driver for capture device which works fine with VLC. when
>> I try to capture and render using own application having some issues.
>> When I start play, it has some noise in beginning and audio is
>> discontinuous in between. Discontinuous means, some audio frame are
>> getting dropped in between. cut cut sound for sine wave. I have tried
>> snd_pcm_drop and snd_pcm_drain but no use. Kindly suggest how to
>> remove the starting noise in ALSA.

I have experienced the same issue, with ice172 driver. IMO part of the 
first period when opening the stream contains samples from the previous 
run. In one of my my projects I have to drop initial samples in order to 
get correct and stable results from FFT analysis.

I do not know if the problem is in the driver, alsa-lib or if the 
application (in my case the SDL library) uses alsa-lib API incorrectly. 
To tell the truth I did not investigate details and "fixed" it by 
dropping the initial samples.

Best regards,

Pavel.
