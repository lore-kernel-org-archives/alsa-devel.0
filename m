From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Click after draining
Date: Tue, 09 Nov 2004 11:00:28 +0100 (CET)
Message-ID: <XFMail.20041109110028.pochini@shiny.it>
References: <s5hzn1rqsj9.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hzn1rqsj9.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
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


On 09-Nov-2004 Takashi Iwai wrote:
> At Mon, 1 Nov 2004 20:29:49 +0100,
> Giuliano Pochini wrote:
>>
>> The patch below is mostly the one you wrote, with these changes: it handles
>> the case when the period to be silences crosses the buffer boundary and it
>> fills with silence the last played period while draining. It's not the right
>> thing of course but it work for me. Actually, it should fill only the first
>> x frames of the period following the last one, but I need another variable.
>
> The first is the right fix

It's the part you wrote, with some minor tweaks.


> but how about the latter one (filling silence at the last position
> in snd_pcm_update_hw_ptr_interrupt()) ?  Does it fix something?

Yes, it fixes the remaining small click. It happens because
the card does not stop immediately when the last interrupt is
delivered. In my case it plays the first 32 frames of the
next period that still contains old data. It's a very small
problem compared to the big click you fixed.
My patch fills way too much data than needed of course. It's
a just a test and it's not supposed to be applied.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
