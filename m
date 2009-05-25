From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Third time: Unlink PCM resource ?
Date: Mon, 25 May 2009 20:09:08 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0905252006020.4067@eeebox2.perex-int.cz>
References: <4A1AB98B.9010604@yellowcouch.org> <s5hk54589xd.wl%tiwai@suse.de>
	<4A1ADAEF.3070803@yellowcouch.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 23D1524477
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 20:09:09 +0200 (CEST)
In-Reply-To: <4A1ADAEF.3070803@yellowcouch.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Werner Van Belle <werner@yellowcouch.org>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 25 May 2009, Werner Van Belle wrote:

> I agree, but when one forks off a child the parent pcm handle
> automatically passes to the child. If there is a possibility _not_ to
> pass the PCM handle to the forked process then I would be quite happy as
> well.

Do you call close() for all opened file descriptors associated to 
snd_pcm_t handle in child process?

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
