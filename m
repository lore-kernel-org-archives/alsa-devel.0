From: Steve deRosier <derosier@pianodisc.com>
Subject: Re: How to tell how many frames gone to PCM
Date: Wed, 27 Apr 2005 13:31:31 -0700
Message-ID: <426FF6A3.5050304@pianodisc.com>
References: <Pine.HPX.4.33n.0504271910000.28618-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0504271910000.28618-100000@studcom.urz.uni-halle.de>
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
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org



Clemens Ladisch wrote:
> Steve deRosier wrote:
> 
>>Clemens Ladisch wrote:
>>
>>>You should check the error code, but otherwise this looks OK.
>>
>>Error code for which function?
> 
> 
> snd_seq_set_queue_timer (it's the only nontrivial function, the others
> just set parameters for this one)
> 
> As a rule, every error code should be checked.

Agreed.  Must have missed that one; fixed, thanks.

>>Here's a question... I'd like to get the current time from both
>>the PCM and the MIDI device in order to confirm they've got the
>>clock linked. Is there a meaningful way to test that?
> 
> 
> There is no PCM time per se, you have to use the frame count as time.
> 
> A MIDI queue doesn't have its own "real time" either; whenever you use
> a "real time" timestamp you end up using the system clock.  Only the
> tick counter is synchronized to the timer interrupt.  (And no, this
> isn't documented anywhere.)
> 
> And I guess this is your problem -- it should go away if you schedule
> the MIDI events using ticks instead of real time.
> 
> The nice thing about using ticks is that you can set them up to be any
> quantity you want (in this case probably the same as one PCM frame or
> period).
> 

Interesting!  Thats a real clue for once.  Looking back over our other Alsa players, I'm noticing they're all using ticks, not real time scheduling.  Forgeting the +4/PERIOD_SIZE hack I've got in there for a moment (I must have a culmative off-by-one error somewhere), this player always seemed sloppy, where as the other player was real crisp.  Would I be guessing right that if several real-time scheduled events were supposed to go out, but built up till the tick happened, all of those would be sent out and then more events would buffer till the next tick?  

Ok, I'm changing to tick-based timing.  How do I setup my tick timing?  Is the sample code in the docs what I'm looking for?:
void set_tempo(snd_seq_t *handle)
{
        snd_seq_queue_tempo_t *tempo;
        snd_seq_queue_tempo_alloca(&tempo);
        snd_seq_queue_tempo_set_tempo(tempo, 1000000); // 60 BPM
        snd_seq_queue_tempo_set_ppq(tempo, 48); // 48 PPQ
        snd_seq_set_queue_tempo(handle, tempo);
}

Ideas of the PPQ and BPM I should use to match 1 tick to 1 frame?

Thanks,
- Steve


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
