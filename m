From: Gerald Grabner <gerald.grabner@gmx.net>
Subject: problem linking pcm timer to midi timer at SB Audigy
Date: Fri, 25 Aug 2006 17:19:17 +0200
Message-ID: <44EF14F5.5000304@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi there,

I'm having troubles with linking the pcm timer to the midi timer for a
SB Audigy. I slightly adapted the code of Steve deRosier
[http://thread.gmane.org/gmane.linux.alsa.devel/22156/focus=22160], my
function is listed below. While it works with an ES1938 card, it
doesn't with a SB Audigy: If I'm trying to record audio (generated
from a midi signal I'm sending from the same card), I only hear the
first note sent. Obviously the timing is completely wrong. The problem
doesn't occur for pcm playback.

Unfortunatly, I didn't find much documentation about cards, devices
and subdevices.
Do I have to choose a particular one for the Audigy?
Why the "SDevice = SDevice << 1;" statement?
Where can I find documentation on this topic?

My system: alsa 1.0.11, openSuSE 10.1

Any hints are highly welcome!
Thx a lot,
Gerald


bool SmSeq::LinkPCMTimer( snd_pcm_t* pcm )
{
   // get pcm info
   snd_pcm_info_t* PCMInfo;
   snd_pcm_info_alloca( &PCMInfo );
   int err = snd_pcm_info( pcm, PCMInfo );
   if( err < 0 )  return false ;

   // get the info we need
   int             Card = snd_pcm_info_get_card     ( PCMInfo );
   unsigned int  Device = snd_pcm_info_get_device   ( PCMInfo );
   unsigned int SDevice = snd_pcm_info_get_subdevice( PCMInfo );
   SDevice = SDevice << 1;  // ?
   if( ( Card < 0 ) )  return false;

   // setup the data that links us to the PCM
   snd_timer_id_t* QTID;
   snd_timer_id_alloca( &QTID );
   snd_timer_id_set_class    ( QTID, SND_TIMER_CLASS_PCM );
   snd_timer_id_set_sclass   ( QTID, SND_TIMER_SCLASS_NONE );
   snd_timer_id_set_card     ( QTID, Card );
   snd_timer_id_set_device   ( QTID, Device );
   snd_timer_id_set_subdevice( QTID, SDevice );

   // setup the actual timer
   snd_seq_queue_timer_t* QueueTimer;
   snd_seq_queue_timer_alloca( &QueueTimer );
   if( snd_seq_get_queue_timer( seq, queue, QueueTimer ) < 0 )
     return false;
   snd_seq_queue_timer_set_type( QueueTimer, SND_SEQ_TIMER_ALSA );
   snd_seq_queue_timer_set_id  ( QueueTimer, QTID );
   snd_seq_set_queue_timer( seq, queue, QueueTimer );

   return true;
}

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
