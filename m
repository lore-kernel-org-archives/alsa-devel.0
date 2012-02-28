From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC PATCH] Inverted internal mic
Date: Tue, 28 Feb 2012 19:11:15 +0100
Message-ID: <4F4D18C3.1020700@canonical.com>
References: <4F4C9714.1080307@canonical.com> <s5haa43ux7u.wl%tiwai@suse.de>
	<4F4CA438.90103@canonical.com> <s5hvcmrp7ji.wl%tiwai@suse.de>
	<4F4CD1AF.2050409@canonical.com> <s5hboojozx7.wl%tiwai@suse.de>
	<4F4CE264.7040008@canonical.com> <s5hy5rnnfvz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 86C92103F5F
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 19:11:22 +0100 (CET)
In-Reply-To: <s5hy5rnnfvz.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, kailang@realtek.com, 903853@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

On 02/28/2012 04:20 PM, Takashi Iwai wrote:
>> I'm talking about recording an internal mic in *stereo*, as I just wrote
>> below. Or don't you agree that is a valid and probably fairly common use
>> case?
>
> Well, when you record it in stereo, and play it back, then you hear
> the sound without problem.

That could definitely be questioned: depending on the distance between 
speakers when you're finally playing it back, you might lose bass 
frequencies [1]. (That said, I'm not sure how much bass these mics pick 
up anyway.)

> The problem happens only when you sum the
> left and right signals into mono.  Thus, as long as the stream is
> handled as stereo, it could be passed as is, although it's not
> optimal.

So the official recommendation is that summing left and right to make a 
mono signal, is to be considered an invalid operation?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

[1] Or possibly get distorted sound in different ways, not sure.
