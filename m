From: Francisco Moraes <fmoraes74@netzero.net>
Subject: Re: Help with supporting Emu10k1x  and question
Date: Wed, 18 Feb 2004 07:04:09 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <403354B9.8000305@netzero.net>
References: <403154C2.3020701@netzero.net> <s5h3c99yb00.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3c99yb00.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>it already sounds like you're accessing a wrong register...
>  
>

I removed all the writes and left only mine and I can now trace the PTR 
writes. I have not been able to get interrupts working, so it seems like 
alsa keeps calling the PCM trigger function with a start and then 
followed by a stop. And the process goes on.

Any way I can avoid this or change how things work internally a bit?

Francisco



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
