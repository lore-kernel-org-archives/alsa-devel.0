From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ALSA: ASoC: cs4720: use
	snd_soc_cache_sync()
Date: Tue, 22 Nov 2011 16:41:42 +0100
Message-ID: <4ECBC2B6.5050606@gmail.com>
References: <1321969516-21174-1-git-send-email-zonque@gmail.com>
	<20111122140210.GD6624@sirena.org.uk> <4ECBBE59.2040703@gmail.com>
	<20111122153539.GF6624@sirena.org.uk>
	<4ECBC1D6.9090301@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id AA856103A99
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 16:41:54 +0100 (CET)
Received: by bkat8 with SMTP id t8so336566bka.38
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 07:41:54 -0800 (PST)
In-Reply-To: <4ECBC1D6.9090301@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/22/2011 04:37 PM, Timur Tabi wrote:
> Mark Brown wrote:
>> That's very odd, not ringing any bells at all.  It's not like the 
>> existing code is trying to do anything clever with skipping writes,
>> it just blasts in all the register values and it's affecting two
>> different registers.
> 
> Is there a quick-and-dirty way to test suspend/resume?  It's not
> officially supported on our board with a CS4270, so I never tried it,
> and I'm not familiar with it.
> 

echo mem > /sys/power/state

But in our case, the codec is powered off completely, so you might have
a very different power regulator setup on your board. And that might
cause the bug not to show up, as it retains its register values over
suspend.


Daniel
