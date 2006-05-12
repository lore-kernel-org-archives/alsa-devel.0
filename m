From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: AC97 Codec Rate Problem
Date: Fri, 12 May 2006 21:50:31 +0200
Message-ID: <4464E707.6000706@roarinelk.homelinux.net>
References: <4464C2C1.4030908@roarinelk.homelinux.net> <s5h4pzvxhm3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4pzvxhm3.wl%tiwai@suse.de>
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

Takashi Iwai wrote:

>> Right now, I call snd_ac97_set_rate() in the drivers' prepare() callback;
>> but since I don't know which rates the attached codec actually supports,
>> I thought maybe there is a way to let ALSA itself handle setting
>> the rates?
> 
> The supported rates are detected at ac97 probing time and stored in
> ac97->rates[] array.  For example, ac97->rates[AC97_RATES_FRONT_DAC]
> corresponds to the front playback rates.  It's bit flags consisting of
> SNDRV_PCM_RATE_* bits.
> 
> Usually, at a PCM open callback, write this value to
> runtime->hw.rates, then call snd_pcm_limit_hw_rates(runtime) for
> adding a hw_params constraint.

Thanks, I'm going to implement that.

-- 
 Manuel Lauss


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
