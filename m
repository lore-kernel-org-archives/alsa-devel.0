From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: pulseaudio eats 19% CPU power in Fedora 12
Date: Thu, 22 Apr 2010 08:53:43 +0100
Message-ID: <hqova7$jer$1@dough.gmane.org>
References: <20100414075658.GA26283@localhost>	<20100419032856.GA13629@tango.0pointer.de>	<k2q604760771004182038n72eec9bdy77a9e4faf2152ee4@mail.gmail.com>	<u2l4f3252891004201730g94e709abs8ebf34b00d9ed505@mail.gmail.com>	<hqmb58$frb$1@dough.gmane.org>
	<q2y4f3252891004211811g51d5de65n862193cf6c42fe73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 3505D10380D
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Apr 2010 09:53:54 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1O4rEN-0004kc-H2
	for alsa-devel@alsa-project.org; Thu, 22 Apr 2010 09:53:51 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 22 Apr 2010 09:53:51 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 22 Apr 2010 09:53:51 +0200
In-Reply-To: <q2y4f3252891004211811g51d5de65n862193cf6c42fe73@mail.gmail.com>
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

'Twas brillig, and Raymond Yau at 22/04/10 02:11 did gyre and gimble:
> is it possible to provide some figure  to compare the CPU usage of PA when
> using  pacat, paplay and aplay on your machine ?
> 
> the problem of Shuang He seem related to upmixing of stereo to surround71
> 
>>>     sink: 0 <alsa_output.pci-0000_00_1b.0.
> analog-surround-71>
>         volume: 0: 100% 1: 100%
>                 0: 0.00 dB 1: 0.00 dB
>                 balance 0.00
>         muted: no
>         current latency: 444.25 ms
>         requested latency: 31.25 ms
>         sample spec: s16le 2ch 48000Hz
>         channel map: front-left,front-right
>                      Stereo
>         resample method: speex-float-3
>         module: 8
>         client: 7 <ALSA plug-in [mplayer_2010_0414]>


Probably not meaninfully on this machine as it's only got stereo. I'll
try and get one of my more elaborate machines ready for an upmixing
comparison.

Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mandriva Linux Contributor [http://www.mandriva.com/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
