From: Steve deRosier <derosier@pianodisc.com>
Subject: Sync between MIDI and audio
Date: Thu, 28 Aug 2003 17:48:36 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F4EA2E4.2010902@pianodisc.com>
References: <5.1.0.14.2.20030828232924.021e2830@192.168.10.1>
Reply-To: derosier@pianodisc.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <5.1.0.14.2.20030828232924.021e2830@192.168.10.1>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I'm writting an app that plays a special format and uses both the Alsa 
seq and pcm interfaces to output MIDI and audio data together.  I'm 
almost done, but I've got one problem that is plaugeing me: I can't get 
the two to stay in sync.

Basically, what I'm doing is using writei() to send frames to the audio 
and for midi:
void SendTimeEvent( snd_seq_event_t *event, snd_seq_real_time_t *iRealTime)
{
   snd_seq_ev_set_source( event, mPort );
   snd_seq_ev_set_subs(event);
   snd_seq_ev_schedule_real(event, mQueue, 0, iRealTime );
   snd_seq_event_output(hSeq, event);
   snd_seq_drain_output(hSeq);
}

I call this with iRealTime calculated based on the number of frames I've 
sent to the audio.  I recieve the MIDI data and the audio samples in 
sync from a different portion of the program, and the time that the MIDI 
should be played at is the time that sample gets played plus a constant 
offset.

Both the MIDI and audio play just fine (the piano plays and so does the 
digital audio).

The problem: the MIDI and audio start synced up, but after a while they 
start to drift further and further apart.  I've checked my stuff 
exaustively to make sure that it's not the fault of my program, so I'm 
figuring it is caused by me not setting up something properly in alsa to 
make the two streams synced up.

Any ideas of where to look?

Thanks in advance,
- Steve



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
