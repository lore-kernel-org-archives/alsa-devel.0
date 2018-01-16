From: Martin Peres <martin.peres@free.fr>
Subject: Re: [PATCH] ALSA: usb-audio: Add a quirk for Nura's
 first gen headset
Date: Tue, 16 Jan 2018 15:59:41 +0200
Message-ID: <3766a3f0-5454-732e-bc4a-fe1305521418@free.fr>
References: <20180114160553.15445-1-martin.peres@free.fr>
 <s5hfu772rg4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FC27266A74
 for <alsa-devel@alsa-project.org>; Tue, 16 Jan 2018 14:59:46 +0100 (CET)
In-Reply-To: <s5hfu772rg4.wl-tiwai@suse.de>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 15/01/18 15:15, Takashi Iwai wrote:
> On Sun, 14 Jan 2018 17:05:53 +0100,
> Martin Peres wrote:
>>
>> The capture interface does not work, and the playback interface
>> actually supports only 48kHz unlike what is advertised (44.1, 32, 22,
>> 16, 8).
>>
>> The only unknown here is if there are other devices that use the same
>> product ID, but given that this ID is currently unknown, I would assume
>> it is specially allocated for the nura headset.
>>
>> Signed-off-by: Martin Peres <martin.peres@free.fr>
> 
> Applied, thanks.

Thanks!

Sorry for the second email I sent. I recently switched to another email
sorter, and I redirected the alsa emails to the wrong folder, so I did
not see this email.

Anyway, a colleague has the same problem with his headset, so I guess
he'll be sending a similar patch soon. Maybe pulseaudio should just use
the default sampling rate of USB interfaces if they are all garbage.

Cheers,
Martin
