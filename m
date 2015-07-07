From: Tuukka Pasanen <pasanen.tuukka@gmail.com>
Subject: Re: Rane SL-4 USB sound card
Date: Tue, 07 Jul 2015 08:37:04 +0300
Message-ID: <559B6580.706@gmail.com>
References: <5597A9AE.2090002@gmail.com>
 <55996A35.6030904@ladisch.de>	<559A77B5.5060905@gmail.com>
 <559A7D98.7000707@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
 [209.85.212.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 61DB3261490
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 07:37:04 +0200 (CEST)
Received: by wiwl6 with SMTP id l6so303286047wiw.0
 for <alsa-devel@alsa-project.org>; Mon, 06 Jul 2015 22:37:04 -0700 (PDT)
In-Reply-To: <559A7D98.7000707@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,
I've tested Quirck and it worked (at least channels 1-2 input/output) 
fine when changed S24_LE. Problem is that currently it doesn't have 
Mixer so pulseaudio or jackd can't see it without .asoundrc. I digged 
little bit mixer_map.c but didn't get it working.

Sincerely,
Tuukka

06.07.2015, 16:07, Clemens Ladisch kirjoitti:
> Tuukka Pasanen wrote:
>> [176317.418587] usb 1-5: parse_audio_format_rates_v2(): unable to retrieve number of sample rates (clock 5)
> So it doesn't actually conform with the audio class.
>
>> I figured out this kind of QUIRK which seems to be working (go to test tomorrow more).
> Hmm, the descriptors claim it uses S24_LE ...
>
> Do all channels work?
> Does it correctly switch between 48/96 kHz?
> Is it possible to use different rates for playback/capture?
>
>
> Regards,
> Clemens
