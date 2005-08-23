From: Raymond <rayau@netvigator.com>
Subject: Re: Alsa mix in HW
Date: Tue, 23 Aug 2005 23:45:09 +0800
Message-ID: <430B4485.9030300@netvigator.com>
References: <42EBAE72.9090608@e4a.it>	<4306EA27.7060000@netvigator.com> <s5hwtmdorfh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hwtmdorfh.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Sat, 20 Aug 2005 16:30:31 +0800,
> Raymond wrote:
> 
>>
>>
>>Do "SNDRV_PCM_RATE_CONTINUOUS" in snd_hardware_t mean that sample rate 
>>can be any integer between .rate_min and .rate_max ?
> 
> 
> Basically, yes.  A driver might add another restriction but in such a
> case it should use RATE_KNOT instead.
> 

Is there any quick way to check the device "hw:x,x" support
"SNDRV_PCM_RATE_CONTINUOUS" without running
snd_pcm_hw_param_test_rate() (rate_max-rate_min+1) times ?

Are the following result normal when using the following fuctions on 
device "plughw:x,x" ?

rate_min=4000 for snd_pcm_hw_params_get_rate_min()
rate_max=-1   for snd_pcm_hw_params_get_rate_max()










-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
