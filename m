From: Tuukka Pasanen <pasanen.tuukka@gmail.com>
Subject: Re: Rane SL-4 USB sound card
Date: Tue, 07 Jul 2015 10:59:13 +0300
Message-ID: <559B86D1.1020401@gmail.com>
References: <5597A9AE.2090002@gmail.com>	<55996A35.6030904@ladisch.de>	<559A77B5.5060905@gmail.com>	<559A7D98.7000707@ladisch.de>	<559B6580.706@gmail.com>
 <559B7E78.3080906@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f54.google.com (mail-wg0-f54.google.com [74.125.82.54])
 by alsa0.perex.cz (Postfix) with ESMTP id E9B6A261490
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 09:59:12 +0200 (CEST)
Received: by wgck11 with SMTP id k11so160332411wgc.0
 for <alsa-devel@alsa-project.org>; Tue, 07 Jul 2015 00:59:12 -0700 (PDT)
In-Reply-To: <559B7E78.3080906@ladisch.de>
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
No it doesn't. Hmm... I got to examine this more because even Yast2 cant 
see this or alsaconf..

Tuukka

07.07.2015, 10:23, Clemens Ladisch kirjoitti:
> Tuukka Pasanen wrote:
>> I've tested Quirck and it worked (at least channels 1-2 input/output) fine when changed S24_LE.
>> Problem is that currently it doesn't have Mixer
> According to the descriptors, it does not have mixer controls.
> Does the Windows driver have mixer controls that affect the hardware?
>
>> so pulseaudio or jackd can't see it without .asoundrc.
> That should make no difference.
>
>
> Regards,
> Clemens
