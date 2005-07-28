From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Re: Volume per voices [Feature Request]
Date: Thu, 28 Jul 2005 09:57:04 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0507280943050.9785-100000@studcom.urz.uni-halle.de>
References: <42E889DD.2070808@netvigator.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42E889DD.2070808@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Raymond <rayau@netvigator.com>
Cc: alsa-devel@lists.sourceforge.net, openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org

Raymond wrote:
> In theory, and sound cards with hardware mixing can support this kind of
> volume control.
>
> au88x0 driver may provide this kind of volume control on playing PCM
> streams by using hardware mixers.
>
> However the hardware mixers are dynamically allocated in routine
> snd_vortex_pcm_hw_params(), this means that the kcontrol can be put/get
> only between snd_pcm_hw_params() (return no error) and
> snd_pcm_hw_free()/snd_pcm_close().

The driver could save the value and apply it when a stream is opened.

> Is there any flag in kcontrol which enable/disable the put/get from
> mixer application ?

Controls can be locked.

> How do the alsa mixer application get notification when a PCM stream is
> play by another alsa application ?

There are notifications when the control status changes, or when
controls are added/deleted.  (But I don't think these controls should
be added dynamically; it would be useful to know that they exist
before a PCM substream is opened.)

> There is no need for alsactl to store/restore the values of these kind
> of volume controls.

Indeed.  Most applications just get the first free substream.
Allowing the user to change 16 (or 32) different volume controls just
doesn't make sense in this context.


Regards,
Clemens



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
