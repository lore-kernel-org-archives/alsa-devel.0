From: Steve deRosier <derosier@pianodisc.com>
Subject: Re: How to tell how many frames gone to PCM
Date: Wed, 27 Apr 2005 09:56:40 -0700
Message-ID: <426FC448.9050609@pianodisc.com>
References: <Pine.HPX.4.33n.0504271614590.28618-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0504271614590.28618-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Steve deRosier wrote:
> 
>>>Another idea, by default the MIDI timing will be driven by the system
>>>timer, while the PCM will be driven by the soundcard timer, even if your
>>>MIDI port is on the same board as your audio.  Although I would expect
>>>the drift to be very small.
> 
> 
> Oh, you really expect the (potentially overclocked) system clock and
> the cheapo sound card crystal to be accurate?  ;-)
> 
Nope.  Though, in our case not overclocked but with other issues, see below...

> 
>>I should (if I did it right) have the pcm and midi timers linked.
>>
>>  // setup the data that links us to the PCM
>>  snd_timer_id_set_class( QTID, SND_TIMER_CLASS_PCM );
>>  snd_timer_id_set_sclass( QTID, SND_TIMER_SCLASS_NONE );
>>  snd_timer_id_set_card( QTID, Card );
>>  snd_timer_id_set_device( QTID, Device );
>>  snd_timer_id_set_subdevice( QTID, SDevice );
>>
>>  // setup the actual timer
>>  snd_seq_queue_timer_set_type( QueueTimer, SND_SEQ_TIMER_ALSA );
>>  snd_seq_queue_timer_set_id( QueueTimer, QTID );
>>  snd_seq_set_queue_timer( hSeq, mQueue, QueueTimer );
>>
>>Is that done right?  Is there something I'm forgetting to do?
> 
> 
> You should check the error code, but otherwise this looks OK.
> 
Error code for which function?  It's been a long time since I wrote the code and frankly I'm not 100% sure I understand it anyway.

> Are the inaccuracies you're seeing consistent, and/or dependent on
> some specific hardware?
Doubtful.  And not dependent uppon a particular Alsa version either (though I'm in the process of upgrading my Alsa to 1.0.9rc2 in order to get current and eliminate that concern).  See, we've got another player on the system (let's call it a "file player") that plays in sync just fine, but my program ("CD player" if you will) won't.  Now, since mine came second, much of the Alsa functionality was modeled off the "file player" so they are very similar in Alsa specifics (though hugely different in structure, purpose, and archetecture).

Here's a question... I'd like to get the current time from both the PCM and the MIDI device in order to confirm they've got the clock linked. Is there a meaningful way to test that?

Thanks,
- Steve




-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
