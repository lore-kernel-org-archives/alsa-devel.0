From: Hans-Christian Egtvedt <hcegtvedt@norway.atmel.com>
Subject: Re: Best way of adding temporary limits to capture or
 playback
Date: Tue, 16 May 2006 12:43:55 +0200
Message-ID: <4469ACEB.4090705@norway.atmel.com>
References: <44696908.4070208@atmel.com> <s5hfyja45x9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hfyja45x9.wl%tiwai@suse.de>
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
Cc: Hans-Christian Egtvedt <hcegtvedt@atmel.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Tue, 16 May 2006 07:54:16 +0200,
> Hans-Christian Egtvedt wrote:

<snip helper functions wish>

>> My current plan is to change the hardware parameters in the playback
>> open and capture open callbacks if there is an active playback or
>> capture already present. And then reset this hardware limit when the
>> close callback is called.
> 
> Right, that's what other drivers do, too.

I've added restrictions to format and rate in the open callback. Is it
safe to just do changes here and ignore them in the close callback?

AFAIK when the open callback is called again, for a later stream the
original driver formats and rates will be loaded?

I.e. the driver does not remember that sometime in the past it was
limited to a certain hardware setup?

>> I would of course enjoy just setting a flag in the driver telling it
>> that capture and playback rates/endianess is related, and is locked if
>> one of the streams is opened.
> 
> We have SNDRV_PCM_INFO_JOINT_DUPLEX flag, but it's only a referrence
> to user-space and not really used in the driver.

Added, should be present anyway so user-space is aware of the dependencies.

>> PS! I'm having some sort of problems getting my emails from this lists,
>> seems like I don't get a copy anymore :/ I've checked the settings in
>> mailman, and they seem good.
>>
>> PPS! Sorry if this is received twice, but I didn't receive a copy or
>> find a copy in an online repository (twice).
> 
> I saw your post only once.

Seems like I'm not getting all emails for some reason, I've subscribed
with another account too for verifying my emails are getting through.
Could be a local, short time problem for this address.

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
