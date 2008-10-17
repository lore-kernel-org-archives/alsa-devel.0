From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Fri, 17 Oct 2008 19:16:00 +0100
Message-ID: <48F8D660.6010001@superbug.co.uk>
References: <s5hy70xsl46.wl%tiwai@suse.de>	<loom.20081016T120322-319@post.gmane.org>	<s5h8wso3ejg.wl%tiwai@suse.de>	<48F739F4.5070303@nostalgicnetworxx.org>	<48F74344.4090509@gmail.com>	<s5hvdvs1wig.wl%tiwai@suse.de>
	<48F7B23B.7010105@nostalgicnetworxx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-32.mail.demon.net (anchor-post-32.mail.demon.net
	[194.217.242.90])
	by alsa0.perex.cz (Postfix) with ESMTP id 6DE18244D2
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Oct 2008 20:16:23 +0200 (CEST)
In-Reply-To: <48F7B23B.7010105@nostalgicnetworxx.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Xarteras <xarteras@nostalgicnetworxx.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, The Source <thesourcehim@gmail.com>
List-Id: alsa-devel@alsa-project.org

Xarteras wrote:
> Takashi Iwai wrote:
>> At Thu, 16 Oct 2008 17:36:04 +0400,
>> The Source wrote:
>>>>> And, which X-Fi model do you have?
>>>>> Please show the lspci -nv output, too.
>>>>>
>>>>>     
>>>> I've got the X-Fi Elite Pro.
>>>> That's The one with the external In/Out box.
>>>>
>>>> Speaking of which, the headphone jack on it does not output a signal 
>>>> yet, the signal only goes to line out.
>>>>
>>>> There's some relais on the card that seem to switch these, they click 
>>>> multiple times with the windows driver and not all all with yours, I 
>>>> think that's the reason :)
>>>>   
>>> Original OSS driver doesn't output to external block also, so it 
>>> wouldn't be easy to make this support I think.
>> The values for port->conv[0] and [1] values in sbxfi_playback_open()
>> might play some role.  It's I2SA_L and I2SA_R, alias DAI_CH_I2SAL
>> and DAI_CH_I2SAR, as default.  You can try other values, such as,
>> DAI_CH_I2SBL, DAI_CH_I2SA1L, and so on.
> 
> I opened the external box for checking what's in there and noticed the 
> headphone jack seems to have it's own dedicated second DAC (CS4392KZ), 
> and audio interface receiver (CS8415A), so it could get a bit more 
> complicated.
> I'll see if I can find out more about that.
> 
> Also I found the GPIO flags that switch the relais, but that's probably 
> useless as long as their function is not known. (It's 0x04, 0x40, 0x200 
> and 0x1000).
> 
> Jan Wolf
> 

The relays are for padding.
I.e. They switch in some attenuation for the mic or line inputs.
