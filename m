From: Tim Gardner <tim.gardner@canonical.com>
Subject: Re: [PATCH] hda: Add dmux to STAC 9228
Date: Fri, 19 Oct 2007 10:45:39 -0600
Message-ID: <4718DF33.501@canonical.com>
References: <4717D1E0.9080903@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.tpi.com (mail.tpi.com [198.107.51.143])
	by alsa0.perex.cz (Postfix) with ESMTP id C988F2460A
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Oct 2007 18:45:57 +0200 (CEST)
In-Reply-To: <4717D1E0.9080903@embeddedalley.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Matthew Ranostay <mranostay@embeddedalley.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, "Tellman,
	Steven" <Steven.Tellman@idt.com>
List-Id: alsa-devel@alsa-project.org

Matthew Ranostay wrote:
> Added a dmux to the STAC9228 cards with DMIC support. And added a
> STAC_DIGITAL_INPUT_SOURCE macro for repeating mixer code.
> ---

I'm not having any luck with this patch on my XPS M1330. I built against
Ubuntu Gutsy (2.6.22 which requires some PIT_TICK_RATE futzing in
pcsp.h) from current ALSA repo bits after Takashi applied it to HG. I
also removed Gusty l-u-m which contains a conflicting snd-hda-intel.

Audio output works fine. The only record source that appears to work is
the external microphone (front input), though it is very faint even with
mux 1 cranked to the max.

Can you describe your environment and record applications? Perhaps I'm
just missing some assumption.

-- 
Tim Gardner tim.gardner@ubuntu.com
