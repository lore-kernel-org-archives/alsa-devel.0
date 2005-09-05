From: Raymond <rayau@netvigator.com>
Subject: Re: ALSA features.
Date: Mon, 05 Sep 2005 14:00:40 +0800
Message-ID: <431BDF08.3090907@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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


I am looking for ALSA applications (signal generator and spectrum 
analyser) for measuring/calibrating the proposed au88x0 PCM volume 
control (per substream) and the existing hardware 10-bands stereo EQ 
controls on au8810/au8830 ALSA driver.

The graphic equalizer program periodically reads the EQ peaks from the 
hardware registers and display them as 20 VU meters in real-time.
There are 10 x 2 (left/right) volume control for the gain/atten of the 
10 octave bands( 31Hz, 63Hz, 125Hz, 250Hz, 500Hz, 1000Hz, 2000Hz, 
4000Hz, 8000Hz, 16000Hz)

There is no datasheet for au88x0.

Only front channels of au8810/au8830 pass through hardware mixer and the 
hardware equalizer, the rear channels of au8810/au8830 pass through 
hardware mixer only. The au8820 do not has equalizer.

The 16-bits audio data passed through the hardware mixer of au88x0 to 
18-bits DAC of AC97 codec. Any excess gain of the audio by increasing 
the hardware mixer volume cause distortion.

Based on this assumption, please correct me if I am wrong.
We assume the change of a value of 8 in hardware mixer volume is equal 
to (6dB) the gain of the 16-bits audio to 18-bits DAC.

How can I perform test to prove this assumption ?

The existing EQ controls allow us to increase/decrease the volume of 
individual bands. By decreasing all bands to zero, no sound is heard 
from the front channels and the corresponding VU meter also varies when 
changing the EQ cotnrol

How can I measure/calibrate the EQ volume controls in dB ?


Any other methods beside using signal generator/spectrum analyser ?


James Courtier-Dutton wrote:

 > Hi,
 >
 > I am an ALSA developer and I was wondering if there are any feature 
requests that people who use this list would have.
 >
 > I currently have a lot on my TODO list, but there is probably only 
one feature on that list that might help you and that is dB level 
readouts in alsamixer.
 >
 > Currently, alsamixer uses a 0-100% readout, and on some sound cards 
100% is the 0dB level, and on others the 0dB level is around 80%.
 >
 > This makes setting the capture levels rather difficult to get right 
in Ardour. Most people would want the alsamixer capture volume controls 
to all be set to 0dB and then let Ardour do any volume control.
 >
 > Any other suggestions?
 >
 > James


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
