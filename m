From: Florian Demski <fdemski@users.sourceforge.net>
Subject: substream->private_data == NULL in hw_params
Date: Tue, 17 Jul 2007 03:00:44 +0200
Message-ID: <469C14BC.1000606@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174])
	by alsa0.perex.cz (Postfix) with ESMTP id 2688324346
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Jul 2007 03:00:47 +0200 (CEST)
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

Hi there,

after many reboots I finally fixed an error in a driver but I am not 
sure if there ain't an underlying problem which causes this error.

The initialization is done with

        struct snd_pcm *pcm;
        int err;

        if((err = snd_pcm_new(chip->pod->line6.card, (char 
*)chip->pod->line6.devname, 0, 1, 1, &pcm)) < 0)
                return err;

        pcm->private_data = chip;
        pcm->private_free = pod_cleanup_pcm;
        chip->pcm = pcm;

However in hw_param, substream->private_data is NULL and I have to get 
the right value with this construct:

static int snd_pod_capture_hw_params(struct snd_pcm_substream 
*substream, struct snd_pcm_hw_params *hw_params)
{
        int ret;
        struct snd_pod_pcm *chip = snd_pcm_substream_chip(substream);

        /* -- Florian Demski [FD] */
        /* don't ask me why, but this fixes the bug on my machine */
        if ( chip == NULL ) {
                if ( substream->pcm == NULL )
                        return -ENOMEM;
                if ( substream->pcm->private_data == NULL )
                        return -ENOMEM;
                substream->private_data = substream->pcm->private_data;
                chip = snd_pcm_substream_chip( substream );
        }
        /* -- [FD] end */

Somehow only my machine produces this error, I tried switching off SMP 
and PREEMPT, but with no other result.

Or is this possibly an (undocumented) feature in alsa?

I'd be happy if actually some of you experienced guys might take a look 
at that driver:

SVN
https://line6linux.svn.sourceforge.net/svnroot/line6linux/driver/trunk

Browse
https://line6linux.svn.sourceforge.net/viewvc/line6linux/driver/trunk/

Thanks in advance,

Florian
