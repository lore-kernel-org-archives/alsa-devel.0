From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: need help for PCM constraint/rules
Date: Wed, 27 Mar 2013 01:58:29 +0900
Message-ID: <5151D3B5.50301@sakamocchi.jp>
References: <514F0696.1030109@sakamocchi.jp> <514F5010.5000707@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CB1C2650F9
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2013 17:58:35 +0100 (CET)
In-Reply-To: <514F5010.5000707@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens,

Thank you for your advice. The PCM rules in your Dice module also 
matches Fireworks. I apply your solution into my Fireworks module and my 
target device seems to work correctly in any sampling rate.

On this occasion, I have a question to you about your 
firewire-kernel-streaming branch in alsa-kprivate.git. There is no 
commit since last year and I'm anxious about the reason. If it's due to 
your personal, there is no matter (of cource!). But it's due to some 
technical issues or strategies against FFADO project, there is a large 
possibility that I may soon face them. If it's the latter, would you 
please inform me the details?

Regards


Takashi Sakamoto
o-takashi@sakamocchi.jp

Now my Fireworks module can playback PCM stream in any sampling rates.
(Mar 25 2013 04:12), Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> My device (AudioFirePre8) changes its channels according to sampling rate. For example:
>> 32.0  - 48.0kHz  : 16ch: efw->channels_sets[0]
>> 88.2  - 96.0kHz     : 12ch: efw->channels_sets[1]
>> 176.4 - 192.0kHz : 10ch: efw->channels_sets[2] (but not available)
>>
>> I managed to write this rule refering to rme9652.c but I cannot achieve my purpose.
>
> These functions should be essentially identical with dice_*_constraint().
>
>
> Regards,
> Clemens
