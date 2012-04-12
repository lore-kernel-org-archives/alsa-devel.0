From: "Max Klein" <mein_name@ist-einmalig.de>
Subject: High CPU usage when recording on TI DM6446 using ASoC
	AIC33
Date: Thu, 12 Apr 2012 12:41:13 +0200
Message-ID: <20120412104113.49710@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by alsa0.perex.cz (Postfix) with SMTP id 5C6CC243FD
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Apr 2012 12:41:14 +0200 (CEST)
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

I am having a problem with high CPU usage (>90%) on TI DM6446 (ARM926 core) with TI TLV320AIC33 audio codec. When using the command "gst-launch -v alsasrc ! mulawenc ! rtppcmupay ! fakesink silent=true" the CPU usage raises to 97% after a while (e.g. after 38s) and drops to 0% again later (e.g. after next 78s). To check if the alsasrc element of GStreamer is the problem, I used "arecord -r 8000 -c 1 -f S16_LE --period-time=10000 --buffer-time=200000 > /dev/null" for comparison, and I also could see a similar problem: after some (more) seconds the CPU usage raises to >90% and drops to 0% afterwards again (but it stays at >90% for only ca. 33s ). I just monitored the problem with top and vmstat - vmstat log for arecord example can be seen at http://pastebin.com/H3LRtyPg

When using the gstreamer command (especially alsasrc), a different latency-time and buffer-time has influence to the cpu usage (e.g. when using "gst-launch -v alsasrc latency-time=20000 buffer-time=400000 ! mulawenc ! rtppcmupay ! fakesink silent=true" CPU usage raised to 49% after a while, when using "gst-launch -v alsasrc latency-time=40000 buffer-time=800000 ! mulawenc ! rtppcmupay ! fakesink silent=true" CPU usage raised to 25% after a while...)

I guess it could be a problem somewhere in the ALSA driver, but before trying to patch the driver to the latest version I would go for sure that this would help...I have seen a lot of commits in AIC33 git tree, but I guess its not that easy to update my kernel to the latest alsa-kernel version???

1. Can someone confirm such a behaviour on DM6446 EVM?
2. Does someone have a clue how to identify and solve the problem? 
3. Would it be possible to update "just" the ALSA part in my Kernel do test the latest ASoC driver for DaVinci/AIC33?

I am looking forward for any help!


--
Information about used versions:

> I am using DM6446 with TI AIC33 Audio Codec running at vendor-specific 2.6.27 kernel (based on http://gitorious.org/linux-davinci/linux-davinci/trees/v2.6.27-davinci1 with ALSA driver patched to cb6e2063697e91ca6983f9fe6958d20469b43641 from alsa-kernel [2008-11-18] tree)

> Advanced Linux Sound Architecture Driver Version 1.0.17.
> ASoC version 0.13.2
> AIC3X Audio Codec 0.2
> asoc: aic3x <-> davinci-i2s mapping ok
> ALSA device list:
>   #0: DaVinci EVM (aic3x)

> Version of GStreamer 0.10.25 (also tested with 0.10.35 - the same problem)

> ALSA library in user space is 1.0.19 (extracted from libasound.so)
-- 
NEU: FreePhone 3-fach-Flat mit kostenlosem Smartphone!                                  
Jetzt informieren: http://mobile.1und1.de/?ac=OM.PW.PW003K20328T7073a
