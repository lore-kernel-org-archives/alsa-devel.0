From: Will <walsac2@liam2.demon.co.uk>
Subject: Re: alsa-lib & oss 1.0.3rc1
Date: Wed, 25 Feb 2004 13:40:05 GMT
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200402251340.NAA12291@liam2.demon.co.uk>
References: <Pine.LNX.4.58.0402251202580.10484@pnote.perex-int.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0402251202580.10484@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
>> Will wrote:
>> the OSS emulation is really very broken. Do you think it's something you
>> can easily fix?
>
>Well, it's question if it's worth to take care. I think that we have far 
>more better applications using directly ALSA sequencer API.

Yes, you're right. The new ALSA sequencer clients are better.
The only reason I want the OSS /dev/sequencer is to be able to use the
Rosegarden OSS sequencer client because it's less crash-prone
than any other sequencer client which also has notation editing.

>But if you send me a small code which shows the bug - like in 
>alsa-driver/test/seq1.c etc, then I will try to fix it.

Thank you.  I'll try writing a short OSS /dev/sequencer test at the weekend.

William


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
