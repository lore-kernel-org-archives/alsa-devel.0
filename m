From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Plumbers: Please split audio topics into separate
 sessions
Date: Tue, 07 Aug 2012 13:19:46 +0200
Message-ID: <5020F9D2.3090902@canonical.com>
References: <50201664.7000804@canonical.com> <s5hwr1bizuj.wl%tiwai@suse.de>
 <50202500.5060607@canonical.com>
 <20120806222417.GF26698@opensource.wolfsonmicro.com>
 <s5htxwfi6pb.wl%tiwai@suse.de> <5020B8AF.3090003@canonical.com>
 <s5hhasfi3b4.wl%tiwai@suse.de> <5020CD16.6020705@canonical.com>
 <s5hy5lrgkvx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id AA58626501A
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 12:50:00 +0200 (CEST)
In-Reply-To: <s5hy5lrgkvx.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 08/07/2012 10:35 AM, Takashi Iwai wrote:
>> New topic suggestion:
>>
>> Simplifying volume setting on startup/shutdown
>> ====================
>> Currently, on a normal desktop session, volume is set four times on
>> startup - initally by the kernel, then by alsactl, then by PulseAudio in
>> the DM session, then by PulseAudio in the logged in session.
>>
>> When shutting down, both PulseAudio and alsactl saves volumes to restore
>> them later. And then we also have suspend and hibernate to consider, and
>> that cards can be plugged in at any time.
>>
>> First, isn't this quite complex for something as simple as setting
>> volumes? Second, can we facilitate new features, such as 1) having a
>> "set this volume as default, for all users, on startup" button in the
>> volume control, or 2) "allow the DM user to introspect different users'
>> volumes"?
>> ===================
>>
>> This is mostly a problem statement. I don't have a good proposal for how
>> to simplify it.
>
> OK, could you create a blueprint with that content?
> Then I'll inform plumbers committee about the addition as another
> (5th) slot at first.  Then we can rearrange topics in 5 slots.

Ok, new blueprint added as 
https://blueprints.launchpad.net/lpc/+spec/lpc2012-audio-simplify-volumes


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
