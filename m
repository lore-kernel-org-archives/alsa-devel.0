From: Winfried Ritsch <ritsch@iem.at>
Subject: Re: Scatter-Gather buffer allocation before running on HDSP-MADI ?
Date: Fri, 10 Oct 2003 17:23:51 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <16262.52999.580761.606834@seneca.iemnet>
References: <16254.61960.840856.972245@seneca.iemnet>
	<Pine.LNX.4.53.0310052055350.13267@pnote.perex-int.cz>
	<s5had8eo4p1.wl@alsa2.suse.de>
	<1065460748.3f81a40c61063@iem.at>
	<s5hvfr2mflt.wl@alsa2.suse.de>
	<16258.59662.729091.684464@seneca.iemnet>
	<s5h65j1knhd.wl@alsa2.suse.de>
	<1065776616.3f8675e8b202e@iem.at>
	<s5hn0c97248.wl@alsa2.suse.de>
	<Pine.LNX.4.53.0310101356201.18818@pnote.perex-int.cz>
	<s5hismx70v0.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hismx70v0.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, ritsch@iem.at, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hello,

Thanks, 

>> > 	offset = 0; /* bytes */
>> > 	while (offset < total_size) {
>> > 		dma_addr_t addr = snd_sgbuf_get_addr(sgbuf, offset);
>> > 		map_this_addr_to_my_hw_table(addr);
>> > 		offset += 4096; /* 4k */
>> 

If PAGE_SIZE is never less than 4k then the code is good and
I did it this way, I seems to work quite stable.

mfg winfried


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
