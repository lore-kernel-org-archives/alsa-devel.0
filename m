From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: SIS7012 SPDIF support
Date: Fri, 06 Jun 2003 22:18:11 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EE10513.9010308@superbug.demon.co.uk>
References: <3EDB74E6.3020600@superbug.demon.co.uk>	<s5hptlvo57h.wl@alsa2.suse.de>	<3EDC8553.8080902@superbug.demon.co.uk>	<s5hisrnnype.wl@alsa2.suse.de>	<3EDFEC45.6010908@superbug.demon.co.uk> <s5hvfvjk27g.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hvfvjk27g.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> 
> 
> oops, it seems like my mistake in the last change.
> 
> could you try the attached patch?
> 
> 
> Takashi

That seems to have helped. We now get sliders.
We now get ac3 and dts sound with device name
iec958:AES0=0x6,AES1=0x82,AES2=0x0,AES3=0x2
and pcm with device name
iec958:AES0=0x4,AES1=0x82,AES2=0x0,AES3=0x2

We currently get no sound with device name: -
default
front

We only have the spdif connected.
So if sound is comming out of the analogue port, we will not know about it.

It would be nice to get sound output with default and front, because 
then oss emulation and alsa's automatic resampling would also work.

The problem with the device is that if you want a 48000hz spdif out, all 
inputs have to also be 48000hz. So, if we open the device for 44100 hz 
output, it would be nice if the spdif automatically changed to 44100 hz 
as well.
Currently, sound only seems to work if you send it to the device at 
48000 hz. E.g. DVDs audio tracks.

Cheers
James



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
