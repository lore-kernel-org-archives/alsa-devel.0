From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [REANNOUNCE] Audio Mini Summit 2015, 8th October,
	Dublin
Date: Tue, 14 Jul 2015 21:36:11 +0500
Message-ID: <55A53A7B.20806@gmail.com>
References: <20150714150352.GW11162@sirena.org.uk>
 <55A5330E.7000604@gmail.com> <20150714161711.GB11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 725112652B0
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2015 18:36:14 +0200 (CEST)
Received: by wgkl9 with SMTP id l9so13239494wgk.1
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2015 09:36:14 -0700 (PDT)
In-Reply-To: <20150714161711.GB11162@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

14.07.2015 21:17, Mark Brown wrote:
> On Tue, Jul 14, 2015 at 09:04:30PM +0500, Alexander E. Patrakov wrote:
>
>> I would like to see some direct measurements related to recent power-saving
>> proposals, including the "disable rewinds" flag. Myself, I can redo
>> battery-life measurements on Intel-based laptops that my colleagues have,
>> and maybe compare dmix, PulseAudio and CRAS in terms of power consumption.
>
> The numbers I seem to remember seeing at the time were these IIRC:
>
>     http://linux-tipps.blogspot.co.uk/2011/04/power-performance-of-pulseaudio-alsa.html
>
> saying there was a 0.4W win (I think Arun had some similar numbers).

Thanks for the link. I have no reason to doubt these measurements. Note, 
however, that they are of the "pulseaudio vs pulseaudio" type, and give 
no insight into the structure of the win. By "structure", I mean the 
proportion of energy wasted due to the wakeup itself, in the kernel 
code, and in the pulseaudio code. IOW, they, technically, don't rule out 
the "pulseaudio is inefficient at low latencies, and that's pulseaudio's 
fault" possibility. That's why (and also because, on my hardware, the 
win with hw:0 and aplay is smaller) I want to do some cross-comparisons 
of various sound servers to the raw hw:0 device. It would also be nice 
to be able to see directly the effect of David's work on srbchannel.

-- 
Alexander E. Patrakov
