From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Interrupt handler
Date: 19 Mar 2003 01:15:34 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1048036537.7424.17.camel@Jay>
References: <s5h1y16uphm.wl@alsa2.suse.de>
	<XFMail.20030317152245.pochini@shiny.it>  <s5hisugu7es.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hisugu7es.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On mar, 2003-03-18 at 13:32, Takashi Iwai wrote:
> also, don't forget to unlock the spinlock during calling
> snd_pcm_period_elapsed() if a single lock is used for callbacks.

Yes, I'm following the tutorial and it's clear about that.

Now I have another weird problem. This is a peice of my hw_param
function:

static int pcm_hw_params(){
  printk("pcm_hw_params bytes=%d\n",params_buffer_bytes(hw_params));
  for (per=0; per<params_periods(hw_params); per++) {
    printk("pcm_hw_params Add%d (%x - %d)\n",
            per,
            sgbuf->table[per].addr,
            params_period_bytes(hw_params));
  }
}

Mar 19 00:48:33 localhost kernel: pcm_hw_params bytes=44100
Mar 19 00:48:33 localhost kernel: pcm_hw_params Add0 (3a1d000 - 11026)
Mar 19 00:48:33 localhost kernel: pcm_hw_params Add1 (3a1c000 - 11026)
Mar 19 00:48:33 localhost kernel: pcm_hw_params Add2 (3a1b000 - 11026)
Mar 19 00:48:33 localhost kernel: pcm_hw_params OK

Look at the physical addresses. They're spaced by 4KB, but the periods
are 11KB long and 11026*3<44100 !! You can imagine how beatiful sound I
get... What am I missing ?


Bye.




-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
