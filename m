From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Bug#701498: hda: Internal mic does not work on
 Thinkpad T420s (CX20590 codec)
Date: Mon, 25 Feb 2013 07:16:28 +0100
Message-ID: <512B01BC.2090206@canonical.com>
References: <20130223194257.7554.82839.reportbug@katniss.segie>
 <1361735995.27602.118.camel@deadeye.wl.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 5085526514F
 for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2013 07:16:30 +0100 (CET)
In-Reply-To: <1361735995.27602.118.camel@deadeye.wl.decadent.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: alsa-devel@alsa-project.org, Adrian Lang <debian@adrianlang.de>, 701498@bugs.debian.org
List-Id: alsa-devel@alsa-project.org

On 02/24/2013 08:59 PM, Ben Hutchings wrote:
> On Sat, 2013-02-23 at 20:42 +0100, Adrian Lang wrote:
>> Package: src:linux
>> Version: 3.2.35-2
>> Severity: normal
>>
>> There are two microphones in alsamixer and Gnome 3 audio settings (i. e.,
>> pulseaudio), but I can't get any sound using either of them. I think that's the
>> same problem as reported to [openSUSE] and [Ubuntu].
>>
>> The problem persists with 3.7 (3.7.8-1~experimental.1) from
>> experimental.
>>
>> [openSUSE]
>> http://forums.opensuse.org/english/get-technical-help-here/laptop/469210-opensuse-12-1-cannot-get-internal-mic-work-lenovo-g770-laptop.html
>> [Ubuntu]
>> https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/938644

These are different bugs as they concern different hardware.

> I happen to have a Thinkpad T420 with the same audio codec, and the
> internal mic works fine.  (There does seem to be a problem with external
> mics, now that I check, but let's ignore that for now.)  So this is more
> board-specific, not chip-specific, behaviour.

Ok. For the internal mic, this could be the cancelling out problem; see 
the "Inverted Internal Mic" section of this blog post [1] for more 
information.

...as these bugs can sometimes be very specific - when the factory 
finally assembles the laptop, they might select a different component 
just for the DMIC, that has this problem.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

[1] 
http://voices.canonical.com/david.henningsson/2012/05/22/three-audio-bugs-in-12-04/
