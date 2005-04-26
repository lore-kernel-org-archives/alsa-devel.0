From: Steve deRosier <derosier@pianodisc.com>
Subject: Re: How to tell how many frames gone to PCM
Date: Tue, 26 Apr 2005 14:45:33 -0700
Message-ID: <426EB67D.6010809@pianodisc.com>
References: <426EA20A.70403@pianodisc.com>	 <1114546574.8431.13.camel@mindpipe>  <426EADA7.4090200@pianodisc.com> <1114550230.8431.45.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1114550230.8431.45.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> 
> One possibility is that you are hitting an ALSA bug.  Some fixes have
> been merged since ALSA 1.0.8 for bugs that could account for the strange
> behavior.  The first thing to do is verify the problem does not appear
> with a newer ALSA.
> 

I'll have to try that.  I think we're running 1.0.4 at the moment.  We hesitate to update at this point due to most things just working (mine is the only alsa using program in the system experiencing this problem) and we have a headache every time we upgrade, but maybe it won't be so hard this time around since the API has solidified more than in earlier upgrade tries.

> Another idea, by default the MIDI timing will be driven by the system
> timer, while the PCM will be driven by the soundcard timer, even if your
> MIDI port is on the same board as your audio.  Although I would expect
> the drift to be very small.
> 
I should (if I did it right) have the pcm and midi timers linked.  I use two different classes for output, one for the PCM (called CDSP) and one for the MIDI (called CMIDIPort).  Usually this makes things simple, but linking the clocks requires pasing info back and forth between the two.  My thread does this:
---
mPCMInfo = mDSP.GetInfo();
if( !mPCMInfo )
  return false;
  
if( !mMIDIPort.LinkPCMTimer( mPCMInfo ) )
  return false;

return true;  
---

calling CDSP::GetInfo():
---
snd_pcm_info_t * CDSP::GetInfo( void )
{
  snd_pcm_info_t * PCMInfo;
  
  snd_pcm_info_malloc( &PCMInfo );
  int err = snd_pcm_info( hPCM, PCMInfo );
  if( err < 0 )
  {
    FreeInfo( PCMInfo );
    return NULL;
  }
    
  return PCMInfo;  
}
---

And to actually link the timers:
---
bool CMIDIPort::LinkPCMTimer( const snd_pcm_info_t * PCMInfo )
{
  if( !PCMInfo )
    return false;
    
  snd_seq_queue_timer_t * QueueTimer;
  snd_timer_id_t * QTID;
    
  // get the info we need
  int Card = snd_pcm_info_get_card( PCMInfo );
  unsigned int Device = snd_pcm_info_get_device( PCMInfo );
  unsigned int SDevice = snd_pcm_info_get_subdevice( PCMInfo );
  SDevice = SDevice << 1;
  // check for bad return
  if( ( Card < 0 ) ) 
    return false;
    
  // build our timers
  snd_seq_queue_timer_alloca( &QueueTimer );
  snd_timer_id_alloca( &QTID );
  
  if( snd_seq_get_queue_timer( hSeq, mQueue, QueueTimer ) < 0 )
    return false;
  
  // setup the data that links us to the PCM
  snd_timer_id_set_class( QTID, SND_TIMER_CLASS_PCM );
  snd_timer_id_set_sclass( QTID, SND_TIMER_SCLASS_NONE );
  snd_timer_id_set_card( QTID, Card );
  snd_timer_id_set_device( QTID, Device );
  snd_timer_id_set_subdevice( QTID, SDevice );


  // setup the actual timer
  snd_seq_queue_timer_set_type( QueueTimer, SND_SEQ_TIMER_ALSA );
  snd_seq_queue_timer_set_id( QueueTimer, QTID );
  snd_seq_set_queue_timer( hSeq, mQueue, QueueTimer );
  
  return true;
}
---

Is that done right?  Is there something I'm forgetting to do?



> As a last resort, you could hack the low level driver to keep track of
> the frames written to the hardware.  Add a counter to the chip structure
> and increment it in the interrupt handler.
> 
Ick.  Last resort definately.  Though I have hacked some of the drivers before, I'd just rather not; you know what I mean?  ;)  

Thanks,
- Steve



-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
