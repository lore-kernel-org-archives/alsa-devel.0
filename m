From: Jean-Yves Avenard <jyavenard@gmail.com>
Subject: Re: snd_pcm_hw_params_set_buffer_time_near: invalid
	argument
Date: Tue, 8 Mar 2011 09:32:22 +1100
Message-ID: <AANLkTinNhknw6h81zkqhhXQwYyrKGs0mVjYpjYvZuNa=@mail.gmail.com>
References: <AANLkTik5sX_DWLsN3y_7ANpoF5rgeCNZY7gm=+rFhCsy@mail.gmail.com>
	<AANLkTimfZwH+dqsPZaifekmmctrARdE0DoK5nHoW1Fu_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yi0-f51.google.com (mail-yi0-f51.google.com
	[209.85.218.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 28543103814
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 23:32:25 +0100 (CET)
Received: by yib2 with SMTP id 2so2112868yib.38
	for <alsa-devel@alsa-project.org>; Mon, 07 Mar 2011 14:32:22 -0800 (PST)
In-Reply-To: <AANLkTimfZwH+dqsPZaifekmmctrARdE0DoK5nHoW1Fu_@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 7 March 2011 23:24, Raymond Yau <superquad.vortex2@gmail.com> wrote:

> This seem to be bug in alsa-lib as I can reproduce using alsa-lib/test/pcm.c
> with buffer time 120000 and my hda codec support both 11025Hz and 22050Hz
>
> using buffer time 160000 is OK

Yes.. It's hard to understand why 120ms wouldn't be okay, but 160ms would.

Could you check is 400ms works for you ? I found this to be a value
that generally do not work when using 44.1kHz 6 channels audio.

For the time being, I made my application use 500ms buffer; this is
what many media players are using (including mplayer) , so I'm
guessing it would be fine under most circumstances otherwise we would
have heard about it before.

Jean-Yves
