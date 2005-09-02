From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Problems or bugs in snd-usb-audio.ko
Date: Fri, 2 Sep 2005 14:07:43 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0509021401360.4226-100000@studcom.urz.uni-halle.de>
References: <200509021338.25330.luca_ing@libero.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200509021338.25330.luca_ing@libero.it>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Smery <luca_ing@libero.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Smery wrote:
> Okay. I tried the latest ALSA and I obtain the same error as above:
>
> $ arecord -d 10 -D hw:1,0 foobar.wav
> Recording WAVE 'foobar.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
> arecord: pcm_read:1263: read error: Input/output error

It seems the device doesn't actually send any data.

Please compile --with-debug=yes and see whether there are any messages
in the system log.


It may be possible that it needs some initialization in the video part
before it does anything.

> Any other ideas?

Do you have the source code of the Windows driver?  Or does the audio
part work with Microsoft's standard driver?


Regards,
Clemens



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
