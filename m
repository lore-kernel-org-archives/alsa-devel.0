From: "Kalvas, Taneli" <taneli.v.m.kalvas@jyu.fi>
Subject: RawMIDI behaviour with MidiFace 4x4
Date: Sat, 7 Mar 2015 17:26:43 +0000
Message-ID: <6A72E9C91650BD49A6D9B305755BC04C42D801FA@mbs1.ad.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from posti5.jyu.fi (posti5.jyu.fi [130.234.4.34])
 by alsa0.perex.cz (Postfix) with ESMTP id 700222605D3
 for <alsa-devel@alsa-project.org>; Sat,  7 Mar 2015 18:26:52 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by posti5.jyu.fi (8.13.8/8.13.8) with ESMTP id t27HQpsC021557
 for <alsa-devel@alsa-project.org>; Sat, 7 Mar 2015 19:26:51 +0200
Received: from posti5.jyu.fi ([127.0.0.1])
 by localhost (posti5.jyu.fi [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id In7kWyxPQBTW for <alsa-devel@alsa-project.org>;
 Sat,  7 Mar 2015 19:26:51 +0200 (EET)
Received: from exmail.jyu.fi (cas1.ad.jyu.fi [130.234.8.8])
 by posti5.jyu.fi (8.13.8/8.13.8) with ESMTP id t27HQoJF021552
 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK)
 for <alsa-devel@alsa-project.org>; Sat, 7 Mar 2015 19:26:51 +0200
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dear All,

I am developing a patch librarian for a synthesizer. Because the communicat=
ion happens with Midi sysex and timing is not relevant I chose RawMIDI inte=
rface and not the alsa sequencer. The problem I have encountered is that wr=
iting to the midi port with snd_rawmidi_write() seems to broken. The functi=
on accepts any size of data block and claims to have sent everything. In re=
ality only a part of the message is sent. For a large block size I can see =
the activity light blinking for fraction of a second. This happens both in =
blocking and non-blocking mode. I would expect the snd_rawmidi_write() to a=
ccept only a part of the message. =


My hardware is Miditech Midiface 4x4, a USB midi interface:
$ cat /proc/asound/cards
 0 [PCH            ]: HDA-Intel - HDA Intel PCH
                      HDA Intel PCH at 0xe0610000 irq 45
 1 [MIDI4x4        ]: USB-Audio - MIDI4x4
                      MIDIPLUS MIDI4x4 at usb-0000:00:14.0-1, full speed
usbid: 1acc:1a0b

My alsa is quite recent (aplay shows version 1.0.27.2), I am running Ubuntu=
 with 3.13.0-39-generic kernel.

I have tested the system by connecting the output port to an input port on =
the hardware and having another program output the received bytes on stdout=
. My observations:
- As long as the buffer size is 276 bytes or less it gets sent ok
- Larger buffer sizes cause corruption and roughly 300 bytes of received.
- Alsa reports midi ring buffer size of 4096.
- snd_rawmidi_status_get_xruns() on both ends reports 0 errors.
- If I write N=3D128 byte blocks and usleep for 352*N after each write, eve=
rything works ok.

Is this due to hardware incompatibility with alsa driver or what is going o=
n? Is there a way to connect two programs via a virtual RawMIDI port so tha=
t I could test without using the hardware? Any other diagnostics that I cou=
ld do?

My test programs:

write.cpp:
int main( void )
{
    int intstatus;
    snd_rawmidi_t *midiout;

    if( (intstatus =3D snd_rawmidi_open(NULL, &midiout, "hw:1,0,1", 0)) ) {
	std::cerr << "unable to open MIDI out port: " << snd_strerror(intstatus) <=
< "\n";
	exit( 1 );
    }

    int N =3D 3000; // 276 bytes gets through ok.
    unsigned char msg[N];
    for( int a =3D 0; a < N; a++ ) {
	msg[a] =3D a % 0x80;
    }
    msg[0] =3D 0xF0;
    msg[N-1] =3D 0xF7;

    ssize_t wrstatus;
    if( (wrstatus =3D snd_rawmidi_write(midiout, msg, N)) < 0 ) {
	std::cerr << "unable to write MIDI port: " << snd_strerror(wrstatus) << "\=
n";
	return( -1 );
    }
    std::cout << "write status =3D " << wrstatus << "\n";
    if( (intstatus =3D snd_rawmidi_drain( midiout )) ) {
	std::cerr << "unable to drain: " << snd_strerror(intstatus) << "\n";
	exit( 1 );
    }

    // Sleep for the amount of time needed for transfer + 10 % extra + 100 =
ms
    usleep( 352*N + 100000 );

    snd_rawmidi_status_t *stat;
    snd_rawmidi_status_malloc( &stat );
    snd_rawmidi_status( midiout, stat );
    int err =3D snd_rawmidi_status_get_xruns( stat );
    std::cout << "xruns =3D " << err << "\n";

    snd_rawmidi_close( midiout );

    return( 0 );
}

--------------------
read.cpp:
bool quit =3D false;

void signal_int( int )
{
    quit =3D true;
}

int main( void )
{
    int mode =3D SND_RAWMIDI_NONBLOCK;
    int intstat;
    std::string portname =3D "hw:1,0,0";
    //std::string portname =3D "virtual";
    snd_rawmidi_t* midiin;

    if( (intstat =3D snd_rawmidi_open(&midiin, NULL, portname.c_str(), mode=
)) < 0 ) {
	std::cerr << "unable to open MIDI port " << portname << ": " << snd_strerr=
or(intstat) << "\n";
	exit( 1 );
    }

    int count =3D 0;
    unsigned char buf[1];

    std::cout << std::dec << std::setfill(' ') << std::setw(6) << count << =
"   ";

    signal( SIGINT, signal_int );

    while( !quit ) {
	int read =3D snd_rawmidi_read( midiin, buf, 1 );
	if( read =3D=3D 0 || read =3D=3D -EBUSY || read =3D=3D -EAGAIN ) {
	    usleep( 320 );
	    continue;
	}
	else if( read < 0 ) {
	    std::cerr << "unable to read MIDI port" << portname << ": " << snd_str=
error(read) << "\n";
	    exit( 1 );
	}

	std::cout << std::hex << std::setfill('0') =

		  << "0x" << std::setw(2) << (int)buf[0] << " "
		  << std::flush;
	count++;
	if( count % 8 =3D=3D 0 ) {
	    std::cout << "\n";
	    std::cout << std::dec << std::setfill(' ') << std::setw(6) << count <<=
 "   "
		      << std::flush;	    =

	}
    }

    snd_rawmidi_status_t *stat;
    snd_rawmidi_status_malloc( &stat );
    snd_rawmidi_status( midiin, stat );
    int err =3D snd_rawmidi_status_get_xruns( stat );
    std::cout << "\nxruns =3D " << err << "\n";
	=

    snd_rawmidi_close( midiin );

    return( 0 );
}

Thanks.
Taneli

-- =

Taneli Kalvas
Ph.D., Researcher
Department of Physics, room FL114
P.O. Box 35 (YFL)
40014 University of Jyv=E4skyl=E4, Finland
Mobile: +358-44-314-1602
Fax:    +358-14-617-411
Email:  taneli.kalvas@jyu.fi =
