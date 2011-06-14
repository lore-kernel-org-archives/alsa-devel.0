From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: @Daniel Mack: Send you a FTU
Date: Tue, 14 Jun 2011 13:37:53 +0200
Message-ID: <4DF74811.2080409@showlabor.de>
References: <BANLkTinn8voTA8itkaP64xqzYDxFeJRqSQ@mail.gmail.com>
	<BANLkTimNHyp3_RqCjGQ8p-UOS8_LG+SKeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vwp5738.webpack.hosteurope.de (vwp5738.webpack.hosteurope.de
	[83.169.30.203]) by alsa0.perex.cz (Postfix) with ESMTP id 4D5FC243FE
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Jun 2011 13:37:56 +0200 (CEST)
In-Reply-To: <BANLkTimNHyp3_RqCjGQ8p-UOS8_LG+SKeQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Daniel,

(just to have it public on the list)

Am 14.06.2011 10:56, schrieb Daniel Mack:
>
> Quite frankly, I'm not fully aware about known issues with these
> devices that need attention. Could you summarize which problems are
> left to look at?
>


Here's a list of the issues I'm aware of:

1. Playback clicks:

There are periodic clicks in the playback at all sample rates. They are 
not very noticable in normal use but when you playback a plain sine the 
clicks are very obvious. When we discussed it last year we suspected 
that the device uses "implicit feedback". For the record: When we used 
the device with QUIRK_AUDIO_STANDARD_INTERFACE quirks we had clickless 
playback at 48 kHz and 96 kHz, but playback at 44.1 kHz and 88.2 kHz was 
totally distorted and the kernel would eventually crash after a minute 
or so.


2. External clock sync

The FTU devices are capable of syncing to an external clock via SPDIF. I 
don't know how to switch between internal and external clock. I don't 
even have a second audio interface to test with.


3. Mixer control steps:

The mixer controls are working fine now but are very fine grained. Being 
that fine grained it is hard to control the mixer in some mixer programs 
like alsamixer (alsamixer-qt4 and gamix work fine). A little bit of fine 
tuning would be nice. But I don't know which step size the hardware 
actually supports.

4. Reverb unit:

The FTU devices have a reverb unit which isn't supported, yet. It's 
straight forward based on the basic mixer support . I've almost got it 
wroking except for the "Reverb Program" switch. I know how to do it, so 
probably there will be a patch soon.


5. "Lost" URBs:

Some users reported occasional playback distortion combined with dmesg 
output like this: "ALSA urb.c:480: frame 5 active: -18". I don't know if 
this is really related to the driver. Actually I don't think so but who 
knows ...


Are there any other issues?

Kind regards,

Felix
