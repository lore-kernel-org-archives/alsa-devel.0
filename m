From: Fredrik Lingvall <fl@signal.uu.se>
Subject: Aliasing on ALi5451
Date: Sat, 24 May 2003 10:18:17 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3ECF2AC9.8070503@signal.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hi!

I've tried to do loadspeaker identification using the ALi5451 chipset
in my laptop. I saw a strong drop in the spectrum above ~2kHz when
a ran the ADC:s at 44100 (I used a high quality microphone and a mic
pre-amp). I then wired the audio output directly to the input with
the same result - strong attenuation above 2kHz (I used wideband
white noise as identication signal). Then I generated a chirp signal
(5 sec sine sweep from 0-24kHz using Matlab) at 48kHz sampling rate
which I recorded using Audacity at 8, 44.1, and 48 kHz. There was
clearly freqeuency folding (aliasing) for all sampling freqs except 48 kHz
(see the time-freq plot at: 
http://www.signal.uu.se/Staff/fl/chirp_test.jpg).

 From the specs of the cs4299 chip (used in ALi 5451) it allways runs
at 48 kHz and uses sample rate converters for the other sampling freqs.
However, the anti-aliasing filters (if there are any) do not seem to adapt
when changing sampling freq. I also checked

cat /proc/asound/5451/pcm0p/sub0/hw_params

and

cat /proc/asound/5451/pcm0c/sub0/hw_params

when playing/recording and the sampling freqs. was correct.
Is this a driver issue or is it just a bad sound chip?

Regards

Fredrik




-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
