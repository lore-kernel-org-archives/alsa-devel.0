From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Fwd: Re: Realtek ALC889: HDA Intel and kernel 3.1
 gives choppy sound (again)
Date: Tue, 20 Dec 2011 00:03:51 +0100
Message-ID: <4EEFC2D7.3020003@canonical.com>
References: <4EE8B368.2080605@herbesfolles.org> <s5h39cnnra5.wl%tiwai@suse.de>
	<4EE8CAE4.4040609@herbesfolles.org>
	<s5hsjknm53r.wl%tiwai@suse.de> <4EEF530D.9050205@canonical.com>
	<s5hd3bkk294.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 8AD0210387B
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2011 00:03:53 +0100 (CET)
In-Reply-To: <s5hd3bkk294.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Colomban Wendling <lists.ban@herbesfolles.org>
List-Id: alsa-devel@alsa-project.org

On 12/19/2011 04:30 PM, Takashi Iwai wrote:
> At Mon, 19 Dec 2011 16:06:53 +0100,
> David Henningsson wrote:
>> Hmm, thanks for figuring this one out. Actually this is the third time I
>> hear of jack detection flipping back and forth. I'm wondering if we need
>> (and whether other OSes have?) a filter / flood protection on this
>> stuff, and if so, how it works? I mean, nobody would notice half a
>> second of delay on that switch anyway.
>
> I don't think there is a perfect filtering for such a problem.
> Theoretically we can see how often it's flipped, and disables the
> jack-detection accordingly.  But not sure how useful it is in
> practice, since it's a rare case, and the manual adjustment is easy.
>
> BTW, maybe we should turn off the jack-detection while the auto-mute
> is disabled?  Otherwise unsol events might still come up although they
> are just ignored.

I guess that would also disable the possibility for userspace to read 
state changes, both with the old and new jack detection interface?

Also, in a long term scenario, one could consider PulseAudio disabling 
auto-mute and handling that logic itself, potentially with advanced 
routing rules (a use case could be, if a phone call comes in, play the 
ring tone in the speaker but the actual talking would be through the 
headset).

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
