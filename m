From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: DMA and delay feedback
Date: Mon, 14 Dec 2009 08:46:27 -0600
Message-ID: <6160a5130912140646g3738731fqbc5caacc153b9da8@mail.gmail.com>
References: <ad2655cb0912140602s138b7246u6db75e40a699c729@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f179.google.com (mail-pz0-f179.google.com
	[209.85.222.179])
	by alsa0.perex.cz (Postfix) with ESMTP id ECBC5103817
	for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2009 15:46:28 +0100 (CET)
Received: by pzk9 with SMTP id 9so2204797pzk.16
	for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2009 06:46:28 -0800 (PST)
In-Reply-To: <ad2655cb0912140602s138b7246u6db75e40a699c729@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> For transfer purposes, one only needs to know that DMA transfer is
> complete on period X so that period X can now be over-written.

That's the 'traditional' view. ALSA is now used in different ways.
PulseAudio sets a timer and relies on snd_pcm_avail() to query how
many samples it can write to the ring buffer, the notion of period
isn't used at all. I think we could use additional information in the
way the hw_ptr position is reported, namely hints on how precise this
information is and the granularity of the updates.
- Pierre
