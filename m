From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Click after draining
Date: Mon, 18 Oct 2004 17:34:02 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20041018173402.pochini@shiny.it>
References: <s5hwtxohxjb.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hwtxohxjb.wl@alsa2.suse.de>
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


On 18-Oct-2004 Takashi Iwai wrote:

>> > The period size is always same even for the last period, AFAIK.
>> 
>> Only if the driver explicitly asks for it by calling
>> snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS).
> 
> No, this means that buffer_size = N * period_size, where N is
> integer.  Without this constraint, N doesn't have to be an integer.


Yes, exactly. If N isn't integer, the buffer is formed by
bufsize\persize periods (== the integer part of N) plus one
short period which is bufsize%persize long.


--
Giuliano.


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
