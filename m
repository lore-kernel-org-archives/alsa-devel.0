From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Linux 4.2 ALSA snd-usb-audio inconsistent lock
	state	warn in PCM nonatomic mode
Date: Tue, 01 Sep 2015 19:53:41 +0200
Message-ID: <55E5E625.5010403@ladisch.de>
References: <55E4D9BE.2040308@osg.samsung.com> <55E564ED.4050609@ladisch.de>
 <55E5E31F.6040802@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 40DEE261609
 for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2015 19:54:37 +0200 (CEST)
In-Reply-To: <55E5E31F.6040802@osg.samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: alsa-devel@alsa-project.org, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Shuah Khan wrote:> On 09/01/2015 02:42 AM, Clemens Ladisch wrote:
>> Shuah Khan wrote:
>>> +++ b/sound/usb/stream.c
>>> pcm->private_data = as;
>>> pcm->private_free = snd_usb_audio_pcm_free;
>>> pcm->info_flags = 0;
>>> + pcm->nonatomic = true;
>>
>> Why do you think you need nonatomic mode in the USB audio driver?
>
> I have been working on adding Media Controller support for this chip
> as chip specific feature in ALSA. This will allow sharing resources
> such as the tuner across the drivers that control the device (DVB,
> Video, snd-usb-audio). Media Controller framework uses a mutex to
> protect access to resources, hence there is a need to hold this mutex
> from SNDRV_PCM_TRIGGER_START and SNDRV_PCM_TRIGGER_STOP which could run
> in IRQ context.

Resources should be managed in the hw_params/hw_free callbacks.


Regards,
Clemens
