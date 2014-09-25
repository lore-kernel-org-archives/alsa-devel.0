From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Get sound card available channels
Date: Thu, 25 Sep 2014 10:49:38 +0200
Message-ID: <5423D722.6050305@ladisch.de>
References: <CA+BmFj2fTUFYKoWnae=pV7oraRPg1YkVTKyh=jqAM+A0fbz54Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 00DF82608C7
 for <alsa-devel@alsa-project.org>; Thu, 25 Sep 2014 10:49:38 +0200 (CEST)
In-Reply-To: <CA+BmFj2fTUFYKoWnae=pV7oraRPg1YkVTKyh=jqAM+A0fbz54Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Hordern <dh.mailing.lists@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dan Hordern wrote:
> We have a need for our process to poll/monitor the sound cards.

Something like libudev would help with monitoring /dev/snd/controlC*
devices.

> This process needs to provide a unique id for the sound card (e.g.
> some concat of name+hardware address) which we can get using snd_ctl_t
> handle.

snd_ctl_card_info_get_id()

> However, we also need to provide the number or rx/tx channels each sound
> card provides. Doing this using the pcm hw_params after snd_pcm_open won't
> work as the device may be in use.
>
> Is there a way for this process to get the number of rx/tx channels without
> needing to 'open' the device, e.g. using the snd_ctl_t handle?

No.  The number of channels might depend on the current configuration
and on other resources.

What do you need these numbers for?


Regards,
Clemens
