From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Pls don't require exclusive Alsa audio device
 access, use snd_pcm_dmix_open ()
Date: Wed, 28 Nov 2007 10:17:09 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0711281014180.8244@tm8103.perex-int.cz>
References: <471FE2A7.9080309@googlemail.com> <47201223.5050304@googlemail.com>
	<474D2F8A.9090001@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 71D002480F
	for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2007 10:17:10 +0100 (CET)
In-Reply-To: <474D2F8A.9090001@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: thomas schorpp <thomas.schorpp@googlemail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Ekiga-devel-list@gnome.org
List-Id: alsa-devel@alsa-project.org

On Wed, 28 Nov 2007, thomas schorpp wrote:

> > +    if (_snd_pcm_dmix_open (&os_handle, real_device_name, snd_config_t* 
> > root, snd_config_t* sconf, stream, SND_PCM_NONBLOCK) < 0) {

Uff. It's really wrong. What you're trying to do? Simply use 'default' 
device name for snd_pcm_open() which should have defined dmix access if 
required. And don't forget to allow specify (force) ALSA device name to 
users if someone wants a special setup.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project
