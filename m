From: Oleksij Rempel <bug-track@fisher-privat.net>
Subject: Re: ALSA hda_intel.c:834 spurious response ... ?
Date: Wed, 17 Oct 2012 12:21:26 +0200
Message-ID: <507E86A6.9090703@fisher-privat.net>
References: <507E4EDF.6060003@fisher-privat.net> <s5hobk17gix.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.23])
 by alsa0.perex.cz (Postfix) with SMTP id 47B002651C1
 for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2012 12:21:29 +0200 (CEST)
In-Reply-To: <s5hobk17gix.wl%tiwai@suse.de>
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

Am 17.10.2012 08:35, schrieb Takashi Iwai:
> At Wed, 17 Oct 2012 08:23:27 +0200,
> Oleksij Rempel wrote:
>>
>> Hallo all,
>>
>> i get with latest linus master fallowing messages after resume from
>> suspend to ram:
>> [ 9188.636589] ALSA hda_intel.c:834 spurious response 0x0:0x0, last
>> cmd=0x170500
>> [ 9188.636592] ALSA hda_intel.c:834 spurious response 0x0:0x0, last
>> cmd=0x170500
>> [ 9188.636595] ALSA hda_intel.c:834 spurious response 0x0:0x3, last
>> cmd=0x301f0500
>> [ 9188.636598] ALSA hda_intel.c:834 spurious response 0x0:0x3, last
>> cmd=0x301f0500
>> [ 9188.636601] ALSA hda_intel.c:834 spurious response 0x0:0x3, last
>> cmd=0x301f0500
>> [ 9188.636604] ALSA hda_intel.c:834 spurious response 0x9000094:0x3,
>> last cmd=0x301f0500
>> [ 9188.636606] ALSA hda_intel.c:834 spurious response 0x0:0x3, last
>> cmd=0x301f0500
>>
>>
>> is it some thing you need to know? For more info see attached dmesg.
>
> As long as you don't hear obvious audible regression (e.g. any missing
> output), these should be harmless.  All these are SET_POWER_STATE and
> GET_POWER_STATE verbs, so any problem must appear obviously.
>
> But certainly it makes feel a bit uneasy.  You didn't get this with
> 3.6 kernel, right?

yes, it is new with 3.7.0-rc1.
now i had chance to test sound - it is broken. For example mplayer 
starts to play with supersonic speed, but without sound.
Currently i can't reproduce it. Before i got this error it was several 
time suspended, used headphones, charged... and so on.

-- 
Regards,
Oleksij
