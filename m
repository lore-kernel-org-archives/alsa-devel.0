From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Firmware uploader
Date: Thu, 13 May 2004 09:22:51 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20040513092251.pochini@shiny.it>
References: <s5hzn8gfwzs.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hzn8gfwzs.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


On 10-May-2004 Takashi Iwai wrote:
> At Sun, 9 May 2004 18:21:21 +0200,
> Giuliano Pochini wrote:
>>
>> I read /linux/Documentation/firmware_class/README infos about the firmware
>> loader. That loader is not used by any of the alsa drivers. Is there a
>> reason ? Should I write my own custom loader or is it better using the
>> firmware-class one ?
>
> it's planned to move the ALSA firmware stuff to this new one.
> but we'll need a compatibility stuff for older kernels.

Ok, I'll start with the new one. It there a "standard" daemon that
monitors /proc and uploads the firmware when requested ?


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
