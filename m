From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 42/44] bebob/firewire-lib: Add a quirk of
 wrong dbc in empty packet for M-Audio special Firewire series
Date: Mon, 24 Mar 2014 11:52:35 +0900
Message-ID: <532F9DF3.9020802@sakamocchi.jp>
References: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
 <1395400229-22957-43-git-send-email-o-takashi@sakamocchi.jp>
 <532E441A.7060302@sakamocchi.jp>
 <ebf27c28-64aa-4f13-8e6e-4112c6bb79e9@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B7012615EC
 for <alsa-devel@alsa-project.org>; Mon, 24 Mar 2014 03:52:41 +0100 (CET)
In-Reply-To: <ebf27c28-64aa-4f13-8e6e-4112c6bb79e9@email.android.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Euan de Kock <euan@dekock.net>, clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Euan,

Thanks for your testing.

(Mar 24 2014 10:41), Euan de Kock wrote:
> Thanks for the update. This bit me last night, and I just commented out
> the check to keep working.
>
> I'll try and retest it tonight with this version. (On a Echo Audiofire
> Pre8 with firmware < 5)
>
> Regards,
>
> Euan deKock.

When reading this message, I wondered why this bug affects driving on 
Echo AudioFirePre8.
As describing the title, this affects a part of BeBoB based devices.

Did you test with M-Audio Firewire 1814 or M-Audio ProjectMix I/O?

If not, it may be a bug for Fireworks driver. Then please send me output 
from:
/proc/asound/cardX/firewire/*. (The 'cardX' should be for your device.)


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp
