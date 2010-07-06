From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: XRUN handling
Date: Tue, 6 Jul 2010 20:39:16 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1007062034050.15497@eeebox2.perex-int.cz>
References: <AANLkTim_2xOjhFHcfyMvgceAQZEauWYIbY8QV-0jnBWw@mail.gmail.com>
	<AANLkTikRHAHhDXEEcejT5BqiJXiIaQX-lhg3zqTljcnq@mail.gmail.com>
	<AANLkTim93O9PgptYEdBkAf_x7reIf_1DxbHCYjLdfVLB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id BE72724661
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Jul 2010 20:39:17 +0200 (CEST)
In-Reply-To: <AANLkTim93O9PgptYEdBkAf_x7reIf_1DxbHCYjLdfVLB@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: melwyn lobo <linux.melwyn@gmail.com>
Cc: alsa-devel@alsa-project.org, James Courtier-Dutton <james.dutton@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 6 Jul 2010, melwyn lobo wrote:

> done away with by using silence_size and silence_threshold. And if the
> application still does not get processor time for some reason, the
> hw_ptr will overrun the appl_ptr by more than buffer_size and trigger
> a bug in snd_pcm_playback_silence().

Could you fix (send us a patch) or describe exactly this problem?

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
