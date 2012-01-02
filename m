From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] hda_intel: Add Oaktrail identifiers
Date: Mon, 02 Jan 2012 21:17:18 +0100
Message-ID: <4F0210CE.1020007@canonical.com>
References: <20111228151715.2032.87840.stgit@bob.linux.org.uk>
	<s5hzke8n0o6.wl%tiwai@suse.de>
	<20111231170001.22cdabdd@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id DE95F103951
	for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2012 21:17:22 +0100 (CET)
In-Reply-To: <20111231170001.22cdabdd@pyramind.ukuu.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 12/31/2011 06:00 PM, Alan Cox wrote:
>> Thanks, applied.
>>
>> Meanwhile, could you double-check whether AZX_DCAPS_POSFIX_LPIB isn't
>> needed?  We have enabled this bit for Poulsbo recently for working
>> around problems regarding the playback positions.

That was my thought as well, but Takashi was quicker, as usual :-)

> Is there a good way to test this and I'll run the test and see.

I wouldn't say we have a really good way to test it; but PulseAudio is 
relying heavily on this to be correct. So in short - test both playback 
and recording through PulseAudio, and also test making volume changes 
while playing back (or recording). If one position fix method is broken, 
it usually manifests itself by glitches, audio breaking up, or maybe 
stops completely. (There is actually a test tool called alsa-time-test 
written by Lennart Poettering, but AFAIK it only tests playback, and I 
don't exactly know how to use it.)

A quick way to test different position fix methods is to add this module 
parameter:

# This will read from LPIB
options snd-hda-intel position_fix=1

# This will read from DMA Position buffer (the default as specified in 
your patch)
options snd-hda-intel position_fix=2

Btw, you seem to be employed by Intel these days? [1] Any chance you can 
talk to your firmware developers of this chip? I assume somebody at 
Intel should know what method to prefer. That would be the safest/best 
option IMHO.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

[1] https://secure.wikimedia.org/wikipedia/en/wiki/Alan_Cox
