From: VDR User <user.vdr@gmail.com>
Subject: Re: How is /proc/asound/cardX/eld#Y.Z generated?
Date: Mon, 12 Oct 2015 10:57:08 -0700
Message-ID: <CAA7C2qgQQ+6QJpgeZxd5xfgMXRMizL9t72Aw3My2GNn0N3xREA@mail.gmail.com>
References: <CAA7C2qgKYOubj737m0eAkVew9PqS-UKg0MQgxSGebxVfgHboHg@mail.gmail.com>
 <s5hoag4lbr7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f180.google.com (mail-io0-f180.google.com
 [209.85.223.180])
 by alsa0.perex.cz (Postfix) with ESMTP id B79B4264F3F
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2015 19:57:09 +0200 (CEST)
Received: by iodv82 with SMTP id v82so58084025iod.0
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2015 10:57:08 -0700 (PDT)
In-Reply-To: <s5hoag4lbr7.wl-tiwai@suse.de>
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
Cc: "mailing list: alsa-dev" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>> Hi. I was wondering if someone can tell me how exactly the eld files
>> are generated.
>
> It's just showing the data passed.  Usually the graphics driver sets
> ELD, and the hardware receives and transfers to the audio part.
>
>> Additionally, if they can be overridden somehow.
>
> No, there is no such a mechanism.
>
>> The
>> reason is if I start x while my tv is turned on, the eld reports only
>> stereo audio capability for hdmi even though the tv is plugged into my
>> surround receiver. I don't care what the tv reports, my surround
>> receiver is 7.1 so I always want the eld to reflect my -actual- audio
>> channel setup.
>
> As mentioned, this is the information coming from the graphics side,
> so the place to manage is rather the graphics driver.

Thanks for your reply Takashi, and for pointing me in the right
direction. Hopefully there's an override for this on the graphics
driver side.
