From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: SIS7012 SPDIF support
Date: Fri, 06 Jun 2003 02:20:05 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EDFEC45.6010908@superbug.demon.co.uk>
References: <3EDB74E6.3020600@superbug.demon.co.uk>	<s5hptlvo57h.wl@alsa2.suse.de>	<3EDC8553.8080902@superbug.demon.co.uk> <s5hisrnnype.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050205050309040507060202"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hisrnnype.wl@alsa2.suse.de>
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

This is a multi-part message in MIME format.
--------------050205050309040507060202
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> 
> 
> thanks.   looking at the codes, it seems that no special handling for
> the chip.  it simply sets up the ac97 registers.
> 
> the patch below is a quick hack to set the spdif rate on the first
> playback pcm device.  in addition, you'll need to set up the following
> mixer controls:
> 
> - 'IEC958 AC97-SPSA' to 0 (slots 3/4).
> - 'IEC958 Playback Switch' to on.
> 
> you might need to set up 'IEC958 Playback Default', too, but it might
> not...  try once the above two switches at first.
> 
> 
> Takashi

I have done some further investigation, and have discovered the type of 
ac97 chip used.
I attach output from the ac97#0regs /proc/asound/card0 file.
Here is the url to download datasheets of the chip.
It is an ALC650 Chip.
http://www.realtek.com.tw/downloads/downloads1-3.aspx?lineid=5&famid=All&series=8&refdesign=True

 From my analysis, I think that we should be setting bit 2 of register 
0x2a to get SPDIF out.
Is it possible to set this via alsamixer, or do I now have to open the 
device with a particular name, e.g. 
iec958:AES0=0x6,AES1=0x82,AES2=0x0,AES3=0x2

The chip can set non-audio bits etc, so we should really be able to 
support opening with the iec958:...etc. name.

If you think I am on the right lines here, then what functions do we 
have to add to get it to parse iec958 lines correctly.

Cheers
James

--------------050205050309040507060202
Content-Type: text/plain;
 name="ac97-regs"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ac97-regs"

0:00 = 5980
0:02 = 9f1f
0:04 = 0000
0:06 = 801f
0:08 = 0000
0:0a = 801e
0:0c = 801f
0:0e = 801f
0:10 = 9f1f
0:12 = 9f1f
0:14 = 9f1f
0:16 = 9f1f
0:18 = 9f1f
0:1a = 0000
0:1c = 0000
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 05c7
0:2a = 05c1
0:2c = bb80
0:2e = bb80
0:30 = bb80
0:32 = bb80
0:34 = 0000
0:36 = 9f80
0:38 = 9f9f
0:3a = 2000
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0000
0:5e = 0000
0:60 = 0000
0:62 = 0000
0:64 = 0808
0:66 = 0808
0:68 = 0000
0:6a = 0000
0:6c = 0000
0:6e = 0014
0:70 = 0211
0:72 = 00a0
0:74 = 0043
0:76 = 0001
0:78 = 0102
0:7a = 57c6
0:7c = 414c
0:7e = 4720

--------------050205050309040507060202--



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
