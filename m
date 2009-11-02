From: John Lindgren <john.lindgren@tds.net>
Subject: Re: [PATCH] alsa-lib: snd_device_name_hint misbehaving
Date: Mon, 02 Nov 2009 09:43:14 -0500
Message-ID: <1257172994.2856.2.camel@dark-knight>
References: <1257128586.16837.29.camel@dark-knight>
	<s5hy6mpvzus.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f210.google.com (mail-gx0-f210.google.com
	[209.85.217.210])
	by alsa0.perex.cz (Postfix) with ESMTP id 6BC8A103879
	for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2009 15:43:18 +0100 (CET)
Received: by gxk2 with SMTP id 2so4246858gxk.4
	for <alsa-devel@alsa-project.org>; Mon, 02 Nov 2009 06:43:17 -0800 (PST)
In-Reply-To: <s5hy6mpvzus.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2009-11-02 at 14:08 +0100, Takashi Iwai wrote:
> > * Remove erroneous snd_config_delete calls that cause later calls to
> > snd_pcm_open to fail.
> 
> This is bad indeed.  Could you make a small test case to reproduce the
> problem more easily?

Sure.

------

#include <stdio.h>
#include <alsa/asoundlib.h>

void try_open (const char * pcm)
{
    snd_pcm_t * handle;
    int error;

    error = snd_pcm_open (& handle, pcm, SND_PCM_STREAM_PLAYBACK, 0);

    if (error < 0)
        printf ("Failed to open %s: %s.\n", pcm, snd_strerror (error));
    else
    {
        printf ("Opened %s.\n", pcm);
        snd_pcm_close (handle);
    }
}

int main (void)
{
    void * * hints;

    try_open ("default");
    try_open ("front");
    try_open ("pulse");
    try_open ("default");
    try_open ("front");
    try_open ("pulse");

    printf ("Calling snd_device_name_hint().\n");
    snd_device_name_hint (-1, "pcm", & hints);
    snd_device_name_free_hint (hints);

    try_open ("default");
    try_open ("front");
    try_open ("pulse");
    try_open ("default");
    try_open ("front");
    try_open ("pulse");

    return 0;
}

------

$ ./pcmtest
Opened default.
Opened front.
Opened pulse.
Opened default.
Opened front.
Opened pulse.
Calling snd_device_name_hint().
Opened default.
ALSA lib pcm.c:2211:(snd_pcm_open_noupdate) Unknown PCM cards.pcm.front
Failed to open front: No such file or directory.
ALSA lib pcm.c:2211:(snd_pcm_open_noupdate) Unknown PCM pulse
Failed to open pulse: No such file or directory.
Opened default.
ALSA lib pcm.c:2211:(snd_pcm_open_noupdate) Unknown PCM cards.pcm.front
Failed to open front: No such file or directory.
ALSA lib pcm.c:2211:(snd_pcm_open_noupdate) Unknown PCM pulse
Failed to open pulse: No such file or directory.
