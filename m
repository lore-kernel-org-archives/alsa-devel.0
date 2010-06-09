From: Daniel Mack <daniel@caiaq.de>
Subject: Re: External samplerate changes, UAC2 clock topologies
Date: Wed, 9 Jun 2010 13:30:00 +0200
Message-ID: <20100609113000.GE25445@buzzloop.caiaq.de>
References: <20100604124635.GL2698@buzzloop.caiaq.de>
	<alpine.LNX.2.00.1006042130390.5693@eeebox2.perex-int.cz>
	<20100609091628.GP2695@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A52410383C
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Jun 2010 13:30:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100609091628.GP2695@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 09, 2010 at 11:16:28AM +0200, Daniel Mack wrote:
> On Fri, Jun 04, 2010 at 09:49:36PM +0200, Jaroslav Kysela wrote:
> > If a stream parameter changes, the driver should interrupt streaming
> > immediatelly. The check should be in the trigger() callback (-EIO
> > error code) and if the stream is already running - it should be put
> > to the
> > SNDRV_PCM_STATE_DRAINING (capture) to let the application obtain the
> > captured samples until the parameter change. Just call
> > snd_pcm_stop() with the new state for the substream. For playback,
> > the stream should be put to the SNDRV_PCM_STATE_OPEN state to wait
> > to settle new parameters from an application (it means that all I/O
> > ops will return -EBADFD).
> 
> Hmm. I implemented this now, but at least aplay won't stop when this
> code path is triggered. Is there anything else I should do, except for
> calling snd_pcm_stop()?

Strange enough, aplay doesn't even quit when the device is unplugged.
Can anyone confirm this with an UAC1 device?

Daniel
