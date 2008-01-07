From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Disabling buffer fill level preprocessing by ALSA
Date: Mon, 07 Jan 2008 18:55:23 +0000
Message-ID: <4782759B.5000208@superbug.co.uk>
References: <20071231171226.GA17953@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-34.mail.demon.net (anchor-post-34.mail.demon.net
	[194.217.242.92])
	by alsa0.perex.cz (Postfix) with ESMTP id B54282497E
	for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2008 19:55:24 +0100 (CET)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.0.10])
	by anchor-post-34.mail.demon.net with esmtp (Exim 4.67)
	id 1JBx88-000Khz-Dm
	for alsa-devel@alsa-project.org; Mon, 07 Jan 2008 18:55:24 +0000
In-Reply-To: <20071231171226.GA17953@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Lennart Poettering wrote:
> Hi!
> 
> In PulseAudio I want to schedule on my own when I need to write audio
> data into the device and when not. To achieve that I want to be
> notified via poll() whenever a period boundary is passed (i.e. when an
> IRQ happens), but only then. That's different from the usual mode
> where you are notified via poll() whether there is space in the
> playback buffer that needs to be filled up. 
> 
> On OSS the mmap() mode enables a mode like I described above. After
> enabling mmap() the application can decide by itself what it considers
> full and what empty in the dma buffer, and use GETOPTR to query the
> playback position. poll() on the OSS fd will directly reflect the
> sound card IRQs and is not influenced if you ever wrote data to device
> or not.
> 
> I assume that I can enable a mode like that with one of the SW
> params. But quite frankly the docs for it are not enlighening at all.
> 
> Lennart
> 

What would you want to do that for? Surely you just want to be told "I
need X samples now please", and that is what the current alsa
poll/callback method does.

James
