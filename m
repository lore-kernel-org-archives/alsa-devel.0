From: =?UTF-8?B?SsO2cmcgTcO8bGxlcg==?= <joerg.mueller7744@gmail.com>
Subject: [Alsa-Devel] Cannot combine audio devices with more
	than 64 channels
Date: Thu, 26 Jan 2017 15:14:41 +0100
Message-ID: <CAKw=HF0hbhxJ1YGjukjFr72xtEh2FjtH6k0Bh+rFcMwejgwcUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 by alsa0.perex.cz (Postfix) with ESMTP id D6F162676C6
 for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2017 15:14:42 +0100 (CET)
Received: by mail-oi0-f66.google.com with SMTP id w144so18383704oiw.1
 for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2017 06:14:42 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I need to combine two HDSPe MADI FX cards to one virtual device. I
have a working driver, which is alsa-compatible. I can select each
single card in any alsa-compatible application and all channels work
flawless.
For combining the MADI FX cards to one virtual device, I created an
.asoundrc with 194 inputs for each card. When I start that virtual
device via
jackd -R -d alsa -C madifx_record_all -P madifx_playback_all

I get this error:
> creating alsa driver ...
> madifx_playback_all|madifx_record_all|1024|2|48000|0|0|nomon|swmeter|-|32bit
> jackd: pcm_multi.c:1060: snd_pcm_multi_open: Assertion `!slave_map[sidxs[i]][schannels[i]]' failed.

However, it works when I reduce the amount from 194 to 64 channels per
card. I tried to use 128 channels per card, but that fails the same
way. See my alsa-info here http://pastebin.com/4hq1B3wZ , which also
includes the .asoundrc content.

I also found this, which might be related:
https://ccrma.stanford.edu/mirrors/lalists/lad/2005/06/0202.html

To me, this looks like a bug. What do you think?

For reference, I posted the same question on
http://lists.jackaudio.org/private.cgi/jack-devel-jackaudio.org/2017-January/000741.html,
however, they recommended to ask here for help.
