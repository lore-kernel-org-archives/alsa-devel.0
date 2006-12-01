From: TonTon <tonton@bdefracte.org>
Subject: snd_hda_intel and Asus F3Jv problem on 2.6.19
Date: Fri, 1 Dec 2006 22:11:03 +0100
Message-ID: <200612012211.03655.tonton@bdefracte.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

I have a problem when the module loads on my F3Jv :

Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP:
 [<ffffffff88053cd5>] :snd_hda_codec:get_input_type+0x77/0x9f

When looking at the code, there is really a problem. Code making trouble was 
introduced by patch "hda-codec - Fix mic capture with generic parser"
Details :
changeset 4486: 	e917e2de6efa
parent 4485:	dc9d57a416b5
child 4487:	c0ade5c872e4
author: 	tiwai
date: 	Wed Aug 23 18:34:06 2006 +0200
files: 	pci/hda/hda_generic.c

In file hda_generic.c, in function build_loopback_controls there is a call to 
get_input_type with NULL parameter, and in get_input_type there is :
*pinctl |= AC_PINCTL_VREF_80;

So the module crash on load on my laptop.
A simple fix can be to test if pointer is NULL, but I 'm not sure what it 
implies. The fix makes the module work (with sound), but I can't test with a 
mic (I guess it is related)

I don't know if its right or not but I have only 2 entries in the mixer, I 
have to check in Windows.

I can provide more informations if needed

Thanks
Arnaud Lech

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
