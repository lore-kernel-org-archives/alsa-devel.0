From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Re: Linux 2.6.10-rc2
Date: Thu, 18 Nov 2004 11:19:52 -0500
Message-ID: <419CCBA8.4000205@tmr.com>
References: <1100553392.4369.1.camel@krustophenia.net><9dda349204111512234f30c60d@mail.gmail.com> <s5h7jomdt3w.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7jomdt3w.wl@alsa2.suse.de>
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
Cc: Lee Revell <rlrevell@joe-job.com>, Paul Blazejowski <diffie@gmail.com>, Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>, Diffie <diffie@blazebox.homeip.net>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Mon, 15 Nov 2004 16:16:31 -0500,
> Lee Revell wrote:
> 
>>Please report ALSA issues to alsa-devel@lists.sourceforge.net.  I have
>>added them to the cc:.
> 
> 
> The attached patch should fix this.
> 
> 
> Takashi
> 
> ==
> Summary: [ALSA] fix sleep in atomic during prepare callback
> 
> Fixed the sleep in spinlock during prepare callback.
> This happened only on Nforce chips.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> 
> --- linux/sound/pci/intel8x0.c	15 Nov 2004 14:19:52 -0000	1.173
> +++ linux/sound/pci/intel8x0.c	16 Nov 2004 09:41:47 -0000
> @@ -1020,7 +1020,9 @@ static void snd_intel8x0_setup_pcm_out(i
>  			 */
>  			if (cnt & ICH_PCM_246_MASK) {
>  				iputdword(chip, ICHREG(GLOB_CNT), cnt & ~ICH_PCM_246_MASK);
> +				spin_unlock_irq(&chip->reg_lock);
>  				msleep(50); /* grrr... */
> +				spin_lock_irq(&chip->reg_lock);
>  			}
>  		} else if (chip->device_type == DEVICE_INTEL_ICH4) {
>  			if (runtime->sample_bits > 16)

Might this make it into 2.6.10?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
