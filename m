From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: What does snd_pcm_delay() actually return?
Date: Tue, 10 Jun 2008 15:36:02 +0100
Message-ID: <484E9152.6090908@superbug.co.uk>
References: <20080609190225.GA4534@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-31.mail.demon.net (anchor-post-31.mail.demon.net
	[194.217.242.89])
	by alsa0.perex.cz (Postfix) with ESMTP id 4594324363
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jun 2008 16:36:03 +0200 (CEST)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.0.10])
	by anchor-post-31.mail.demon.net with esmtp (Exim 4.67)
	id 1K64x8-000HWQ-59
	for alsa-devel@alsa-project.org; Tue, 10 Jun 2008 14:36:02 +0000
In-Reply-To: <20080609190225.GA4534@tango.0pointer.de>
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
> Takashi, Jaroslav,
> 
> could you please explain what exactly snd_pcm_delay() returns? 
> 
> Some applications (such as WINE) assume it is the time that would pass
> until we reach an underrun if we would stop writing any further data
> to the PCM device.

<WRONG>


> 
> Other applications (such as most media players) use it for time
> synchronisation. i.e. assume that it is the time that passes until a
> sample I write to a PCM device now would take to be played.
> 


<RIGHT>
