From: jgotts@linuxsavvy.com
Subject: Re: dxs_support detection or feature broken?
Date: Mon, 26 Jan 2004 14:08:25 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200401261908.i0QJ8PJa008547@ann-arbor.fmfts.com>
References: <s5hr7xnufbz.wl@alsa2.suse.de>
Reply-To: jgotts@linuxsavvy.com
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from ann-arbor.fmfts.com (IDENT:DjRZyQ/UUeSJF5llVps6dxCWU1qMVdeZ@fmfts.com [64.9.213.97])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA22376
	for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2004 20:09:19 +0100
In-reply-to: Your message of "Mon, 26 Jan 2004 12:20:00 +0100."
             <s5hr7xnufbz.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In message <s5hr7xnufbz.wl@alsa2.suse.de>, Takashi Iwai writes:

>At Fri, 23 Jan 2004 23:40:18 -0500,
>John Gotts wrote:

>> I have an ASUS A7V8X motherboard with a VIA VT8233 audio controller equipped
>> with SPDIF.  I have a set of digital speakers and use the SPDIF out for
>> everything possible.  (The speakers will fall back to analog if there is no
>> digital signal present.)

>> 00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audi
>o Controller (rev 50)

>> For a long time (through 1.0.0rc1) I had been using plug:spdif as my audio
>> device and aplay had no problems playing 22,050 Hz WAV files:

>> aplay -D plug:spdif <filename>.wav

>> But with 1.0.1 my speakers started playing 22,050 Hz WAV files at 48,000 Hz.

>> After reading the following thread:

>> http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg10448.html

>> I added the following line to my /etc/modules.conf:

>> options snd-via82xx dxs_support=3

>> and plug:spdif is working again.  One message says "By default snd-via82xx u
>ses
>> dxs_support=3 (except for certain known motherboards)."  Either my motherboa
>rd
>> should become unknown or this feature is not working correctly.

>well, the dxs_support detection is correct.
>the problem is that spdif doesn't support 22.5kHz but the via82xx
>driver doesn't restrict the sample rates for spdif.
>i guess 44.1khz sample can be played correctly even without "plug".

>ok, this bug should be fixed in the future...

>a workaround is to define your own pcm such as

>pcm.myspdif {
>	type plug
>	slave {
>		pcm "spdif"
>		rate 48000
>	}
>}

>and

>	% apaly -Dmyspdif 22500hz.wav

Thanks for the workaround.  Believe it or not, I used it first, but I thought
disabling dxs_support was the better workaround.  Now that I know dxs_support
works I'll define pcm.fspdif (for functional SPDIF) in my /etc/asound.conf
until the bug is fixed.

By the way, congratulations on getting version 1 out the door.  I'm glad ALSA
is now a standard Linux component.  Your hard work has not gone unappreciated.

Thanks,
John

-- 
John GOTTS <jgotts@linuxsavvy.com>  http://linuxsavvy.com/staff/jgotts


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
