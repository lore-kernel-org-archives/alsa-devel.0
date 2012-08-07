From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Plumbers: Please split audio topics into separate
	sessions
Date: Tue, 07 Aug 2012 13:26:37 +0200
Message-ID: <5020FB6D.6000503@canonical.com>
References: <50201664.7000804@canonical.com> <s5hwr1bizuj.wl%tiwai@suse.de>
 <50202500.5060607@canonical.com>
 <20120806222417.GF26698@opensource.wolfsonmicro.com>
 <s5htxwfi6pb.wl%tiwai@suse.de> <5020B8AF.3090003@canonical.com>
 <s5hhasfi3b4.wl%tiwai@suse.de> <5020CD16.6020705@canonical.com>
 <20120807111519.GY16861@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id DCCF726501A
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 12:56:51 +0200 (CEST)
In-Reply-To: <20120807111519.GY16861@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 08/07/2012 01:15 PM, Mark Brown wrote:
> On Tue, Aug 07, 2012 at 10:08:54AM +0200, David Henningsson wrote:
>
>> When shutting down, both PulseAudio and alsactl saves volumes to
>> restore them later. And then we also have suspend and hibernate to
>> consider, and that cards can be plugged in at any time.
>
>> This is mostly a problem statement. I don't have a good proposal for
>> how to simplify it.
>
> Isn't this a fairly simple Pulse/distro issue?

PulseAudio - no, because PulseAudio does not control *all* volumes. 
They're partially overlapping, but not completely.

Distro - well, a distro can do anything they/we want, but 
recommendations from upstream will reduce confusion and risk for distros 
being bonked by upstream with the "you're doing it wrong, stupid!" message.

> It seems like alsactl is
> redundant for most distros now so they could just disable it by default
> meaning we just have to worry about the DM/user Pulse handover.

That could be a way forward worth discussing at the session, but that's 
not the way it works now.

> For
> that I guess if Pulse does something the distros would be happy to just
> follow that?

Not all distros use PulseAudio either, but maybe that's beyond the scope 
of the actual discussion.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
