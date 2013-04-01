From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: [PATCH 10/10] ALSA: usb-audio: UAC2: support
 read-only freq control
Date: Tue, 2 Apr 2013 00:45:33 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1304020036440.1220@xoschi>
References: <1364745152-1762-1-git-send-email-eldad@fogrefinery.com>
 <1364745152-1762-11-git-send-email-eldad@fogrefinery.com>
 <20130401081721.GI18838@pvv.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f50.google.com (mail-bk0-f50.google.com
 [209.85.214.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 8936D264FFF
 for <alsa-devel@alsa-project.org>; Tue,  2 Apr 2013 00:45:35 +0200 (CEST)
Received: by mail-bk0-f50.google.com with SMTP id jg1so1101770bkc.9
 for <alsa-devel@alsa-project.org>; Mon, 01 Apr 2013 15:45:35 -0700 (PDT)
In-Reply-To: <20130401081721.GI18838@pvv.ntnu.no>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Torstein Hegge <hegge@resisty.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org


Hi Torstein,

On Mon, 1 Apr 2013, Torstein Hegge wrote:

> On Sun, Mar 31, 2013 at 17:52:32 +0200, Eldad Zack wrote:
> > Some clocks might be read-only, e.g., external clocks (see also
> > UAC2 4.7.2.1).
> > 
> > In this case, setting the sample frequency will always fail
> > (even if the rate is equal to the current clock rate),
> > therefore do not write, but read the value and compare to the
> > requested rate.
> > 
> > If it doesn't match, return -ENXIO since the clock is invalid for
> > this configuration.
> 
> I think could be more readable if it was built on top of [1]. Then it
> could check the target rate against the prev_rate reported by the device
> and return before the sample rate set, something like:

Thanks, I think it's a good idea. I'll wait with this patch until you 
get your change to Takashi's tree to save some work for everyone.

> @@ -279,6 +275,20 @@ static int set_sample_rate_v2(struct snd_usb_audio *chip, int iface,
>  		prev_rate = data[0] | (data[1] << 8) | (data[2] << 16) | (data[3] << 24);

You might also want to convert this into le32_to_cpu, etc. like in 
patch #5 of this series -- note that as Clemens said, the type should 
should be __le32 (and not u32).

http://mailman.alsa-project.org/pipermail/alsa-devel/2013-March/060738.html

Thanks for pointing out the formatting issues, I'll fix these before 
reposting.

Cheers,
Eldad
