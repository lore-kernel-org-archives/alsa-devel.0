From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: Master Plan on rewinding
Date: Tue, 09 Sep 2014 21:55:05 +0600
Message-ID: <540F22D9.8010203@gmail.com>
References: <540C76E0.9050808@gmail.com>	<540CC53B.7080204@ladisch.de>	<540D5B46.3020904@gmail.com>	<540EBD9A.9000009@ladisch.de>	<540EC08E.4000906@gmail.com>
 <540F047F.7090607@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f46.google.com (mail-la0-f46.google.com
 [209.85.215.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F6C926524C
 for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2014 17:55:08 +0200 (CEST)
Received: by mail-la0-f46.google.com with SMTP id pv20so19609414lab.5
 for <alsa-devel@alsa-project.org>; Tue, 09 Sep 2014 08:55:08 -0700 (PDT)
In-Reply-To: <540F047F.7090607@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, David Henningsson <david.henningsson@canonical.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

09.09.2014 19:45, Clemens Ladisch wrote:
> Alexander E. Patrakov wrote:
>> can the proposed heuristic (minimum period size for a given sample
>> rate, number of channels and sample format) be useful as an upper-
>> bound approximation of the pointer update granularity for cards that
>> are "rewindable even further than the nearest period"?
>
> No; USB precsion depends on the URB size, which is roughly proportional
> to (but smaller than) the period size.

Thanks for the explanation. It was very useful.

At this point, I am tempted to not express this "less than the period 
size but depends on it" rule, and classify USB audio devices as 
"Rewindable down to the period size", even though it is a pessimization.

Also (sorry for the off-topic) this explanation completely crystallizes 
my opinion about possible misuse of the SNDRV_PCM_INFO_BATCH flag in the 
snd-usb-audio driver or PulseAudio. My opinion now is: there is no 
misuse on either side.

-- 
Alexander E. Patrakov
