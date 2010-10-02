From: Alexander Lam <lambchop468@gmail.com>
Subject: Acer Aspire One Volume Low
Date: Fri, 1 Oct 2010 20:52:36 -0400
Message-ID: <AANLkTineQfCpW3zCzLMd2EitdAQfn6sSgJ+UOz78XY0+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id D5923244E7
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Oct 2010 02:53:16 +0200 (CEST)
Received: by bwz13 with SMTP id 13so2843857bwz.38
	for <alsa-devel@alsa-project.org>; Fri, 01 Oct 2010 17:53:16 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

I have an Acer Aspire one (the original one) with a realtek alc268 codec
(intel hda)

In windows XP, I would say that the maximum volume is somewhere around 5
times higher than in linux.

I am running kernel 2.6.35.6.

I actually have the spec sheet for the codec (from a google search) and the
mixer ranges that are specified in the kernel seem sane,so I'm clueless as
to what's happening. Maybe there's some mystery bit to set, because the
windows XP Realtek driver has a "limit output" option that when turned on,
makes the output be about as loud as in linux. (or maybe this option just
cuts the mixer values in half...)

Suggestions? Lacking that, is there a tool already written to read back the
codec configuration in windows XP?

-- 
Alexander Lam
