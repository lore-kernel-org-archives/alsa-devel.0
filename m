From: Giuliano Pochini <pochini@shiny.it>
Subject: period crossing page boundary
Date: 19 Mar 2003 12:24:30 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1048076671.1382.47.camel@Jay>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


I'm facing another *=A3%@ problem. When period size is a multiple or
submultiple of PAGE_SIZE, it works fine, but when it isn't, sound
clicks, pops, repeapeapeats, skps :(( And since the period never crosses
physically the page boundary because I split it when it happens, I can't
imagine what's wrong. Perhaps some of you had the same problem.

.period callback does this:

bufsize=3Dsubstream->runtime->periods*substream->runtime->period_size;
//addr=3D=3Dnumber of bytes transferred.
pos=3Dbytes_to_frames(substream->runtime, addr);
return(pos%bufsize);

Here is a log of sg list construction:

AddX=3Dperiod n
pa=3Dpage addr
phy=3Dsnd_sgbuf_get_addr(sgbuf, offs)
sz=3Dsub-period size

aplay -B139319 -F69660 (OK)
pcm_hw_params (bufsize=3D24576 periods=3D2 persize=3D12288)
pcm_hw_params table size=3D131072 pages=3D32
pcm_hw_params Add0 (off=3D0 pa=3Df3ff000 phy=3Df3ff000 sz=3D4096)
pcm_hw_params Add0 (off=3D4096 pa=3Df3fe000 phy=3Df3fe000 sz=3D4096)
pcm_hw_params Add0 (off=3D8192 pa=3Df3fd000 phy=3Df3fd000 sz=3D4096)irq
pcm_hw_params Add1 (off=3D12288 pa=3Df3fc000 phy=3Df3fc000 sz=3D4096)
pcm_hw_params Add1 (off=3D16384 pa=3Df417000 phy=3Df417000 sz=3D4096)
pcm_hw_params Add1 (off=3D20480 pa=3Df416000 phy=3Df416000 sz=3D4096)irq
pcm_hw_params End (off=3D24576 rest=3D0)

aplay -B139319 -F34830 (noise-party)
pcm_hw_params (bufsize=3D24576 periods=3D4 persize=3D6144)
pcm_hw_params table size=3D131072 pages=3D32
pcm_hw_params Add0 (off=3D0 pa=3Df3ff000 phy=3Df3ff000 sz=3D4096)
pcm_hw_params Add0 (off=3D4096 pa=3Df3fe000 phy=3Df3fe000 sz=3D2048)irq
pcm_hw_params Add1 (off=3D6144 pa=3Df3fe000 phy=3Df3fe800 sz=3D2048)
pcm_hw_params Add1 (off=3D8192 pa=3Df3fd000 phy=3Df3fd000 sz=3D4096)irq
pcm_hw_params Add2 (off=3D12288 pa=3Df3fc000 phy=3Df3fc000 sz=3D4096)
pcm_hw_params Add2 (off=3D16384 pa=3Df417000 phy=3Df417000 sz=3D2048)irq
pcm_hw_params Add3 (off=3D18432 pa=3Df417000 phy=3Df417800 sz=3D2048)
pcm_hw_params Add3 (off=3D20480 pa=3Df416000 phy=3Df416000 sz=3D4096)irq
pcm_hw_params End (off=3D24576 rest=3D0)


Bye.




-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
