From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Click after draining
Date: Mon, 18 Oct 2004 16:56:11 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20041018165611.pochini@shiny.it>
References: <s5h7jpojn0t.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7jpojn0t.wl@alsa2.suse.de>
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

>> In my case delta is always 0. It seems ALSA aligns appl_ptr to the offset
>> of the next period without silencing the current one.
>
> If so, it has to be in alsa-lib.  Not a bug of ALSA driver.

Ok, I'll check that one.


>> Anyway, calling _fill_silence() with length=runtime->period_size - delta is
>> wrong IMHO because not all periods have have the same size. The last one can
>> be smaller and in that case it will overflow.
>
> The period size is always same even for the last period, AFAIK.

Only if the driver explicitly asks for it by calling
snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS).


>> Also, I don't think filling with silence until the end of the period is
>> enough. ALSA stops the card some time it gets the interrupt, thus it should
>> silence also the subsequent period, or its beginning part.
>
> I thought of that, too, but concluded that it's a questionary
> behavior.
>
> Usually, it's not needed if the interrupt is taken fast enough at the
> moment the last period is processed.

"Fast" means <22us at 44100Hz...


> The click noise comes from the garbage data in the last period.

Indeed.


--
Giuliano.


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
