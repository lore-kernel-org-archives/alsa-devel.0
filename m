From: Eliot Blennerhassett <eblennerhassett@audioscience.com>
Subject: Re: [PATCH] ALSA: Make snd_pcm_debug_name usable
	outside pcm_lib
Date: Sat, 23 Jul 2011 11:59:23 +1200
Message-ID: <4E2A0EDB.50602@audioscience.com>
References: <1311329126-3682-1-git-send-email-linux@audioscience.com>
	<s5hsjpy1upb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 07F41103806
	for <alsa-devel@alsa-project.org>;
	Sat, 23 Jul 2011 01:59:47 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1QkPd3-0001d1-Kh
	for alsa-devel@alsa-project.org; Sat, 23 Jul 2011 01:59:37 +0200
Received: from 121-72-250-62.cable.telstraclear.net ([121.72.250.62])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 23 Jul 2011 01:59:37 +0200
Received: from eblennerhassett by 121-72-250-62.cable.telstraclear.net with
	local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 23 Jul 2011 01:59:37 +0200
In-Reply-To: <s5hsjpy1upb.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: linux@audioscience.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 22/07/11 22:22, Takashi Iwai wrote:
> At Fri, 22 Jul 2011 22:05:26 +1200,
> linux@audioscience.com wrote:
>>
>> From: Eliot Blennerhassett <eblennerhassett@audioscience.com>
>>
>> Formatting a PCM name is useful for module debug too.
>> Add snd_prefix when making function public.
>>
>> Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
> 
> It'd need EXPORT_SYMBOL*() in addition.
> 
> Or, this can be defined as an inline function.
> It's just a call of snprintf() with the passed arguments, after all.

Hmm. A side-effect of doing it this way is to make pcm.h depend on
core.h, (for substream->pcm->card->number) and there are some files that
include pcm.h but not core.h. E.g. pcsp_lib.c, ctvmem.c, oxygen_lib.c
(and quite a few other possible candidate)

Fix these, or go with the original non-inline version?

--
Eliot
