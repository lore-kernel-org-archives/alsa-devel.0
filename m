From: Jason Harvey <softdevice@jasonline.co.uk>
Subject: Re: sbxfi - What works/doesn't summary
Date: Tue, 28 Oct 2008 20:15:54 +0000
Message-ID: <490772FA.9060508@jasonline.co.uk>
References: <4906FA8C.4030501@jasonline.co.uk>	<490709EF.7090803@gmail.com>	<49074E98.7070506@jasonline.co.uk>	<s5h3aigilum.wl%tiwai@suse.de>	<490768FF.3020807@jasonline.co.uk>
	<s5hy708h5r1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from homer.jasonline.co.uk (78-86-168-217.zone2.bethere.co.uk
	[78.86.168.217])
	by alsa0.perex.cz (Postfix) with ESMTP id 8485B103825
	for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2008 21:15:49 +0100 (CET)
In-Reply-To: <s5hy708h5r1.wl%tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
>> Sorry that was a bit ambiguous, I'd never tried 96kHz.
>> Have just changed base_rate to 96kHz and it performs identically to 48kHz.
>> Pulse mangles the sound in just the same manner at 48kHz or 96kHz.
>>     
>
> Ah, so you meant mplayer/flash with PA backend?
>   
Yes.
I also tried mplayer using -ao=alsa or -ao=oss and the sound is still 
corrupted, even after killing the pulse daemon.

If I get the chance I will put the card into a 32bit machine tomorrow 
and see how it sounds there.

Thanks, Jason
