From: Daniel Mack <daniel@caiaq.de>
Subject: Re: device underruns
Date: Sat, 25 Apr 2009 14:23:38 +0200
Message-ID: <20090425122338.GE23274@buzzloop.caiaq.de>
References: <20090331144603.GJ16811@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id F0CE6243AA
	for <alsa-devel@alsa-project.org>;
	Sat, 25 Apr 2009 14:23:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id 9A7F57C801A
	for <alsa-devel@alsa-project.org>;
	Sat, 25 Apr 2009 14:23:41 +0200 (CEST)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop.caiaq.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g2YmKWmUSR7b for <alsa-devel@alsa-project.org>;
	Sat, 25 Apr 2009 14:23:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090331144603.GJ16811@buzzloop.caiaq.de>
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

The posting below didn't get any response yet, but the problem persists.
Any hints, anyone?

Thanks,
Daniel

On Tue, Mar 31, 2009 at 04:46:03PM +0200, Daniel Mack wrote:
> I'm currently stress-testing my snd-usb-caiaq driver under several
> environments and happen to see a number of such messages echoed once in
> a while at the start of aplay (1.0.16):
> 
> underrun!!! (at least 1558380812.470 ms long)
> underrun!!! (at least 1558380818.673 ms long)
> underrun!!! (at least 1558380812.465 ms long)
> 
> Also, pulseaudio (0.9.14) keeps complaining with the following message
> all over the place:
> 
> E: module-alsa-sink.c: ALSA woke us up to write new data to the device,                                                                                                                                   
>    but there was actually nothing to write! Most likely this is an ALSA                                                                                                                                   
>    driver bug. Please report this issue to the PulseAudio developers.
> 
> What puzzles me a bit is that I don't really know where and how the
> driver could confuse the core so badly. All it reports is a valid
> pointer to the current head in each substream. Is there anything else it
> could provide for tighter syncing? Any hint how to debug this? Or maybe
> it's not a bug in this specific driver but in the core somewhere?
> 
> Thanks,
> Daniel
