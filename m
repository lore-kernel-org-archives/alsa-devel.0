From: User for realtime audio <audiodev@ind.RWTH-Aachen.DE>
Subject: Application using ALSA-driver es-1968 for Maestro-2e: Bug or my fault?
Date: Mon, 17 Jun 2002 11:41:20 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D0DAEC0.F063CB35@ind.rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I have a question to all those who have experience with a Maestro-2e
soundcard and ALSA-applications:

I have written a realtime-capture plus playback application for realtime
signal processing algorithms. It is simply
a modification of the PCM-example.

The software did work with my old notebook including an es-1668
soundcard but with the new es-1968 device none of the possible transfer
modes function propperly.

The problem is that only parts of the buffers seem to be read correctly
for capture, for example I have the IO-read access to a 16 bit capture
device, periodsize is 64, buffersize 128 and two channels input.

The card only support non interleaved input (although only interleaved
output for playback!).

Furthermore I have one buffer for sampleinput:

    signed short inputBuffer[128];

(2 channels, 64 samples for call of snd_pcm_readn(..))

In order to use non interleaved read-function I have created the
void**-field:

    void** bufsInput[2];

for each channel and assigned the sample-buffer to each channel:

    bufsInput[0] = inputBuffer;
    bufsInput[1] = &inputBuffer[64];


In my callback-loop for audio read process I check that there are more
than 64 samples available
If so I call the read function:

    err=snd_pcm_readn(pcmDevice_capture, bufsInput, 64);

After this call err is equal 64 so everything is fine.
When dumping the received data some strange values are stored:

- sampleBuffer[0] .. sampleBuffer[15] seem to be the result from
channel1 which is still correct.
- sampleBuffer[16]..sampleBuffer[31] seem to be the result from the
other channel which is not correct anymore
(I can distinguish the channels as I am using different signals on the
two channels)
- sampleBuffer[32].. sampleBuffer[63] have not been copied. The values
in sampleBuffer BEFORE the snd_pcm_readn-call still remain unchanged!
- From sampleBuffer[64] .. sampleBuffer[127] the values from
sampleBuffer[0] .. sampleBuffer[63] are repeated.

I would expect that values from 0 to 63 contain channel1 input and
values from 64 to 127 contain other channel input..

Did I misunderstand the ALSA-API, what am I doing wrong or is there a
bug in the ALSA-driver/library for this specific application?

aplay and the pcm example do function as expected but arecord seems to
generate some clicking noise either....


System: I am using a Dell Lattitude CPH-500 notebook, SUSE linux, kernel
2.4.16 with the lowlatency patches + rtc-patch found in the
alsa-beta0.12 package. The current alsa-version however is the current
release candidate (rc1). I have also tried to use the
unpatched 2.4.18 kernel which did not lead to different results.

I d appreceate any kind of hint or other experiences with this device,
thanks in advance

Hauke


_______________________________________________________________

Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
