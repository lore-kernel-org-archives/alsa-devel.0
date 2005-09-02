From: Smery <luca_ing@libero.it>
Subject: Re: Problems or bugs in snd-usb-audio.ko
Date: Fri, 2 Sep 2005 13:38:24 +0000
Message-ID: <200509021338.25330.luca_ing@libero.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

> Lee Revell wrote:
> > Pardon my ignorance but what's the point of a soundcard that only does 8
> > bit mono at 8000Hz?  VoIP?
>
> The product name ("USB 2.0 Video") seems to indicate a webcam or
> something like that.  Otherwise, using USB 2.0 for 8000 bytes/s would
> look like a _somewhat_ strange design decision. :-)

Okay. I tried the latest ALSA and I obtain the same error as above:

$ arecord -d 10 -D hw:1,0 foobar.wav
Recording WAVE 'foobar.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
arecord: pcm_read:1263: read error: Input/output error

Any other ideas? Could you also give me a starting point where to
look at in the code? I would appreciate your help and I am available
for help.

Thanks


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
