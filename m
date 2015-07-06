From: Tuukka Pasanen <pasanen.tuukka@gmail.com>
Subject: Re: Rane SL-4 USB sound card
Date: Mon, 06 Jul 2015 16:39:53 +0300
Message-ID: <559A8529.9070500@gmail.com>
References: <5597A9AE.2090002@gmail.com>
 <55996A35.6030904@ladisch.de>	<559A77B5.5060905@gmail.com>
 <559A7D98.7000707@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f45.google.com (mail-wg0-f45.google.com [74.125.82.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EA1A26154F
 for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2015 15:39:53 +0200 (CEST)
Received: by wgck11 with SMTP id k11so140711328wgc.0
 for <alsa-devel@alsa-project.org>; Mon, 06 Jul 2015 06:39:53 -0700 (PDT)
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
Thank you that 24_LE. I'll test tommorrow and find answers to there 
questions. I'll think that 48/96 won't work because it seems to be 
behind that HID.. but that this after I get sound out and in.

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
