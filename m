From: Guido Bakker <guido.bakker@sogeti.nl>
Subject: terratec dmx xfire 1024 ac3
Date: Wed, 15 Jan 2003 09:04:21 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301150904.21901.guido.bakker@sogeti.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hi,

i'm trying to use the optical out of my terratec dmx xfire 1024 with an ac3 
stream.

root@thebox:~/alsa/alsa-tools-0.9.0rc6/ac3dec# ./ac3dec -C test.ac3
Using PCM device 'iec958:AES0=0x2,AES1=0x82,AES2=0x0,AES3=0x2'
ALSA lib pcm.c:1719:(snd_pcm_open_conf) Invalid type for PCM 
iec958:AES0=0x2,AES1=0x82,AES2=0x0,AES3=0x2 definition (id: iec958, value: 
cards.pcm.iec958)
snd_pcm_open: Invalid argument
Output open failed

i'm getting this error, any ideas?

i'm running alsa rc6.

-- 
Guido Bakker

Interne Automatisering
Sogeti Nederland B.V.
T: +31 (0)20 660 66 00 + nakiesnummer 0281
e-mail: guido.bakker@sogeti.nl

panic("sun_82072_fd_inb: How did I get here?");
        2.2.16 /usr/src/linux/include/asm-sparc/floppy.h



-------------------------------------------------------
This SF.NET email is sponsored by: Take your first step towards giving 
your online business a competitive advantage. Test-drive a Thawte SSL 
certificate - our easy online guide will show you how. Click here to get 
started: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0027en
