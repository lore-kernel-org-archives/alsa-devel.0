From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to tell how many frames gone to PCM
Date: Wed, 27 Apr 2005 16:36:43 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0504271614590.28618-100000@studcom.urz.uni-halle.de>
References: <426EB67D.6010809@pianodisc.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <426EB67D.6010809@pianodisc.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Steve deRosier <derosier@pianodisc.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Steve deRosier wrote:
> > Another idea, by default the MIDI timing will be driven by the system
> > timer, while the PCM will be driven by the soundcard timer, even if your
> > MIDI port is on the same board as your audio.  Although I would expect
> > the drift to be very small.

Oh, you really expect the (potentially overclocked) system clock and
the cheapo sound card crystal to be accurate?  ;-)

> I should (if I did it right) have the pcm and midi timers linked.
>
>   // setup the data that links us to the PCM
>   snd_timer_id_set_class( QTID, SND_TIMER_CLASS_PCM );
>   snd_timer_id_set_sclass( QTID, SND_TIMER_SCLASS_NONE );
>   snd_timer_id_set_card( QTID, Card );
>   snd_timer_id_set_device( QTID, Device );
>   snd_timer_id_set_subdevice( QTID, SDevice );
>
>   // setup the actual timer
>   snd_seq_queue_timer_set_type( QueueTimer, SND_SEQ_TIMER_ALSA );
>   snd_seq_queue_timer_set_id( QueueTimer, QTID );
>   snd_seq_set_queue_timer( hSeq, mQueue, QueueTimer );
>
> Is that done right?  Is there something I'm forgetting to do?

You should check the error code, but otherwise this looks OK.

Are the inaccuracies you're seeing consistent, and/or dependent on
some specific hardware?


Regards,
Clemens



-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
