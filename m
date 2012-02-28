From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC PATCH] Inverted internal mic
Date: Tue, 28 Feb 2012 10:54:00 +0100
Message-ID: <4F4CA438.90103@canonical.com>
References: <4F4C9714.1080307@canonical.com> <s5haa43ux7u.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 908B8245D5
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 10:54:09 +0100 (CET)
In-Reply-To: <s5haa43ux7u.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, 903853@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

On 02/28/2012 10:24 AM, Takashi Iwai wrote:
> At Tue, 28 Feb 2012 09:57:56 +0100,
> David Henningsson wrote:
>>
>> Hi,
>>
>> One of the more common problems on laptop machines, is that the internal
>> mic provides a stereo signal but with one channel phase inverted, or
>> differential output.
>>
>> This means problems for applications recording two channels but later
>> merging them into one, leaving them with zero or near-zero output.
>>
>> There are various ways we can work around this in both the kernel,
>> alsa-lib and PulseAudio layers. It's a matter of picking the right one.
>> I'm leaning towards trying to fix it in the kernel's codec drivers, because
>> 1) we already have quirking infrastructure there
>> 2) we already have some working quirks already in that layer
>> 3) it would benefit other sound applications that use ALSA directly.
>>
>> The downside to that is really that we're silencing out one channel for
>> everyone, leading to no application being able to use both channels,
>> even if they would implement some kind of
>> "auto-detect-and-reverse-one-channel" functionality.
>>
>> For the most part, this has been some Acer Aspire machines running
>> Realtek ALC268 / ALC269 / ALC271X / ALC272X, and for two of these we
>> have proc coefs we can set, but for the other two these proc coefs, if
>> they exist, are unknown to us.

A follow-up question here would be if it is easy for you (or Kailang?) 
to figure this out, or if we should resort to the suggest workaround for 
Realtek ALC268 and ALC272X as well?

>> Recently I came across a Conexant as well, and I decided to write a
>> patch for it, that would take the approach that the internal mic is
>> forced mono on the kcontrol, and make sure the right channel is always
>> muted. The patch is verified by the reporter to fix this problem. It
>> could use some perfection though - it would make sense to to the same to
>> the internal mic boost as well, and the strcmp('Internal Mic') call
>> could maybe be turned into something more elegant. But before going
>> ahead with that, I'd like to hear your opinion on the matter, if you
>> agree that this is a good approach to the problem?
>
> The remaining problem in the patch is that the signal is recorded only
> on left when you record in stereo.  I guess the reporter tested only a
> program like Skype, which uses only a mono stream.
>
> If this behavior, only one channel in a stereo stream, is acceptable,
> it's a reasonable fix, I think.

That is indeed a disadvantage, but I don't know if we have something 
better to offer? E g, we could try an alsa-lib ttable solution, but that 
would then have a problem with knowing whether the Internal Mic is 
currently selected or not.

If the program:

- tries to record in mono:
   * As the industry standard for mapping mono is to map it to the left 
channel, I assume this is what ALSA/HDA does in this case as well, so 
unchanged and working behaviour

- record in stereo, then take left channel only:
   * unchanged and working behaviour

- record in stereo, then take right channel only:
   * regression as the inverted channel will now be zero, but this would 
be highly unconventional and unusual, I assume?

- record in stereo, then merge both channels:
   * this is the normal and common case for VoIP applications going 
through PulseAudio (Skype etc). Improvement, this will fix the bug; 
although the result will be -6 dB compared to the original signal.

- record in stereo, keep signal in stereo for playback:
   * this somewhat depends on how the playback is set up, but I would 
say that it would be an improvement in most cases if the speakers are 
relatively close to one another...I guess?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
