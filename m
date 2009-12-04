From: Devin Heitmueller <dheitmueller@kernellabs.com>
Subject: Re: Underruns in basic audio playback application
Date: Fri, 4 Dec 2009 10:08:06 -0500
Message-ID: <829197380912040708r7be4f196n478c151b3a4ce137@mail.gmail.com>
References: <829197380912030804u672b31c6ybf30e87828b7576b@mail.gmail.com>
	<b6251a620912040028k7fdfaf23xbf07be01898aaaa6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f211.google.com (mail-fx0-f211.google.com
	[209.85.220.211])
	by alsa0.perex.cz (Postfix) with ESMTP id 50B2F1038A4
	for <alsa-devel@alsa-project.org>; Fri,  4 Dec 2009 16:08:07 +0100 (CET)
Received: by fxm3 with SMTP id 3so2690985fxm.4
	for <alsa-devel@alsa-project.org>; Fri, 04 Dec 2009 07:08:06 -0800 (PST)
In-Reply-To: <b6251a620912040028k7fdfaf23xbf07be01898aaaa6@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Christophe Osuna <christophe.osuna@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 4, 2009 at 3:28 AM, Christophe Osuna
<christophe.osuna@gmail.com> wrote:
> I don't have much experience myself, but in such a situation I would
> recommend either increasing buffer size, or linking capture and
> playback devices with snd_pcm_link().

Thanks for the input.  In the end, I hacked up a version of the
test/latency.c to do what I needed.  I think the root of the issue is
that ALSA behaves badly if both the period and buffer sizes/times are
configured, and the values provided do not match up (in terms of the
buffer size relative to the period size).

Anyway, I've got it working now, so thanks anyway!

Devin

-- 
Devin J. Heitmueller - Kernel Labs
http://www.kernellabs.com
