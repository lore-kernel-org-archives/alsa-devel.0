From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Problems or bugs in snd-usb-audio.ko
Date: Thu, 01 Sep 2005 00:11:52 -0400
Message-ID: <1125547912.19563.74.camel@mindpipe>
References: <200508311926.05577.luca_ing@libero.it>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200508311926.05577.luca_ing@libero.it>
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
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Wed, 2005-08-31 at 19:26 +0000, Smery wrote:
> When recording, it seems there are I/O problems:
> $ arecord -d 10 -D hw:1,0 foobar.wav
> Recording WAVE 'foobar.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
> arecord: pcm_read:1196: read error: Input/output error
> 
> And the file is 44 bytes (just the header):
> 
> $ls -l foobar.wav
> -rw-r--r--  1 luca luca 44 31 ago 19:12 foobar.wav 

Because your device probably doesn'y support 8 bit mono at 8000Hz, which
is the default format of arecord.  Use -D plughw:1,0 or specify a format
your device supports.

Lee



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
