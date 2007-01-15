From: Vladimir Pouzanov <farcaller@gmail.com>
Subject: Re:
	=?utf-8?q?snd=5Fhda=5Fintel_and_Asus_F3Jv_problem_on?=
	=?utf-8?q?_2=2E6=2E19?=
Date: Mon, 15 Jan 2007 13:24:50 +0000 (UTC)
Message-ID: <loom.20070115T142222-93@post.gmane.org>
References: <200612012211.03655.tonton@bdefracte.org>
	<s5hbqlxryek.wl%tiwai@suse.de>
	<200612212300.06635.tonton@bdefracte.org>
	<200701061558.58965.tonton@bdefracte.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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

TonTon <tonton <at> bdefracte.org> writes:

> Finally no combination works. I make further investigation with model 
> asus-laptop, but I think the problem is related to num_steps reported for 
> many mixer controls (even if it was working in kernel alsa version).
> So no way to launch alsamixer to control volume.

I've discovered the same problem with ASUS F3T notebook. snd-hda-intel loads ok
(and seems to autodetect notebook as asus-laptop) but I get Invalid argument and
hda_codec: num_steps = 0 for NID=0x15 in dmesg when trying to start
alsamixer/amixer.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
