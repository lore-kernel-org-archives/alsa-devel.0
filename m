From: tdavis@dsl-only.net
Subject: Re: Some functionality of ice1724 broken
	between	1.0.14.RC1 and 1.0.14.RC3
Date: Fri, 13 Jul 2007 08:53:47 -0700
Message-ID: <20070713085347.7s91ngaabjk048ww@webmail.dsl-only.net>
References: <20070713062326.22e05830@localhost.localdomain>
	<s5hejjczavr.wl%tiwai@suse.de>
	<20070713080750.5ae2d2cb@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 4970A10382C
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jul 2007 17:53:54 +0200 (CEST)
In-Reply-To: <20070713080750.5ae2d2cb@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: stan <stanl@cox.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

For RPM based systems, I have a build environment for the drivers,  
libs, and utils packages at  
http://members.dsl-only.net/~tdavis/my-build.tar.bz2.  You need to be  
root to build them, but they won't interfere with your rpm  
distribution.  THe driver rpm will also make a backup of your current  
drivers prior to installation.

Tobin

Quoting stan <stanl@cox.net>:

> On Fri, 13 Jul 2007 15:33:28 +0200
> Takashi Iwai <tiwai@suse.de> wrote:
>
>> At Fri, 13 Jul 2007 06:23:26 -0700,
>> stan wrote:
>> >
> [snip]
>>
>> Could you check whether the same problem still exists on 1.0.14 final?
>> There are tons of changes since rc3, so debugging rc3 is just a waste
>> of time.
>
> Darn!  I was hoping you would just look at it and know the problem. :-)
>
> How would I go about that?  Is there a document somewhere that
> describes the process?  I've downloaded the lib, drivers, utils, and
> tools for 1.0.14.final.  I'll compile all of them.
> If I install to /usr/local/, will it work?  I'm concerned about
> breaking the packaging system / the system.
> Do I modprobe the new kernel module from my own
> build? It's been a while since I messed with such things.  I usually
> install applications outside the package management system, not base
> components like alsa.  Hand holding would be nice but if you just point
> me towards some documentation that would be enough, or even describe
> the outline of the process and I can use search to find documentation.
>
> [snip]
>>
>> No, consts shouldn't matter.  (BTW, please use diff -up option at the
>> next time.  That'll make it way easier to read a patch.)
>
> Done and attached below.
>
> I am working on the rest of your requests and will send it along
> later.
>>
>> > 2.
>> >
>> > I ran a frequency loudness test that is part of the app.  It drops
>> > the frequency at 5 seconds intervals from 20 KHz to 5 Hz
>> > alternating.  On Fedora 6 with 1.0.14.RC1 it works as expected.
>> > When above my hearing range I hear silence.  When it gets to
>> > frequencies I can hear the sound is pure.  On Fedora 7, this same
>> > app produces noise at frequencies I can't hear.  This behavior is
>> > the same as the behavior I noticed with my emu10k1, ca0106 and CK8S
>> > sound cards on 1.0.14.RC1 as well as 1.0.14.RC3.  I previously had
>> > ascribed this to bad/low quality sound chips; now I'm not so sure.
>> > In terms of sound quality the Rev 5.1 ranks well.  See the link
>> >
>> > http://compreviews.about.com/od/multimedia/tp/SoundCards.htm
>> >
>> > Exact same hardware produces different sound.  Can't explain it.
>> > Can you?  Can you fix it?
>>
>> Might be alsa-lib dmix issue now used as default PCM?  Which PCM
>> configuration are you using?  Does the problem exist even if you use
>> "hw" (or "plughw") PCM explicitly?
>
> I am using default, if I understand what you are asking.  I will set it
> to use plughw:0,0 and try.
>>
>>
>> > 3.
>> >
>> > While looking at the ice1724.c code I noticed that the maximum
>> > buffer size is 2**18.  This seems small for an application today.
>> > I'm producing sound at 192000 frames per second (admittedly overkill
>> > though I like very smooth sound) using stereo doubles (16 bytes per
>> > frame). The maximum buffer size is only a fraction of my per second
>> > byte rate.
>> >
>> > Could you increase this?
>>
>> Ditto.
>>
> That seems to have done the trick for both issues.  You did answer it
> off the top of your head.  :-)
>
> Minimum channels (1)
> Maximum channels (10000)
> Minimum rate (4000)  Direction = 0
> Maximum rate (4294967295)  Direction = -1
> Rate (48000)  Direction = -1 Result = 0
> Rate (96000)  Direction = -1 Result = 0
> Rate (192000)  Direction = -1 Result = 0
> Rate (384000)  Direction = -1 Result = 0
> Minimum period_time (10)  Direction = 1
> Maximum period_time (2048000)  Direction = 0
> Minimum period_size (0)  Direction = 1
> Maximum period_size (4294967295)  Direction = -1
> Minimum periods (0)  Direction = 1
> Maximum periods (4294967295)  Direction = 0
> Minimum buffer_time (1)  Direction = 0
> Maximum buffer_time (4294967295)  Direction = 0
> Minimum buffer_size (1)
> Maximum buffer_size (4294967294)
> Minimum tick_time (1000)  Direction = 0
> Maximum tick_time (1000)  Direction = 0
> Actual rate (192000)  Direction = 0
> Actual channels (2)
> Actual buffer_time (170666)  Direction = 1
> Actual buffer_size (32768)
> Actual buffer_size (32768)
> Actual period_time (85333)  Direction = 1
> Actual period_size (16384)  Direction = 0
> Actual periods (2)  Direction = 0
> Actual rate (192000)  Direction = 0
> Actual channels (2)
> Actual periods (2)  Direction = 0
> Actual period_size (16384)  Direction = 0
> Actual buffer_size (32768)
>
> What would be the effect of using plughw:0,0 instead of default on an
> average system?  Would a user have any control over which sound card
> plays the sound?  Or, to rephrase, with default if a user changes the
> default then the sound card playing changes, with plughw:0,0 the user
> is locked into the first card, true?
>
> Let me know if you still want me to test 14 final, though it seems
> redundant now.
>
>  Thanks for your help.
