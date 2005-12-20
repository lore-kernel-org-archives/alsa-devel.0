From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.15-rc6: boot failure in saa7134-alsa.c
Date: Tue, 20 Dec 2005 10:24:55 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512201018000.4827__25026.6948868104$1135103356$gmane$org@g5.osdl.org>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
 <20051220131810.GB6789@stusta.de> <20051220155216.GA19797@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7AE731B2
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2005 19:25:01 +0100 (MET)
In-Reply-To: <20051220155216.GA19797@master.mivlgu.local>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: Adrian Bunk <bunk@stusta.de>, Ricardo Cerqueira <v4l@cerqueira.org>, mchehab@brturbo.com.br, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On Tue, 20 Dec 2005, Sergey Vlasov wrote:
> 
> saa7134-alsa is trying to initialize before the ALSA core has initialized.
> Probably no one has tested CONFIG_VIDEO_SAA7134=y.

Adrian, does it work if you change the "module_init()" in 
sound/sound_core.c into a "fs_initcall()"?

That should make sure that the sound core gets to initialize before normal 
drivers do.

		Linus


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
