From: Nicolas Boichat <nicolas@boichat.ch>
Subject: Re: Macmini pins in sigmatel_audio
Date: Sat, 17 Mar 2007 13:58:51 +0800
Message-ID: <45FB839B.6040309@boichat.ch>
References: <E1HRY1h-0003Y6-2M@sc8-pr-svn1.sourceforge.net>	<20070314192940.GA18255@dose.home.local>	<45F8DD78.9020508@boichat.ch>	<20070315080134.GA22654@dose.home.local>	<45F91C0E.7020600@boichat.ch>	<20070315185433.GA10186@dose.home.local>	<45FA6869.40701@boichat.ch>
	<s5hird178fb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hird178fb.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, mactel-linux-devel@lists.sourceforge.net, Tino Keitel <tino.keitel+mactel-devel@tikei.de>
List-Id: alsa-devel@alsa-project.org

Hi,

Takashi Iwai wrote:
> At Fri, 16 Mar 2007 17:50:33 +0800,
> Nicolas Boichat wrote:
>> Hi,
>>
>> I just got this input from a Macmini user (subsys id: 0x106b0800), after
>> asking him to try different pins settings. (the sound doesn't work
>> properly with a vanilla 2.6.21-rc3 kernel)
>>
>> Tino Keitel wrote:
>>> On Thu, Mar 15, 2007 at 18:12:30 +0800, Nicolas Boichat wrote:
>>>
>>> [...]
>>>
>>>   
>>>> Considered it worked with the mactel patches, you should try
>>>> STAC_MACBOOK_PRO_V1 first....
>>>>     
>>> You are right, with STAC_MACBOOK_PRO_V1 I can use all required
>>> features. Here are the results:
>>>
>>> - analog line in works, if "Line In as Output" is muted
>>>
>>> - analog line out works, it is controlled by  the "Front" channel in
>>>   alsamixer
>>>
>>> - digital line out works
>>>
>>> - the internal speaker works, it is controlled by the "Master" channel
>>>   in alsamixer
>>>
>>> - the internal speaker is silent if there is an analog plug in line out
>>>
>>> - the internal speker still works if a (optical) digital cable is
>>>   plugged in line out, I guess because the optical plastic cable
>>>   doesn't short circuit the line out plug
>>>
>>> Minor glitches:
>>>
>>> There is an input selector that has the options "Line", "Mic" and
>>> "Front Mic". However, I think that only "Line" is really usable, as I
>>> had so signal when I connected a Mic to line in and a "Front Mic" is
>>> also not present in the mini.
>>>
>>> There is a "Mic as output" switch in alsamixer, but there is not "Mic"
>>> jack.
>>>   
>> Considering these pins have been used for a long time on mactel-linux,
> 
> Grrr, someone should have informed us.  I didn't know of this.

Sorry... Was quite busy recently, and I'm trying to get all our patches
upstream now...

>> and that they are working fine with MacBook (1st generation at least),
>> Macmini and Macbook Pro (1st generation only), I think the following
>> patch is appropriate (please apply it after the patch sent yesterday).
> 
> But the glitches above don't appear on your macbook-pro-v1, right?

Yeah I have some glitches too... For "Input source" I have "Front Mic",
"Mic" and "Line", while only "Mic" and "Line" are useful. I also have a
Mic as Output which is not relevant (no Mic jack)... I'll try to have a
look at this.

Also, to get the Mic to work, even if the "Input Source" is set to Mic
at boot time, I have to switch to Line or Front Mic and then back to Mic.

> Then I suppose macmini requires slightly different pin configs for
> inputs.  As for now, I think it's OK to use macbook-pro-v1 pin configs
> for macmini since it's much better.  So, how about to just keep the
> models and change the pin definitions to use the same table?

I saw your patch. Thx.

Best regards,

Nicolas

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
