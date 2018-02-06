From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Adding support for CMEDIA USB2.0 High-Speed True
 HD Audio
Date: Tue, 6 Feb 2018 10:33:20 +0100
Message-ID: <dea3694c-64aa-29b3-a2a1-2c104a44e596@ladisch.de>
References: <CAOuaOFuAa0jd9ZAENcnaJci1JmCw+dzAwQqT9bhv2t=i=ndWSA@mail.gmail.com>
 <CAOuaOFshdK1ZsXrJhC340yR=v4PMspq-G_B=9DxM4dEnfTk_vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.184])
 by alsa0.perex.cz (Postfix) with ESMTP id A8E7726722C
 for <alsa-devel@alsa-project.org>; Tue,  6 Feb 2018 10:30:24 +0100 (CET)
Received: from [10.1.2.4] (unknown [94.101.37.79])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id 055005580804
 for <alsa-devel@alsa-project.org>; Tue,  6 Feb 2018 10:30:22 +0100 (CET)
In-Reply-To: <CAOuaOFshdK1ZsXrJhC340yR=v4PMspq-G_B=9DxM4dEnfTk_vg@mail.gmail.com>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

(please don't top-post)

Jean-Philippe Guillemin wrote:
> # aplay -l
> card 0: Audio [USB2.0 High-Speed True HD Audio], device 0: USB Audio [USB Audio]
> card 0: Audio [USB2.0 High-Speed True HD Audio], device 1: USB Audio [USB Audio #1]
> card 0: Audio [USB2.0 High-Speed True HD Audio], device 2: USB Audio [USB Audio #2]

So "aplay -D plughw:0,2 something.wav" works correctly?

>> I'm trying to create a mapping in USB-Audio.conf :
>>  # If a device does not use the first PCM device for digital data, the device
>>   # number for the iec958 device can be changed here.
>>   USB-Audio.pcm.iec958_device {
>>      # "NoiseBlaster 3000" 42
>>      "USB Sound Blaster HD" 1
>>      "USB2.0 High-Speed True HD Audio" 2
>>   ...
>>
>> But I never got a match on "USB2.0 High-Speed True HD Audio".

What exactly happens when you try "aplay -D iec958 something.wav"?


Regards,
Clemens
