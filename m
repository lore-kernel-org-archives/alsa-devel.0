From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Kernel 3.2,
 and "speaker" controlling headphone path
Date: Mon, 16 Jul 2012 11:37:41 +0200
Message-ID: <5003E0E5.8080007@canonical.com>
References: <4FFD5A6C.1060401@canonical.com> <s5hmx30gie5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id B9D672434E
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jul 2012 11:37:41 +0200 (CEST)
In-Reply-To: <s5hmx30gie5.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Herton Ronaldo Krzesinski <herton.krzesinski@canonical.com>
List-Id: alsa-devel@alsa-project.org

On 07/16/2012 11:33 AM, Takashi Iwai wrote:
> At Wed, 11 Jul 2012 12:50:20 +0200,
> David Henningsson wrote:
>>
>> It seems like on one machine the "Speaker Playback Volume" was part of
>> the headphone path, in combination with PulseAudio this is leading to
>> muted headphones.
>>
>> One of my colleagues wrote a workaround for that specific machine - I'm
>> providing links in case you're interested:
>>
>> The patch:
>> https://launchpadlibrarian.net/109499922/restrict_bass.patch
>>
>> Alsa-info:
>> https://launchpadlibrarian.net/109251353/bad-kernel-yes-headphones.txt
>>
>> Bug link:
>> https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/994685
>
> This doesn't happen with the recent kernel, right?
>
> As far as I've tested with hda-emu, 3.6 kernel picks up the headphone
> path as the primary, as this has the least badness value.

Correct. The issue was not present on 3.0 and 3.4. It was present in 3.2 
and 3.3, and fixed with commit 1c4a54b4513c175ba (ALSA: hda/realtek - 
Finer tuning of auto-parser with badness evaluation), but that commit 
felt to risky to just backport/apply to 3.2.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
