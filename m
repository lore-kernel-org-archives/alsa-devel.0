From: Massimo Del Fedele <max@veneto.com>
Subject: Re: Fix for Asus G75 notebook subwoofer
Date: Tue, 06 Nov 2012 09:57:31 +0100
Message-ID: <k7ajdq$42u$1@ger.gmane.org>
References: <k6rkr2$usv$1@ger.gmane.org> <s5hy5ifgmbq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id C4A5726523F
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2012 09:57:42 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1TVeyk-0007bS-3X
 for alsa-devel@alsa-project.org; Tue, 06 Nov 2012 09:57:50 +0100
Received: from host118-251-dynamic.0-87-r.retail.telecomitalia.it
 ([87.0.251.118]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Tue, 06 Nov 2012 09:57:50 +0100
Received: from max by host118-251-dynamic.0-87-r.retail.telecomitalia.it with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Tue, 06 Nov 2012 09:57:50 +0100
In-Reply-To: <s5hy5ifgmbq.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Il 06/11/2012 09:36, Takashi Iwai ha scritto:
> At Wed, 31 Oct 2012 17:49:39 +0100,
> Massimo Del Fedele wrote:
>>

>
> You meant 0x3e instead of 0x1e in the comment above, right?

Yep, sorry, it was 0x3e of course
>
>
> Other than that, the default pin configurations could be easily
> implemented via fixups.  Take a look at patch_conexant.c.

thank you, I'll look at it. Is it possible to "connect" the fixups to the
asus g75 ?
>
> In anyway, it'd be helpful if you can attach the alsa-info.sh output
> on your machine.  Even better would be results before and after the
> patch.
>
The unpatched info is already on bug report :

https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1045981
(comment #7)

I'll add the patched one now.

BTW, did you see the above patch (error in via_auto_fill_dac_nids) ?
My patch isn't correct either (fails when the 'continue' path is taken)
but it's better than now. I guess that code should be rewritten, it's
quite weird in respect to dac numbering.
>
> thanks,
>
> Takashi
>

Thank you

Massimo
