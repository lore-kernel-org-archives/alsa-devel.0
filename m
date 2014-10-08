From: Robin Gareus <robin@gareus.org>
Subject: Re: [WIP PATCH] Scarlett mixer interface for 6i6, 18i6,
 18i8 and 18i20.
Date: Wed, 08 Oct 2014 23:21:54 +0200
Message-ID: <5435AAF2.5040909@gareus.org>
References: <1412694986-2537-1-git-send-email-david.henningsson@canonical.com>
 <54358AA6.7040205@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [81.169.146.163])
 by alsa0.perex.cz (Postfix) with ESMTP id BEB952604CF
 for <alsa-devel@alsa-project.org>; Wed,  8 Oct 2014 23:22:00 +0200 (CEST)
In-Reply-To: <54358AA6.7040205@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, smilingthax@googlemail.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Thanks David for picking this up.

On 10/08/2014 09:04 PM, Daniel Mack wrote:
>> +
>> +/* #define WITH_METER */
>> +/* #define WITH_LOGSCALEMETER */
> 
> These should either be converted to module parameters, or removed
> alltogether. Why are they configurable, anyway?

Mainly because I lost interest in Focusrite devices before finishing the
work. They were handy during initial development and the idea was to
just enable them by default at some point.

Last I checked they both worked fine for the 18i6, but it seems support
other Scarlett devices is missing and/or untested, so I guess they're
commented out for that reason.

> +#define CTL_SWITCH(cmd, off, no, count, name) \
> +	do { \
> +		err = add_new_ctl(mixer, &usb_scarlett_ctl_switch, cmd, off, no, 2,
count, name, NULL, &elem); \
> +		if (err < 0) \
> +			return err; \
> +	} while (0)

curious, why "do { } while (0)" and not just  "{ }" ?

> Hmm, I don't really like the style of magically returning from macros

Yes, same here. I'm initially responsible for one such macro and wanted
to get rid of it. I'm sorry if that lead Tobias to adding more in that
style.

Cheers!
robin
