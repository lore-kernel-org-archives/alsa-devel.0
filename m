From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [REANNOUNCE] Audio Mini Summit 2015, 8th October,
	Dublin
Date: Tue, 14 Jul 2015 21:04:30 +0500
Message-ID: <55A5330E.7000604@gmail.com>
References: <20150714150352.GW11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
 [209.85.212.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 4660626510A
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2015 18:04:33 +0200 (CEST)
Received: by widjy10 with SMTP id jy10so103884560wid.1
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2015 09:04:33 -0700 (PDT)
In-Reply-To: <20150714150352.GW11162@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

14.07.2015 20:03, Mark Brown wrote:
> Like previous years, we're going to hold a meeting to discuss
> lowlevel audio on Linux.  This will be held the day after ELC Europe on
> 8th October at CCD (The Convention Centre) in Dublin.
>
> If you're interested please sign up in the attendee list:
>
> https://docs.google.com/spreadsheets/d/1bi-8GHsqlzt41FR20WiMuWILe_cZowFireVMBd-QM8Q/edit?usp=sharing
>
> and please follow up to this mail with any topics you'd like to see
> raised so we can start collecting them (probably another Google doc will
> be forthcoming for them).

I would like to see some direct measurements related to recent 
power-saving proposals, including the "disable rewinds" flag. Myself, I 
can redo battery-life measurements on Intel-based laptops that my 
colleagues have, and maybe compare dmix, PulseAudio and CRAS in terms of 
power consumption.

Ideally, I would like to reevaluate the design decisions (namely, the 
need to keep the system responsive to new streams while keeping the 
average wakeup rate as low as possible, IMHO even to the point of 
"absurdly low") that led to the need to support rewinds (and the 
associated complexity) in the first place. Reminder: on my Sony VAIO 
VPC-Z23A4R laptop and hw:0 device, in an unrealistic test with the 
screen turned off, wi-fi turned off, and the SSDs put to sleep, going 
from 200 to 1 wakeup per second saved only 935 seconds of battery life 
out of 25742.

-- 
Alexander E. Patrakov
