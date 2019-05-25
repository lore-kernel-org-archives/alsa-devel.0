From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: arecord doesnt record into file
Date: Sat, 25 May 2019 07:39:08 +0200
Message-ID: <615dcc2e-93fc-dab0-2480-a651a4a5312b@ladisch.de>
References: <83B5A2EBEFF68E46AB106DA39CB25921010ED695@IN01WEMBXA.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [IPv6:2a01:4f8:212:88::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1E2B5F80C0F
 for <alsa-devel@alsa-project.org>; Sat, 25 May 2019 07:39:55 +0200 (CEST)
Received: from olorin.ladisch.de (x2f7fa47.dyn.telefonica.de [2.247.250.71])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id 3C9755583AC8
 for <alsa-devel@alsa-project.org>; Sat, 25 May 2019 07:39:54 +0200 (CEST)
In-Reply-To: <83B5A2EBEFF68E46AB106DA39CB25921010ED695@IN01WEMBXA.internal.synopsys.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Aditya Paluri wrote:
> arecord --device plughw:0,2 -r 48000 -f S16_LE -c 2 recorded_sound.wav
>
> And as I see the audio stream getting dumped onto the DRAM/memory, I donot see recorded_sound.wav contain any data on the file system.
> I also see EPIPE error due to overrun.

This is likely to be a bug in the driver (snd_pcm_period_elapsed() does not get called).


Regards,
Clemens
