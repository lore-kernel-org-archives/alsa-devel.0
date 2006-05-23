From: Hans-Christian Egtvedt <hcegtvedt@atmel.com>
Subject: Re: How to add full duplex capture and playback?
Date: Tue, 23 May 2006 14:57:08 +0200
Message-ID: <447306A4.5010406@atmel.com>
References: <446D9014.1070300@atmel.com>	<446DA1AA.1080907@atmel.com>	<s5hbqtuxjhq.wl%tiwai@suse.de>	<446DE77F.909@atmel.com> <s5hhd3mvvyy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hhd3mvvyy.wl%tiwai@suse.de>
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
> At Fri, 19 May 2006 17:42:55 +0200,
> Hans-Christian Egtvedt wrote:
>> Takashi Iwai wrote:
>>> At Fri, 19 May 2006 12:44:58 +0200,
>>> Hans-Christian Egtvedt wrote:

<snipp code>

>> But it does not work quite as expected. I'm still able to set rate and
>> format from userspace (aplay/arecord), and this again will alter the
>> hardware setup when the prepare callback is called.
> 
> Right.  The restriction of configuration space is defined by the rules
> set in open callback.  hw_params callback just follows the given
> parameter and returns the success or the failure code.
> 
> A typical code is like below:

<snipp code example>

Thank you, this really clear things up. Driver is working as expected now.

> In addition, a proper mutex would be preferred around the operation.
> 
> To be more strict, we may change hw_params like the following:

<snipp code example>

> However, this doesn't work with OSS emulation because OSS emulation
> initializes the rate to a certain default one.  If app tries to change
> the rate in the full-duplex mode, then it's refused.

I will leave this part out for now, since it dosn't work with OSS
emaulation.

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
