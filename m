From: "Alfredo" <alfredo@vida-software.com>
Subject: RE: ALSA and event notification schemas
Date: Tue, 26 Jul 2005 12:01:29 +0200
Message-ID: <556ae218255879489b506f4875747bd3@vida-software.com>
References: <173aae3c245ec34e87728c0c2f8f5b51@vida-software.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <173aae3c245ec34e87728c0c2f8f5b51@vida-software.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hello! I have been reading poll manpage and interrupt driven example
program from an alsa manual at
http://equalarea.com/paul/alsa-audio.html#interruptex

//-----------------------------------------------------------
// This is a fragment of the code

(...)

while (1) {
	
		/* wait till the interface is ready for data, or 1
second
			   has elapsed.
		*/
	
		if ((err =3D snd_pcm_wait (playback_handle, 1000)) < 0) {
			 fprintf (stderr, "poll failed (%s)\n", strerror
(errno));
			 break;
		}

		(...)	           	
			
		if (playback_callback (frames_to_deliver) !=3D
frames_to_deliver) 		{
			      fprintf (stderr, "playback callback
failed\n");
				break;
		}
}

//----------------------------------------------------------------------

I see, as you mention before, that snd_pcm_wait() uses poll() internally
to notify audio events.

If I want to use libevent (wich internally uses select or poll) as the
core of my event notification system, how can I know which file
descriptor represents the audio interface? In this example, snd_pcm_wait
is used, but I can't use this kind of api because the thread must handle
other kind of events.

Thank you very much for your support.




-----Original Message-----
From: Alfredo [mailto:alfredo@vida-software.com] 
Sent: martes, 26 de julio de 2005 9:47
To: 'alsa-devel@lists.sourceforge.net'
Subject: RE: [Alsa-devel] ALSA and event notification schemas


Thank you for your answers.
I have studied Unix/Linux theory, and have a good knowledge base about
the underlaying principles of this kind of OS. The problem is that I
need some help in my first steps because I don't have a lot of practise.


I have read the manuals about ALSA, but have not found enough
information about the callback mechanism.
The way I must handle the audio is simple:
a) Play audio buffers that the component receives from the media network
protocol. 
	Using a simple prebuffering schema:
	When I receive more or less 3 buffers start playing the audio
(Push approach).
	The difficulty is that the audio buffers are encoded using AMR
or GSM format, so transcoding process is needed.
	How can I implement this transcoding process in Linux/ALSA
environment?
	In the other hand, I know that in other OS I don't have to worry
about event notifications when playing the audio. The media network
protocol handle the socket event and pushes the audio buffer to the
audio component. Then, the audio component uses a multimedia api to
prepare and play the audio buffer. The thread don't need to block and
don't have to worry about event notifications from the multimedia
library (assuming you drop the packets when buffers are full).

b) Record audio buffers from the microphone and transfer the buffers
using the media network protocol.
	In this case is necessary to receive events notification. The
event is: "When the next buffer is filled with audio from the micro,
notify the thread. The thread awakes from the event loop to handle the
event: performs the encoding to AMR o GSM and then transmits the buffer
to the media network protocol. 
	Is there any way to implement such scenario in Linux/ALSA
environment?
	Where can I find some code examples that use ALSA api in this
way?
	I know that you suggested poll(), but I'm a bit lost ;-)

Sorry about the extension of the mail.
I need some feedback about my way of using the mailing list. These are
my first steps! 

Thank you very much!


-----Original Message-----
From: aezr4@studcom.urz.uni-halle.de
[mailto:aezr4@studcom.urz.uni-halle.de] On Behalf Of Clemens Ladisch
Sent: martes, 26 de julio de 2005 8:17
To: Alfredo
Cc: alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] ALSA and event notification schemas

Alfredo wrote:
> Hello, I'm involved in a development project consisting of a
> multimedia/networked component using event driven model in a C++ Linux
> environment (1 thread than manages all the events using an event
loop).
>
> The events that the component must handle are:
>
> 1. Sockets events.
>
> 2. Timer events.
>
> 3. Audio events ( event =3D when the next buffer is filled with audio
from
> the user, notify the component. Then the component will transfer the
> audio buffer using a udp socket to another distributed component).
>
> 4. Key press and release events (Push To Talk key)
>
> What is the best way to handle all this events in a Linux environment?

poll()

> I have found that libevent is a very interesting library:
> http://www.monkey.org/~provos/libevent/
>
> "The libevent API provides a mechanism to execute a callback function
> when a specific event occurs on a file descriptor or after a timeout
has
> been reached".
>
> This resolves the sockets and timer events. I'm not sure if this
> approach works well with ALSA (for audio events).

The above page says that libevent supports poll().

> Another question: Does ALSA support AMR or GSM codecs?

There is no such built-in codec.


HTH
Clemens






-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
