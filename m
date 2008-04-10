From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: My issues with the ALSA API
Date: Thu, 10 Apr 2008 10:16:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0804100951180.13990@tm8103.perex-int.cz>
References: <20080409221512.GA4466@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 4AB6A103827
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Apr 2008 10:16:42 +0200 (CEST)
In-Reply-To: <20080409221512.GA4466@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lennart Poettering <mznyfn@0pointer.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 10 Apr 2008, Lennart Poettering wrote:

> http://pulseaudio.org/wiki/WhyIHateALSA

I started to work on some issues. Note that your requirements are a bit 
more complex than normal applications need and we're mostly driven by user 
requests. Some things are misleading (or they are already implemented) in 
your comments:

Mixer
=====

Please explain this question (why you need the dB <-> value conversion, 
we assumed that application works in dB or integer range not both):

'It is possible to query the dB range of a smixer element. And it is 
possible to query and set the current dB level. However, it is not 
possible to have a dB value converted to an integer level or vice versa, 
without touching the actual setting. i.e. a question like "What is the 
integer level 0 dB corresponds to?" can not be answered by ALSA. Which 
happens to be a serious limitation.'

PCM
===

Timestamps - since 1.0.16 monotonic clocks are usable

plughw: issue - since 1.0.16 you can pass SND_PCM_NO_AUTO flags to open 
function to disable specific conversions

buffer mananagement - I think we already discussed this - use sw_params or 
PCM timer to be updated when buffer position changes (interrupt was
processed), you can use poll() as well

What do you mean with 'There is no API to query the granularity of 
snd_pcm_delay()' ? Application should not know details about bottom 
implementation.

General
=======

Documentantion - if you ask specific questions, we try to update 
documentantion for other developers.. unfortunately, saying that whole 
documentantion is bad is not productive

stderr output - you can redirect all outputs via 
snd_lib_error_set_handler().

========================================

My plans for near future are to implement a better PCM device enumeration 
and try to simplify mixer and add the mixer <-> PCM relationship.

Also, could you explain why current device enumeration is not useful to 
hotplug? There is information which card will be used (CARD=).

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
