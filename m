From: Matt Whitlock <matt@whitlock.name>
Subject: Re: How to set idle S/PDIF sample rate?
Date: Wed, 27 Feb 2008 15:26:36 -0500
Message-ID: <200802271526.36370.matt@whitlock.name>
References: <200802222234.22975.matt@whitlock.name>
	<200802261725.35575.matt@whitlock.name>
	<47C57379.3060807@insite.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 9B28324438
	for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2008 21:26:41 +0100 (CET)
Received: by hs-out-0708.google.com with SMTP id l65so4477836hsc.0
	for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2008 12:26:40 -0800 (PST)
In-Reply-To: <47C57379.3060807@insite.cz>
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
To: Pavel Hofman <pavel.hofman@insite.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I tried forcing the 'rate' parameter of 'pcm.!default' to 44100, and while that does cause all my dmixed audio to be at 44100 Hz, still, when all playback streams have been closed, the hardware reverts back to silence at 48000 Hz.

I suppose I could write a little program that would simply open the default PCM and then go to sleep indefinitely.  That would hold the hardware at 44100 Hz, and any music would simply be dmixed in.  The downside would be that I would be unable to play DVD audio at 48000 Hz, and I would definitely be unable to stream AC3 or DTS out through S/PDIF.


On Wednesday, 27 February 2008 9:28:09 am Pavel Hofman wrote:
> Matt Whitlock wrote:
> > 
> > Can I assume at this point that there is no way to set the idle S/PDIF output sample rate to 44100 Hz?  That is my original question.
> 
> I have no experience with HDA. In ICE1712/24 the spdif-out outputs 
> signal corresponding to the current sampling frequency the chip is 
> running on, containing no data. When playing sound, the chip clock 
> switches to appropriate frequency, and spdif outputs data of this 
> frequency. I.e. if the "parking, idle, default" frequency is 44.1kHz, it 
> continuously outputs 44.1kHz SPDIF signal.
> 
> I guess if you could force HDA to default to 44.1kHz (no idea whether it 
> is feasible), that would be it.
> 
> Pavel.
> 
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
