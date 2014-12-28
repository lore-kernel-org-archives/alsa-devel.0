From: Damien Zammit <damien@zamaudio.com>
Subject: Re: [PATCH 0/2 v7] Digidesign Mbox 1 enhancements
Date: Sun, 28 Dec 2014 19:57:48 +1100
Message-ID: <549FC60C.4020001@zamaudio.com>
References: <1415714995-20669-1-git-send-email-damien@zamaudio.com>
 <s5h389pogp6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
 [209.85.220.47])
 by alsa0.perex.cz (Postfix) with ESMTP id C44A82604FA
 for <alsa-devel@alsa-project.org>; Sun, 28 Dec 2014 09:57:39 +0100 (CET)
Received: by mail-pa0-f47.google.com with SMTP id kq14so15531039pab.6
 for <alsa-devel@alsa-project.org>; Sun, 28 Dec 2014 00:57:38 -0800 (PST)
In-Reply-To: <s5h389pogp6.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Hi,

I am curious to know why this has not yet made it upstream.
Any particular thing we might be waiting for?
Maybe I can help with testing on the hardware?

Damien

On 12/11/14 03:16, Takashi Iwai wrote:
> At Wed, 12 Nov 2014 01:09:53 +1100,
> Damien Zammit wrote:
>>
>> Revision 7.
>>
>> Damien Zammit (2):
>>   ALSA: usb-audio: Add mixer control for Digidesign Mbox 1 clock source
>>   ALSA: usb-audio: Add duplex mode for Digidesign Mbox 1 and enable
>>     mixer
>>
>>  sound/usb/mixer_maps.c   |   9 ++++
>>  sound/usb/mixer_quirks.c | 129 +++++++++++++++++++++++++++++++++++++++++++++++
>>  sound/usb/quirks-table.h |  41 +++++++++++----
>>  3 files changed, 170 insertions(+), 9 deletions(-)
> 
> Thanks, applied now.
> The From address was different from signed-off-by address, so I
> corrected the from address to follow s-o-b.  Please keep consistent at
> the next time.
> 
> BTW, there is one thing missing for the support of this device: the
> mixer resume is likely incomplete.  Currently the mixer resume tries
> to resubmit the cached setups, but it doesn't care about the
> non-standard commands quirks do.  There will be some infrastructure
> change to enhance quirk's capabilities for resume and others in near
> future, and let's fix this issue there.
> 
> 
> Takashi
> 
