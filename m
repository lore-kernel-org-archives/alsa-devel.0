From: Panu Matilainen <pmatilai@laiskiainen.org>
Subject: Re: [PATCH] ALSA: usb: Add support for Zoom R16/24
 capture and midi interfaces
Date: Sun, 30 Nov 2014 12:08:38 +0200
Message-ID: <547AECA6.6080209@laiskiainen.org>
References: <1417289704-23774-1-git-send-email-pmatilai@laiskiainen.org>
 <s5ha939bxu4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from homiemail-a50.g.dreamhost.com (sub5.mail.dreamhost.com
 [208.113.200.129])
 by alsa0.perex.cz (Postfix) with ESMTP id 0922D2605C8
 for <alsa-devel@alsa-project.org>; Sun, 30 Nov 2014 11:08:46 +0100 (CET)
In-Reply-To: <s5ha939bxu4.wl-tiwai@suse.de>
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

On 11/29/2014 09:39 PM, Takashi Iwai wrote:
> At Sat, 29 Nov 2014 21:35:04 +0200,
> Panu Matilainen wrote:
>>
>> This makes the midi interface and capture work out of the box with
>> R16 (and presumably R24 too but untested). Playback stream would also
>> seem to function fine except for one caveat: no sound is produced,
>> so it is disabled for now.
>
> Could you give more comments in the playback iface why it's disabled?
> Ditto for ifnum=0.

Sure, I'll post an updated patch with added comments.

In the meanwhile I started looking at the mixer - this is just guessing 
but maybe its starting with outputs muted which could explain the 
playback stream running but without sound.

The descriptors for interface 0 are garbage but what is there would seem 
to map to logical elements by subtype and terminaltype, after those the 
data doesn't seem to add up (eg number of input/output channels 
missing/wrongly placed etc):

** UNRECOGNIZED:  0b 24 01 00 01 35 00 03 01 02 03
    -> Header?
** UNRECOGNIZED:  0c 24 02 05 01 01 00 02 03 00 00 00
    -> USB streaming input terminal?
** UNRECOGNIZED:  09 24 03 08 01 03 00 05 00
    -> Speaker output terminal?
** UNRECOGNIZED:  0c 24 02 09 01 02 00 08 00 00 00 00
    -> Microphone input terminal?
** UNRECOGNIZED:  09 24 03 0c 01 01 00 09 00
    -> USB streaming output terminal?

Anything there that might ring a bell, or other ideas where to start 
poking at this thing?

FWIW there are other unrecognized descriptors too but those are 
associated with the other interfaces, which I guess I can ignore for now...

	- Panu -
