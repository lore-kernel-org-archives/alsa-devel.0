From: James Huk <huk256@gmail.com>
Subject: snd_pcm_meter_get_rate() (and other meter functions) -
 can it be used in user applications?
Date: Mon, 14 Nov 2011 22:03:04 +0100
Message-ID: <CAG17MRyYDyD1b2FBZKNTFUp2y79HYgzop6=zPdA+xUuYOeeWqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id E90C7243A3
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2011 22:03:06 +0100 (CET)
Received: by faaa20 with SMTP id a20so6123532faa.38
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2011 13:03:06 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello everybody.

I'm trying to understand how to add a sound meter that would monitor
sound  level on certain channel defined in .asoundrc (like ameter
does). I think I should use snd_pcm_meter... however, if I try to use
this simple test program:

#include <stdio.h>
#include <alsa/asoundlib.h>

snd_pcm_t *pcm;
snd_pcm_scope_t *scope;

int main()
{
	int err=snd_pcm_open(&pcm, "meter-x", SND_PCM_STREAM_PLAYBACK,0);
	snd_pcm_scope_malloc(&scope);
	snd_pcm_meter_add_scope(pcm, scope);
	snd_pcm_meter_get_rate(pcm);
	return 0;	
}

I get:

pcm_meter.c:906: snd_pcm_meter_get_rate: Assertion
`meter->gen.slave->setup' failed.

I don't understand why - is it because snd_pcm_meter functions can
only be used in external plugins, and not in user applications (since
similar construction works fine with ameter...), or did I missed
something?

Thanks in advance.
