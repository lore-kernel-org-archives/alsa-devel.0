From: Will <walsac2@liam2.demon.co.uk>
Subject: Re: [PATCH] add aplaymidi & arecordmidi utils
Date: Wed, 25 Feb 2004 14:11:24 GMT
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200402251411.OAA12812@liam2.demon.co.uk>
References: <403CAA12.4070003@superbug.demon.co.uk>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <403CAA12.4070003@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James@superbug.demon.co.uk
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton <James@superbug.demon.co.uk> wrote:
>Will wrote:
>> Is the following a correct way of updating the ALSA in Linux 2.6.3?
>
>I have just updated the alsa.opensrc.org wiki.
>Use option 1] on
>http://alsa.opensrc.org/index.php?page=AlsaBuild2.6

Thanks.  The section describing option 1 is still a bit confusing because
it seems to contradict itself firstly by saying alsa-driver is needed (at
the first paragraph) and secondly by saying it might not be needed (at
the end of the section).  It also doesn't say you should not install
alsa-kernel which presumably you shouldn't do.

Quick summary
1. Install alsa-driver from ALSA CVS
2. Disable ALSA in kernel (#CONFIG_SND is not set)
3. Enable sound in kernel (CONFIG_SOUND=y)
4. make and install from kernel source
5. configure/install alsa-lib alsa-firmware alsa-oss alsa-tools alsa-utils



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
