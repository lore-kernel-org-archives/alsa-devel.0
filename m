From: Justin Cormack <justin@street-vision.com>
Subject: Re: hdsp vs 16bit vs dmix
Date: 12 Jan 2004 14:01:21 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1073916082.17803.12.camel@lotte.street-vision.com>
References: <3FFC41E9.3050501@boosthardware.com>
	<s5hn08yznzf.wl@alsa2.suse.de>  <3FFD7C0E.5000505@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FFD7C0E.5000505@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2004-01-08 at 15:49, Patrick Shirkey wrote:
> Takashi Iwai wrote:
> > At Thu, 08 Jan 2004 02:29:13 +0900,
> > Patrick Shirkey wrote:
> > 
> >>I am seeing strange things happen while using the hdsp and dmix plugin 
> >>and aplay as a test app.
> >>
> >>JACK works perfectly.
> >>
> >>I can get sound from aplay if I use this commandline:
> >>
> >>aplay -f cd -D plughw audio.wav
> >>Playing WAVE 'audio.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, 
> >>Stereo
> >>underrun!!! (at least 40.147 ms long)
> >>underrun!!! (at least 86.223 ms long)
> >>underrun!!! (at least 145.116 ms long)
> >>underrun!!! (at least 79.109 ms long)
> >>underrun!!! (at least 248.555 ms long)
> >>underrun!!! (at least 180.442 ms long)
> >>underrun!!! (at least 96.117 ms long)
> >>Aborted by signal Interrupt...	
> >>
> >>But I get an xrun every second or so which makes the card useless for 
> >>native alsa apps .

> Hmm. This would appear to be a problem. While I'm not ecouraging people 
> to use the hdsp as a standard consumer playback device... My customer 
> (who runs windows mostly) is expecting to be able to view videos etc 
> with this device simply because he can in his windows env. Should I be 
> encouraging him to purchase a second card or can this be fixed using ALSA?

I think it may be something else in the hardware setup, as it works fine
for me. Are the disks running dma? Is there some interrupt oddness? What
kernel is it? What kind of machine? What filesystem? The fact that it
works with JACK suggests that it is a small delay that aplay doesnt cope
with well.

Justin




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
