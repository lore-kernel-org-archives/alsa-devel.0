From: Nicolas Boichat <nicolas@boichat.ch>
Subject: Re: ALSA Intel HDA MacBook
Date: Mon, 10 Jul 2006 14:00:40 +0200
Message-ID: <44B24168.10405@boichat.ch>
References: <200607081323.17265.rene@exactcode.de>
	<200607082120.02137.rene@exactcode.de>
	<s5hk66lda2l.wl%tiwai@suse.de>
	<200607101344.13837.rene@exactcode.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200607101344.13837.rene@exactcode.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Rene Rebe <rene@exactcode.de>
Cc: Takashi Iwai <tiwai@suse.de>, Matt Porter <mporter@embeddedalley.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Rene Rebe wrote:
> Hi,
>
> On Monday 10 July 2006 12:32, Takashi Iwai wrote:
>   
>> At Sat, 8 Jul 2006 21:20:02 +0200,
>> Rene Rebe wrote:
>>     
>>> +static unsigned int apple_pin_configs[10] = {
>>> +	0x0121E230, 0x90A70120, 0x9017E110, 0x400000FE,
>>> +	0x400000FD, 0x0181E021, 0x1145E040, 0x400000FA,
>>> +	0x400000FC, 0x400000FB,
>>> +};
>>> +
>>>       
>> Interesting.  How did yo figure this out?
>>     
>
> No idea, as I wrote the best patch "I found" on the internet. I think
> it was Nicolas who came up with it.
>   
I also don't know .-) I picked these from an old patch provided by gimli
(mactel-linux), the only infos I have are:

+/* These come from the windows inf files from bootcamp*/
+#if 0
+/*This has mic/line in*/
+static unsigned int minimac_pin_configs[10] = {
+       0x0121E230, 0x90A70120, 0x9017E110, 0x400000FE,
+       0x400000FD, 0x0181E021, 0x1145E040, 0x400000FA,
+       0x400000FC, 0x400000FB,
+};
+#else
+/*This has only line in*/
+static unsigned int minimac_pin_configs[10] = {
+       0x0121E220, 0x400000FF, 0x9017E110, 0x400000FE,
+       0x400000FD, 0x0181E040, 0x1145E030, 0x11C5E040,
+       0x400000FC, 0x400000FB,
+};
+#endif
+

I picked up the first one so the mic works.

I have no which inf he got these infos.

Best regards,

Nicolas


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
