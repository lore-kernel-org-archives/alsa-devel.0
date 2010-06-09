From: Daniel Mack <daniel@caiaq.de>
Subject: Re: External samplerate changes, UAC2 clock topologies
Date: Wed, 9 Jun 2010 11:16:28 +0200
Message-ID: <20100609091628.GP2695@buzzloop.caiaq.de>
References: <20100604124635.GL2698@buzzloop.caiaq.de>
	<alpine.LNX.2.00.1006042130390.5693@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id DA2A610382F
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Jun 2010 11:16:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1006042130390.5693@eeebox2.perex-int.cz>
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

Hi Jaroslav,

On Fri, Jun 04, 2010 at 09:49:36PM +0200, Jaroslav Kysela wrote:
> On Fri, 4 Jun 2010, Daniel Mack wrote:
> >The second issue I see is that a clock can lose its validity. A
> >real-life example is an external S/PDIF connected device which provides
> >a clock and which is suddenly disconnected. Firmwares are expected to
> >notify the host about such cases, and these messages are trivial to
> >dispatch. However, I wonder how the driver should react on this. From
> >a user's perspective, it would be best to just make the driver find
> >another clock path which reports a valid clock source endpoint, changes
> >the sample rate accordingly and continues streaming. There would be
> >a gap in the stream of course, but at least it would not kill the
> >applications or require major exception handling in userspace.
> 
> But what's better? Get a wrong stream or notify application that
> something went in a different way than settled in the parameter
> setup phase?

Well, frankly, I don't know enough about the implementation details of
the userspace part of ALSA. A 'wrong stream' is certainly unacceptable,
but is there a way to inform userspace applications about changed
parameters and maybe let libasound handle such things gracefully?

> >I wonder which approaches are actually possible to implement, which
> >details in the ALSA core would need to be extended, and so on.
> >
> >Any oppinions? Has this been done before for any other audio hardware
> >supported by ALSA?
> 
> If a stream parameter changes, the driver should interrupt streaming
> immediatelly. The check should be in the trigger() callback (-EIO
> error code) and if the stream is already running - it should be put
> to the
> SNDRV_PCM_STATE_DRAINING (capture) to let the application obtain the
> captured samples until the parameter change. Just call
> snd_pcm_stop() with the new state for the substream. For playback,
> the stream should be put to the SNDRV_PCM_STATE_OPEN state to wait
> to settle new parameters from an application (it means that all I/O
> ops will return -EBADFD).

Hmm. I implemented this now, but at least aplay won't stop when this
code path is triggered. Is there anything else I should do, except for
calling snd_pcm_stop()?

> I implemented this behaviour in pdaudiocf driver
> (sound/pcmcia/pdaudiocf) - for the capture direction.

I can't find the references here either. Can you point me to the code
maybe?

Thanks,
Daniel
