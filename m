From: Hans-Christian Egtvedt <hcegtvedt@atmel.com>
Subject: Re: How to add full duplex capture and playback?
Date: Fri, 19 May 2006 17:42:55 +0200
Message-ID: <446DE77F.909@atmel.com>
References: <446D9014.1070300@atmel.com>	<446DA1AA.1080907@atmel.com> <s5hbqtuxjhq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbqtuxjhq.wl%tiwai@suse.de>
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
> At Fri, 19 May 2006 12:44:58 +0200,
> Hans-Christian Egtvedt wrote:
>> Hans-Christian Egtvedt wrote:

<snipp>

> capture->runtime->rate isn't set properly unless hw_params is called
> in the capture side.  That is, if your app opens both sides at the
> same time but not set up each by other, it doesn't work.
> 
> It's better to set chip->cur_rate and chip->cur_format in hw_params
> callback (with care of number of opened streams).

Ok

>> 		hw_constraint_rates.count	= ARRAY_SIZE(hw_rates);
>> 		hw_constraint_rates.list	= hw_rates;
>> 		hw_constraint_rates.mask	= 0;
>>
>> 		hw_formats[0] = (unsigned int)capture_runtime->format;
>> 		hw_constraint_formats.count	= ARRAY_SIZE(hw_formats);
>> 		hw_constraint_formats.list	= hw_formats;
>> 		hw_constraint_formats.mask	= 0;
> 
> They can be more easily done by overwriting runtime->hw entries, for
> example,
> 	runtime->hw.rate_min = runtime->hw.rate_max = chip->cur_rate;
> and
> 	runtime->hw.formats = chip->cur_format_mask;

To the capture and playback hw_param callbacks I've added:

/* Set restrictions to params */
if (chip->playback_active) { /* capture_active for playback callback */
	runtime->hw.rate_min = runtime->hw.rate_max = chip->cur_rate;
	runtime->hw.formats = chip->cur_format;
}

But it does not work quite as expected. I'm still able to set rate and
format from userspace (aplay/arecord), and this again will alter the
hardware setup when the prepare callback is called.

In the prepare callback I set the endianess and rate for the hardware
controller based upon what's in the runtime->rate and runtime->format.

I did some printk's in the prepare callback and when playing a S16_LE
44100 Hz file I could record S16_BE 48000 Hz, and this will change the
hardware.

I.e. the runtime->hw.rate_min, rate_max and format was correct in the
prepare callback, but the runtime->rate and format was incorrect,
holding the values I gave from aplay/arecord in userspace.

>From what I've understood the limits you set in hw_params callback
should limit the values in the runtime when prepare callback is called?

I also did some printk's in the hw params callback, and there the format
in runtime->format and runtime->rate still 0, not the values given from
userspace.

Any feedback is greatly appreciated.

Sorry if this email is a bit untidy (-:

-- 
With kind regards,
Med vennlig hilsen,

Hans-Christian Egtvedt
Applications Engineer - AVR Applications Lab
Atmel Norway


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
