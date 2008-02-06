From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] SND_SEQ_BLOCK and SND_SEQ_PORT_CAP_NONE
 defines
Date: Wed, 6 Feb 2008 10:51:47 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0802061040270.8113@tm8103.perex-int.cz>
References: <17eedd8a0801310942g48245675k4a96162e810fd21a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A3901038F1
	for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2008 10:51:47 +0100 (CET)
In-Reply-To: <17eedd8a0801310942g48245675k4a96162e810fd21a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Aldrin Martoq <amartoq@dcc.uchile.cl>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 31 Jan 2008, Aldrin Martoq wrote:

> Hey hackers,
> 
> While developing pyalsa sequencer API, I found that sometimes 0 is
> used instead of a #defined value or constant.
> 
> In my opinion, given that the alsa API is opaque (hides internal
> structure and provides methods for accessing them), we should define
> those missing "constants" for being consistent. So far I found:
> SND_SEQ_BLOCK 0 (blocking mode)
> SND_SEQ_PORT_CAP_NONE (the port defines no access capabilites)

Note that SND_SEQ_NONBLOCK is flag (bitmask). Also SND_SEQ_PORT_CAP_* 
defines are bitmasks. I don't see usage to have defined for 0 because it 
always mean "off state" rather than a direct value. Correct tests are:

val&SND_SEQ_NONBLOCK		- nonblocking behaviour
(val&SND_SEQ_NONBLOCK)==0	- blocking behaviour

Regarding python. I think that we need to settle naming scheme. I just 
moved my code to follow standard python rules (only class names have upper 
letters and constants).

I also chose a different organization for constants in my code to have 
possibility to enumerate all related bitmasks or numbers using 
dictionaries. See my python modules.

It meas to define SEQ_ADDRESS_* like:

seq_address = {'BROADCAST': 0xff, 'SUBSCRIBERS': 0xfe, 'UNKNOWN': 0xfd}
open_mode = {'NONBLOCK': 1}
etc...

				Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
