From: "Jaap Struyk" <japie@deserver.nl>
Subject: Re: problems with via82xx alsa part
Date: Fri, 6 Oct 2006 08:02:24 +0000 (UTC)
Message-ID: <eg52ig$bn1$1@sea.gmane.org>
References: <ef3pll$kng$1@sea.gmane.org> <efos3e$g63$1@sea.gmane.org>
	<s5hwt7ghsxd.wl%tiwai@suse.de>
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

Op Wed, 04 Oct 2006 19:50:06 +0200, schreef Takashi Iwai:

> Did you check the device permission?
> Well, but it shouldn't be a problem since it was opened but the hw
> parmas fails.  Could you check via strace to see what happens?
> 
> Also, what is your system / architecture?  x86-64 and 32bit
> compatibility problem?

Both machines are AMD 32bit, running clfs-1.0, /dev is mounted on a tmp
filesystem with udev and the problem machine is an identical (software)
copy of the one functioning properly.
I've notisched that on the problem machine /dev/adsp is missing so aplay
bailing out isn't odd, but adsp missing is strange since the kernels are
identical too.
To rule out an broken mainboard I've tryed an ES1371 card with excactly
the same problems, /dev/dsp working but no /dev/adsp so it seems not to be
card (sound-chip) related.
Next step was to dis/enable ACPI but that didn't made a difference.
When I stuff in a knoppix cd alls well, so it doesn't look hardware
related too.

The strace call is a bit long so I will mail it to you.
-- 
Greetings Japie


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
