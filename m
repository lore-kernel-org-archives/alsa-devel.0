From: =?iso-8859-1?Q?Robert_Br=FCckmann?= <robert.brueckmann@stud.tu-ilmenau.de>
Subject: Re: rme9652 locks up my computer
Date: Thu, 21 Feb 2002 11:27:37 +0100
Message-ID: <004c01c1bac2$636b9060$0500a8c0@brueckmann>
References: <200202201415.JAA08796@monet.op.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Barton-Davis <pbd@Op.Net>, Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> your question about lockups doesn't really contain enough information.
> are you running with SCHED_FIFO? are you accessing both playback and
> capture streams? what else does your code do?
>

I don't know what SCHED_FIFO is, I never heard it before, so I think I don
not use it... :) Maybe someone could explain that to me ?

I am acessing the record and the play stream. Both streams are intitalized
with
48 channels,
SND_PCM_ACCESS_RW_NONINTERLEAVED,
S32_LE,
44100Hz,
buffer size=8192,
period size = 4096

The main loop looks like this (Buffers is an int** with enough memory
allocated for each channel), it's just doing an input-output-streaming:

while(1)
{
  AlsaRecord.wait();
  AlsaRecord.ReadQueue( Buffers );

  // do some arithmetic processing on the Buffers... (volscale)

  AlsaPlay.wait();
  AlsaPlay.WriteQueue( Buffers );
}

The wait() does only the following:
snd_pcm_wait( m_handle, 1000 );

Maybe the ReadQueue and WriteQueue functions are useful:

int TAlsaSoundRecord::ReadQueue( void** &Buffers )
{
  static int readn, err;

  do
    readn = snd_pcm_readn( m_handle, Buffers, m_chunk_size );
  while( readn == -EAGAIN );

  if( readn == -EPIPE )
  {
    cout << "ReadQueue: Underrun occurred! Trying recovery..." << endl;
    err = snd_pcm_prepare( m_handle );
    if( err < 0 )
    {
      cerr << "Can't recover from underrun, prepare failed: " <<
snd_strerror( err ) << endl;
      exit( 1 );
    }
    cout << "ok" << endl;
  }
  if ( readn < 0 && readn != -EPIPE )
  {
    cout << "ReadQueue: " << strerror( -readn ) << endl;
    exit( 1 );
  }
  else
    return 0;
}


int TAlsaSoundPlay::WriteQueue( void** &Buffers )
{
  static int writen, err;

  do
    writen = snd_pcm_writen( m_handle, Buffers, m_chunk_size );
  while( writen == -EAGAIN );

  if( writen == -EPIPE )
  {
    cout << "WriteQueue: Underrun occurred! Trying recovery..." << endl;
    err = snd_pcm_prepare( m_handle );
    if( err < 0 )
    {
      cerr << "Can't recover from underrun, prepare failed: " <<
snd_strerror( err ) << endl;
      exit( 1 );
    }
    cout << "ok" << endl;
  }
  if ( writen < 0 && writen != -EPIPE )
  {
    cout << "WriteQueue: " << strerror( -writen ) << endl;
    exit( 1 );
  }
  else
    return 0;
}



Sorry for the huge mail, but I have no idea where in the code I've made a
mistake...




>
> oh, and that "defective" hammerfall almost certainly had an M52 EPROM
> rather than an W52 EPROM, hence the reversed byte-order (its for big
> endian systems like the macs).
>

yes, you're right. The cards contained the M52 bios. However, the
lockup-setup described above has the W52 chips installed.

Thank you,
Robert



_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
