From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: External samplerate changes, UAC2 clock topologies
Date: Thu, 10 Jun 2010 08:19:41 +0200
Message-ID: <4C1083FD.9040906@ladisch.de>
References: <20100604124635.GL2698@buzzloop.caiaq.de>	<alpine.LNX.2.00.1006042130390.5693@eeebox2.perex-int.cz>	<20100609091628.GP2695@buzzloop.caiaq.de>
	<20100609113000.GE25445@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id C383D103977
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Jun 2010 08:19:47 +0200 (CEST)
In-Reply-To: <20100609113000.GE25445@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> On Wed, Jun 09, 2010 at 11:16:28AM +0200, Daniel Mack wrote:
> > On Fri, Jun 04, 2010 at 09:49:36PM +0200, Jaroslav Kysela wrote:
> > > If a stream parameter changes, the driver should interrupt streaming
> > > immediatelly. The check should be in the trigger() callback (-EIO
> > > error code) and if the stream is already running - it should be put
> > > to the
> > > SNDRV_PCM_STATE_DRAINING (capture) to let the application obtain the
> > > captured samples until the parameter change. Just call
> > > snd_pcm_stop() with the new state for the substream. For playback,
> > > the stream should be put to the SNDRV_PCM_STATE_OPEN state to wait
> > > to settle new parameters from an application (it means that all I/O
> > > ops will return -EBADFD).
> > 
> > Hmm. I implemented this now, but at least aplay won't stop when this
> > code path is triggered. Is there anything else I should do, except for
> > calling snd_pcm_stop()?
> 
> Strange enough, aplay doesn't even quit when the device is unplugged.
> Can anyone confirm this with an UAC1 device?

Unplugging works just fine (i.e., stops).

When unpluggin, the stream should go into XRUN state.

I doublt if it is allowed to go from RUNNING to OPEN, because then the
driver's hw_free callback might not be called.


Regards,
Clemens
