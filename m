From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Only one element for multichannel mixer controls
 please!
Date: Mon, 27 Oct 2008 09:53:30 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0810270923280.12044@tm8103.perex-int.cz>
References: <20081024234932.GA17812@tango.0pointer.de>
	<s5hiqrezbyr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id C4D3A24694
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 09:53:48 +0100 (CET)
In-Reply-To: <s5hiqrezbyr.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

On Mon, 27 Oct 2008, Takashi Iwai wrote:

> And, the current smixer abstraction sucks.  Really.

Because we do not have any abstraction available at this moment. The 
smixer API is not bad itself, it's just about internal alsa-lib code and 
how to implement abstraction layers. Also, for applications using PCM 
devices we need to add two functions handling all used channels like this:

/* for PCM stream volume control */
int snd_pcm_mixer_element(snd_pcm_t *pcm, snd_mixer_t *mixer, snd_mixer_elem_t **elem);
/* for Master volume control - will not be available for recording */
int snd_pcm_mixer_master(snd_pcm_t *pcm, snd_mixer_t *mixer, snd_mixer_elem_t **elem);

My idea is to describe the correlations between PCM and mixer in the 
standard .conf files defining PCM devices.

The internal smixer interface can be extended using dynamic C library now, 
but the question is, who will write C modules for all cards. I also
prepared python interface to allow fast smixer prototyping. Another 
possibility is to create a C module which will parse a text configuration
file describing the abstaction.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
