From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: [alsa-cvslog] CVS: alsa-kernel/pci/emu10k1 emu10k1_main.c,1.12,1.13
Date: Thu, 11 Apr 2002 15:42:23 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CB5A0CF.1000103@superbug.demon.co.uk>
References: <E16uY8V-0002TN-00@usw-pr-cvs1.sourceforge.net>
Reply-To: James@superbug.demon.co.uk
Mime-Version: 1.0
Content-Type: multipart/related;
 boundary="------------050300040202050002060901"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--------------050300040202050002060901
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:

>Update of /cvsroot/alsa/alsa-kernel/pci/emu10k1
>In directory usw-pr-cvs1:/tmp/cvs-serv9192
>
>Modified Files:
>	emu10k1_main.c 
>Log Message:
>fixed default mask values
>(these change won't affect the actual behavior, though)
>
>
>
>
>Index: emu10k1_main.c
>===================================================================
>RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c,v
>retrieving revision 1.12
>retrieving revision 1.13
>diff -u -r1.12 -r1.13
>--- emu10k1_main.c	13 Mar 2002 19:49:38 -0000	1.12
>+++ emu10k1_main.c	8 Apr 2002 12:20:36 -0000	1.13
>@@ -630,9 +630,9 @@
> 	
> 	emu->fx8010.fxbus_mask = 0x303f;
> 	if (extin_mask == 0)
>-		extin_mask = 0x1fcf;
>+		extin_mask = 0x3fcf;
> 	if (extout_mask == 0)
>-		extout_mask = 0x3fff;
>+		extout_mask = 0x1fff;
> 	emu->fx8010.extin_mask = extin_mask;
> 	emu->fx8010.extout_mask = extout_mask;
> 
>
This seems to have fixed AC3 Passthru mode on SB Live (rev 7) cards.

Just so you know, all SB Live cards worked before for AC3 Passthru 
except the rev 7 cards.

I just got a report on the xine-user list about it.
Ok, so you did not know you were fixing it, but well done anyway!!!! ;-)

Cheers
James


--------------050300040202050002060901--
