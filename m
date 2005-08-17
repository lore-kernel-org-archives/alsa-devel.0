From: "Alfredo Rueda Unsain" <alfredo@vida-software.com>
Subject: Render audio data from a push source using event driven model
Date: Wed, 17 Aug 2005 20:53:32 +0200
Message-ID: <web-708262@vida-software.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello!

I'm developing a Linux server that use poll as the event
notification schema.

The server must render audio that receives from a push=20
source in real time.

When I receive a UDP Datagram (audio packet) I must render=20
the packet using write in NON BLOCKING mode.

I have read all the ALSA documentation (including the=20
examples) but I'm not sure how to proceed. The examples=20
that use poll, use the snd_pcm_sw_params_set_avail_min=20
function to specify when they want to be notified in order=20
to write audio samples without blocking.

In this sense I could use the following schema:

When I receive an audio packet, store the packet in a FIFO=20
queue.
Use snd_pcm_sw_params_set_avail_min to specify the number=20
of samples of an audio packet.
When ALSA notifies the server, consume the next packet=20
from the FIFO and write the packet.
 =20
I'm using another approach:

1. Open the PCM device (with SND_PCM_NONBLOCK flag).
2. Setup the PCM device (using=20
snd_pcm_sw_params_set_start_threshold to prefetch 3=20
packets).
3. Prepare the PCM device. (What is the purpose of=20
snd_pcm_prepare function?
	I have read the states of a PCM device but, don't=20
understand the changes between
	SETUP and PREPARED states).
4. When I receive an audio packet:
	a) If there is enough space in the audio buffer, render=20
the packet directly using snd_pcm_writei.
	b) else, drop the packet.

    The problem is that before calling snd_pcm_writei, I=20
call snd_pcm_avail_update and returns only 336 samples to=20
deliver (only 1 channel).

    The examples show that event driven programs must use=20
snd_pcm_sw_params_set_avail_min,
    but I don't understant why snd_pcm_avail_update=20
returns only 336 samples if I call snd_pcm_prepare a lot=20
of seconds before.

    What is the right approach to proceed in this=20
scenario?

    Thank you very much for your help.

     Alfredo Rueda.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
