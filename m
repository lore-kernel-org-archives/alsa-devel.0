From: Florian Faber <faber@faberman.de>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Tue, 15 Apr 2008 05:52:13 +0200
Message-ID: <200804150552.13578.faber@faberman.de>
References: <20080411204610.GA32413@tango.0pointer.de>
	<20080414172839.GA26513@tango.0pointer.de>
	<4803C78A.3020109@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from india820.server4you.de
	(static-ip-85-25-152-101.inaddr.intergenia.de [85.25.152.101])
	by alsa0.perex.cz (Postfix) with ESMTP id D59AF24681
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Apr 2008 05:52:26 +0200 (CEST)
In-Reply-To: <4803C78A.3020109@superbug.co.uk>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Monday 14 April 2008 23:07:22 James Courtier-Dutton wrote:
> The aim of the dB values in the ALSA mixer is this.
>
> For Playback:
> Set all the mixer controls to 0dB.
> Send a sample digital signal from the CPU to the sound card.
> The measured analog signal on the line-out should be the same for ALL
> sound cards.

Consumer levels are -10dBV while pro audio levels are +4dBu. And you 
have to be more specific what to measure.

How about this: You do what you want with the consumer boards, and leave 
the pro guys alone. Pro drivers are not 'broken' if they don't 
implement such a 'feature', they are pro drivers.


Flo
-- 
Machines can do the work, so people have time to think.
public key 6C002249          x-hkp://wwwkeys.eu.pgp.net
