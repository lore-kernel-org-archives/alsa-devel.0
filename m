From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Testing rewindability of a pcm
Date: Tue, 22 Apr 2014 23:41:10 +0600
Message-ID: <5356A9B6.9060405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f45.google.com (mail-la0-f45.google.com
 [209.85.215.45])
 by alsa0.perex.cz (Postfix) with ESMTP id C918326171D
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 19:44:06 +0200 (CEST)
Received: by mail-la0-f45.google.com with SMTP id hr17so4615818lab.18
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 10:44:06 -0700 (PDT)
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
Cc: david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

Hello.

[David: if I misrepresent the result of our discussion, please correct me.]

On the pulseaudio-discuss list, there was a thread started by me:

http://lists.freedesktop.org/archives/pulseaudio-discuss/2014-April/020449.html

The initial patch attempted to work around known brokenness of rewind 
handling in certain ALSA plugins by keeping a whitelist of ALSA plugin 
types known to implement full or almost-full rewinds absolutely 
correctly, and falling back to the low-latency no-rewinds mode on others 
(such as extplug, which only pretends to support rewinds). While David 
accepted that it would be a good idea to use a not-so-high latency (he 
proposed ~150-200 ms) if rewinds are not available, keeping a plugin 
whitelist inside PulseAudio code was shot down as a workaround for an 
ALSA bug. The alternative proposal is to fix ALSA so that it correctly 
reports rewindability, and use the reported data, which looks like a 
good idea. However, there remain some disagreements on the details how 
ALSA needs to be fixed, that's why this e-mail.

David suggests that PulseAudio should use the snd_pcm_rewindable() 
function when all plugins are fixed to either implement rewinds 
correctly or to return 0 if they don't actually support rewinds. And for 
ioplug and extplug, supporting rewinds is not really an option, because 
the backend library (which can be an AC3 or DTS encoder) does not 
necessarily have a rewindable API. <offtopic><troll>And we don't even 
have a rewindable resampler implementation!</troll></offtopic>

While fixing snd_pcm_rewindable() is indeed a valid task that I take for 
some plugins, I have a question.

"""
Should PulseAudio indeed use a complex dance with snd_pcm_rewindable() 
to get the essentially-static bit of information whether a given PCM 
supports full rewinds? Isn't there a better solution?
"""

The problem is that the information should be used to set the maximum 
allowed latency of the sink: a PCM that supports full rewinds can be set 
to 2 seconds of latency, while for a PCM that doesn't support rewinds, 
150-200 ms is more appropriate. In other words, ideally, one bit of 
information about the future full-rewind support should be available at 
the server startup without any complex dance with test audio streams. 
Ideally, even before setting hw_params, but "just after" also seems to 
be acceptable. And at this stage (before or just after setting 
hw_params), snd_pcm_rewindable() is useless, because it returns 0 even 
for the hw plugin which does support full rewinds (rightfully, because 
the card initially is just about to underrun). Therefore, if the 
solution is indeed to use snd_pcm_rewindable(), then it is needed to 
write some test data to the pcm, and only then test for rewindability.

Alternatives are below, please help choosing:

1) Use a test stream and call snd_pcm_rewindable() when there is a 
non-zero amount of data in the buffer: I don't like it. Too complex 
dance, with side effects, to get one bit of essentially-static 
information that the plugin knows for sure even before setting hw_params.

2) Use snd_pcm_forwardable() with an empty buffer just after setting 
hw_params: works (once the implementation in ioplug/extplug is fixed to 
return 0), doesn't require API additions, but David doesn't like it. He 
thinks that the sets of PCMs that support forwarding and rewinding may 
be different (here I disagree, but can't provide arguments). 
Additionally, forwarding the application pointer without writing 
anything and rewinding over that beforehand looks like undefined 
behaviour (which looks like a valid argument, but I am not 100% sure, 
and I am not actually forwarding, I am just asking how much I can forward).

3) Add a new function to ALSA that gets this bit of static information 
for a given pcm handle, use it. Drawbacks: a new function is needed, and 
it's a bad idea to send a patch that adds a new public ALSA API function 
without discussing here first (that's why the e-mail).

4) Write your own alternative here if you have one.

-- 
Alexander E. Patrakov
