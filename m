From: Julia Lawall <julia@diku.dk>
Subject: question about sound/pci/ctxfi/ctpcm.c
Date: Mon, 8 Nov 2010 17:58:10 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1011081753110.21375@pc-004.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	by alsa0.perex.cz (Postfix) with ESMTP id 8943524457
	for <alsa-devel@alsa-project.org>; Mon,  8 Nov 2010 17:58:13 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.de, tj@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The file sound/pci/ctxfi/ctpcm.c contains the functions 
ct_pcm_playback_open and ct_pcm_capture_open that contain the following 
pattern of code:

        runtime->private_data = apcm;
	...
	if (err < 0) {
                kfree(apcm);
                return err;
        }

I wonder if this leaves a dangling pointer to apcm in runtime?
The function ct_atc_pcm_free_substream on the other hand does set the 
private_data field to NULL after freeing apcm.  But perhaps there is 
something in the calling context of open that ensures that if the open 
function fails, the private_data field of runtime will never be used?  

thanks,
julia
