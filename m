From: Nicolas Boichat <nicolas@boichat.ch>
Subject: Re: ALSA Intel HDA MacBook
Date: Fri, 28 Jul 2006 21:00:54 +0200
Message-ID: <44CA5EE6.8000700@boichat.ch>
References: <200607081323.17265.rene@exactcode.de>	<200607082120.02137.rene@exactcode.de>	<s5hk66lda2l.wl%tiwai@suse.de>	<200607101344.13837.rene@exactcode.de>	<44B24168.10405@boichat.ch>	<s5hk66k76sh.wl%tiwai@suse.de>	<44C38835.6010200@boichat.ch>	<20060728131924.GH3673@matthew-porters-computer.local>
	<s5h64hhooeh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h64hhooeh.wl%tiwai@suse.de>
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
Cc: Rene Rebe <rene@exactcode.de>, alsa-devel@lists.sourceforge.net, Matt Porter <mporter@embeddedalley.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Fri, 28 Jul 2006 09:19:24 -0400,
> Matt Porter wrote:
>   
>> On Sun, Jul 23, 2006 at 04:31:17PM +0200, Nicolas Boichat wrote:
>>     
>>> Hi,
>>>
>>> Takashi Iwai wrote:
>>>       
>>>> OK then it's somewhat another black magic :)
>>>>
>>>> Linus made a patch to make MacMini to work.  The patch is below (and
>>>> it's already merged to ALSA HG tree, too).
>>>> Could you check whether it works for other Intel Mac models?
>>>> At least, we need to check that it doesn't break something...
>>>>   
>>>>         
>>> I finally found the time to test this patch on my Macbook Pro (I'm
>>> running 2.6.18-rc2, which includes this patch).
>>>
>>> I have the following results:
>>> - "Side" controls internal speakers, if no headphone is plugged
>>> - "Front" controls headphones
>>> - Line-in is always set as output ("Line In as output" has no effect),
>>> "Center" controls line-"out" left channel, "LFE" the right channel.
>>> - "Surround" has no effect.
>>>
>>> However, the internal mic doesn't work anymore (whatever value I put in
>>> "Capture", "Input Source" and "Mux")...
>>>       
>> Hrm, I finally caught up on this stuff after holiday.  I've got the
>> spec, obviously, and even better I have a macbook pro (not yet running
>> linux) so I can do some direct work on this. I'll see what I can sort
>> out.
>>     
>
> That's great.
>
> I still wonder how we can distinguish the different intel mac models.
> Apparently all models have the same PCI SSID :-<
>   
Maybe by using DMI data? That's what I used for the accelerometer driver...

Best regards,

Nicolas

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
