From: Philip Spencer <pspencer@fields.utoronto.ca>
Subject: Re: [PATCH] Wrong latency in pulseaudio plugin breaks
 Adobe Flash Player
Date: Fri, 17 Feb 2012 16:15:40 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1202171606030.11808@lpc8.fields.utoronto.ca>
References: <alpine.LFD.2.00.1202161015470.19707@lpc8.fields.utoronto.ca>
	<4F3DAC41.4000602@canonical.com>
	<alpine.LFD.2.00.1202162248280.21549@fields.fields.utoronto.ca>
	<4F3E1A04.9080404@canonical.com>
	<alpine.LFD.2.00.1202171351300.11808@lpc8.fields.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fileserver.fields.utoronto.ca (fileserver.fields.utoronto.ca
	[128.100.216.10])
	by alsa0.perex.cz (Postfix) with ESMTP id B76E0103FFA
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 22:15:43 +0100 (CET)
In-Reply-To: <alpine.LFD.2.00.1202171351300.11808@lpc8.fields.utoronto.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I have pulseaudio logs from two runs of FlashPlayer. In each one I 
commented out the plugin's call to pa_stream_trigger just to avoid the
irrelevant problem of FlashPlayer starting the stream a little too early;
I merely patched it to set prebuf low.

In the first run, logged at www.fields.utoronto.ca/~pspencer/pulsebad.log,
I made no changes to tlength so it was left at 500ms. This resulted in
audio with several hiccups during the first two seconds and latency
rising to 500ms after two seconds.

In the second run I altered the patch to lower tlength. This resulted in
smooth audio with no discernible latency. The log is at

www.fields.utoronto.ca/~pspencer/pulsegood.log

Unfortunately, there is no discernible difference between the two logs. A 
diff of the log files (with the initial timestamp removed before diffing) 
is at www.fields.utoronto.ca/~pspencer/pulse.diff. The only changes are

   (a) different addresses for things like bus ids
   (b) the different tlength and latency values being reported
   (c) minor differences (on the order of a few bytes / a few microseconds)
       in some of the rewinds and volume adjustments.

So I am still at a loss as to why lowering tlength produces smooth audio
and raising it causes hiccups and -- presumably -- hardware underruns that 
aren't getting logged.

- Philip

--------------------------------------------+-------------------------------
Philip Spencer  pspencer@fields.utoronto.ca | Director of Computing Services
Room 336        (416)-348-9710  ext3036     | The Fields Institute for
222 College St, Toronto ON M5T 3J1 Canada   | Research in Mathematical Sciences
