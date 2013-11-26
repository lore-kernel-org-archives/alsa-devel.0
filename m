From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 02/17] firewire-lib: Add macros instead of
 fixed value for AMDTP
Date: Tue, 26 Nov 2013 18:50:08 +0900
Message-ID: <52946ED0.8090203@sakamocchi.jp>
References: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
 <1385186884-8259-3-git-send-email-o-takashi@sakamocchi.jp>
 <52936C44.7070606@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F629260844
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 10:50:12 +0100 (CET)
In-Reply-To: <52936C44.7070606@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

(Nov 26 2013 00:27), Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> This patch adds some macros instead of fixed value for AMDTP in IEC 61883-6.
>> These macros will also be used by followed patches.
>
>> +++ b/sound/firewire/amdtp.c
>
>> +/*
>> + * Audio and Music transfer protocol specific parameters
>> + * only "Clock-based rate controll mode" is supported
>                               ^^^^^^^^
>                               control

OK. It's my typo.

>> -		return 0xffff; /* no info */
>> +		return CIP_SYT_NO_INFO; /* no info */
>
> The comment is now superfluous.

Oops. I forget to remove it when I applied git-rebase to include my 
patch about empty packet...

Thank you.


Takashi Sakamoto
o-takashi@sakamocchi.jp
