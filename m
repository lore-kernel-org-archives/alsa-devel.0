From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Is there a way to figure out if the clocks of two
 snd_pcm_t's deviate? (snd_pcm_info_get_sync?)
Date: Fri, 4 Sep 2009 08:44:50 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0909040831390.20533@eeebox2.perex-int.cz>
References: <20090903230351.GA7493@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 24C0C243C5
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Sep 2009 08:44:51 +0200 (CEST)
In-Reply-To: <20090903230351.GA7493@tango.0pointer.de>
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

On Fri, 4 Sep 2009, Lennart Poettering wrote:

> Heya!
>
> I am looking for a way to find out whether the clocks of two
> snd_pcm_t's are perfectly in sync and don't deviate (or only deviate
> by a constant phase).
>
> i.e. for real duplex devices that use the same crystal for input and
> output this should tell me "Yes" for the playback snd_pcm_t tested
> against the recording snd_pcm_t; and for all other, unrelated audio
> devices it should return "No".
>
> I found snd_pcm_info_get_sync() in the docs, but its documentation is
> a bit terse, so I am wondering if this might be what I want. Is it?
>
> Does this (untested) code snippet do what I hope it does?

Hi,

Nope. The snd_pcm_info_get_sync() function identifies streams with 
"sample sync and sample synchronized start".

All standard soundcards have only one clock source, so if 
snd_pcm_info_get_card() number matches, the streams will most probably 
run in sync.

I cannot recall from my mind, if any card has two clock sources - maybe 
only old Gravis UltraSound hardware with GF1 and CS4231 chips, but it's 
history. Also, professional hardware can run with word clock sync (wire 
connection carrying sample clock) or S/PDIF clock sync. But it's matter of 
user configuration.

I would suggest to match card number as default for used streams and add 
an user option to modify the stream word clock configuration for your app.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
