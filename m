From: Rafal Dejewski <lardel@interia.pl>
Subject: Re: Ali5451 on HP VT6200 notebook not working
Date: Fri, 29 Nov 2002 11:47:25 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200211291147.25551.lardel@interia.pl>
References: <200211211230.00392.lardel@interia.pl> <200211291119.41218.lardel@interia.pl> <s5h3cpkzn22.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3cpkzn22.wl@alsa2.suse.de>
Content-Disposition: inline
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

On Friday 29 November 2002 11:29, you wrote:
> At Fri, 29 Nov 2002 11:19:40 +0100,
>
> looking at the code, ali5451 driver access the following three pci
> devices:
>
> 10b9:5451	ali5451 main chip
> 10b9:1533	pci southbridge, used for ac97 codec
> 10b9:7107	power management controller (which you don't have..)
            ^^^^
Shouldn't that be 10b9:7101?
>
> please check the latter two devices and whether you have different
> ones with the same functions.
Here is mine 'lspci -n':

0:00.0 Class 0600: 10b9:1671 (rev 02)
00:01.0 Class 0604: 10b9:5247
00:02.0 Class 0c03: 10b9:5237 (rev 03)
00:04.0 Class 0401: 10b9:5451 (rev 02)
00:06.0 Class 0680: 10b9:7101
00:07.0 Class 0601: 10b9:1533
00:08.0 Class 0200: 10ec:8139 (rev 10)
00:09.0 Class 0280: 1260:3873 (rev 01)
00:0a.0 Class 0607: 104c:ac50 (rev 02)
00:0b.0 Class 0780: 125d:2838 (rev 01)
00:0f.0 Class 0101: 10b9:5229 (rev c4)
01:00.0 Class 0300: 1002:4c59

Rafal

----------------------------------------------------------------------
Niedorobki w 2. czesci Harry Pottera >>> http://link.interia.pl/f169d 




-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
