From: Liam Girdwood <lrg@ti.com>
Subject: Re: asoc: no valid backend routes for PCM: SDP4430
	Media
Date: Tue, 7 Jun 2011 09:38:35 +0100
Message-ID: <4DEDE38B.2040408@ti.com>
References: <76445.36914.qm@web161713.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 9429624399
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jun 2011 10:38:41 +0200 (CEST)
In-Reply-To: <76445.36914.qm@web161713.mail.bf1.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: hong zhang <henryzhang62@yahoo.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 07/06/11 01:13, hong zhang wrote:
> List,
> 
> After capturing data from DMIC on OMAP4 blaze board with kernel 2.6.38 and save wav data to 38.wav.
> 
> But aplay complains "no valid backend routes". See following,
> 
> $aplay -f dat 38.wav 
> [  157.167724] asoc: no valid backend routes for PCM: SDP4430 Media
> aplay: main:654: audio open error: Invalid argument
> 

This means you have not configured an audio route for playback (i.e. the audio is not routed anywhere from pcm hw:0,0). Use alsamixer and configure the kcontrols to define the audio path. The kcontrol mappings to audio paths are detailed here for OMAP4 :-

http://omappedia.org/wiki/Audio_Drive_Arch

Liam
