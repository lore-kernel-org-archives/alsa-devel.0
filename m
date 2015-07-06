From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Rane SL-4 USB sound card
Date: Mon, 06 Jul 2015 15:07:36 +0200
Message-ID: <559A7D98.7000707@ladisch.de>
References: <5597A9AE.2090002@gmail.com> <55996A35.6030904@ladisch.de>
 <559A77B5.5060905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 5F3092605C7
 for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2015 15:07:45 +0200 (CEST)
In-Reply-To: <559A77B5.5060905@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tuukka Pasanen <pasanen.tuukka@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Tuukka Pasanen wrote:
> [176317.418587] usb 1-5: parse_audio_format_rates_v2(): unable to retrieve number of sample rates (clock 5)

So it doesn't actually conform with the audio class.

> I figured out this kind of QUIRK which seems to be working (go to test tomorrow more).

Hmm, the descriptors claim it uses S24_LE ...

Do all channels work?
Does it correctly switch between 48/96 kHz?
Is it possible to use different rates for playback/capture?


Regards,
Clemens
