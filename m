From: Alnie <memobook80@comcast.net>
Subject: Re: Issues w/ Creative Labs [SB X-Fi Xtreme Audio]
	CA0110-IBG
Date: Tue, 03 Mar 2015 18:12:31 -0800
Message-ID: <54F66A0F.1050603@comcast.net>
References: <54F52C68.6010504@comcast.net>	<s5hzj7u7grx.wl-tiwai@suse.de>	<54F5614C.9010402@comcast.net>	<s5hwq2y7c8g.wl-tiwai@suse.de>	<54F57D07.9020900@comcast.net>	<54F62CDC.1010607@comcast.net>
 <s5hoao97n1j.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from resqmta-po-04v.sys.comcast.net (resqmta-po-04v.sys.comcast.net
 [96.114.154.163])
 by alsa0.perex.cz (Postfix) with ESMTP id 13A53261AB0
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2015 03:12:34 +0100 (CET)
In-Reply-To: <s5hoao97n1j.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/03/2015 02:07 PM, Takashi Iwai wrote:
> At Tue, 03 Mar 2015 13:51:24 -0800,
> Alnie wrote:
>>
>> On 03/03/2015 01:21 AM, Alnie wrote:
>>> On 03/02/2015 11:48 PM, Takashi Iwai wrote:
>>>> At Mon, 02 Mar 2015 23:22:52 -0800,
>>>> Alnie wrote:
>>>>>
>>>>> On 03/02/2015 10:10 PM, Takashi Iwai wrote:
>>>>>> At Mon, 02 Mar 2015 19:37:12 -0800,
>>>>>> Alnie wrote:
>>>>>>>
>>>>>>> At Wed, 25 Feb 2015 00:21:15 -0800,
>>>>>>> Alnie wrote:
>>>>>>>     >
>>>>>>>     >
>>>>>>>     >
>>>>>>>     > On 02/25/2015 12:06 AM, Takashi Iwai wrote:
>>>>>>>     > > At Tue, 24 Feb 2015 23:55:25 -0800,
>>>>>>>     > > Alnie wrote:
>>>>>>>     > >>
>>>>>>>     > >> [ 2619.199658] pciehp 0000:00:1c.3:pcie04: Card not present
>>>>>>> on Slot(3)
>>>>>>>     > >> [ 2619.199666] pciehp 0000:00:1c.3:pcie04: slot(3): Link
>>>>>>> Down event
>>>>>>>     > >> [ 2619.199674] pciehp 0000:00:1c.3:pcie04: Link Down event
>>>>>>> ignored on
>>>>>>>     > >> slot(3): already powering off
>>>>>>>     > >> [ 2619.199911] pci_bus 0000:06: busn_res: [bus 06-0c] is
>>>>>>> released
>>>>>>>     > >> [ 2620.757928] pciehp 0000:00:1c.3:pcie04: Card present on
>>>>>>> Slot(3)
>>>>>>>     > >> [ 2620.767950] pciehp 0000:00:1c.3:pcie04: slot(3): Link Up
>>>>>>> event
>>>>>>>     > >> [ 2620.767985] pciehp 0000:00:1c.3:pcie04: Link Up event
>>>>>>> ignored on
>>>>>>>     > >> slot(3): already powering on
>>>>>>>     > >
>>>>>>>     > > pciehp reacted power off and on here, and...
>>>>>>>     > >
>>>>>>>     > >> [ 2620.876160] pci 0000:05:00.0: [1102:7006] type 01 class
>>>>>>> 0x060400
>>>>>>>     > >> [ 2620.876426] pci 0000:05:00.0: supports D1 D2
>>>>>>>     > >> [ 2620.876719] pci 0000:05:00.0: bridge configuration
>>>>>>> invalid ([bus
>>>>>>>     > >> 00-00]), reconfiguring
>>>>>>>     > >> [ 2620.876928] pci_bus 0000:06: busn_res: can not insert
>>>>>>> [bus 06-ff]
>>>>>>>     > >> under [bus 05-0c] (conflicts with (null) [bus 05-0c])
>>>>>>>     > >
>>>>>>>     > > .... and something failed here for the PCI bridge device.
>>>>>>>     > >
>>>>>>>     > >> [ 2620.876967] pci 0000:06:00.0: [1102:0009] type 00 class
>>>>>>> 0x040300
>>>>>>>     > >> [ 2620.877013] pci 0000:06:00.0: reg 0x10: [mem
>>>>>>> 0x00000000-0x00003fff]
>>>>>>>     > >> [ 2620.877203] pci 0000:06:00.0: supports D1 D2
>>>>>>>     > >> [ 2620.877443] pci 0000:05:00.0: PCI bridge to [bus 06-ff]
>>>>>>>     > >> [ 2620.877462] pci 0000:05:00.0:   bridge window [io
>>>>>>> 0x0000-0x0fff]
>>>>>>>     > >> [ 2620.877474] pci 0000:05:00.0:   bridge window [mem
>>>>>>> 0x00000000-0x000fffff]
>>>>>>>     > >> [ 2620.877492] pci 0000:05:00.0:   bridge window [mem
>>>>>>>     > >> 0x00000000-0x000fffff 64bit pref]
>>>>>>>     > >> [ 2620.877500] pci_bus 0000:06: busn_res: [bus 06-ff] end is
>>>>>>> updated to 06
>>>>>>>     > >> [ 2620.877559] pci 0000:05:00.0: BAR 14: assigned [mem
>>>>>>>     > >> 0xf4300000-0xf43fffff]
>>>>>>>     > >> [ 2620.877568] pci 0000:05:00.0: BAR 15: assigned [mem
>>>>>>>     > >> 0xf4000000-0xf40fffff 64bit pref]
>>>>>>>     > >> [ 2620.877574] pci 0000:05:00.0: BAR 13: assigned [io
>>>>>>> 0x2000-0x2fff]
>>>>>>>     > >> [ 2620.877582] pci 0000:06:00.0: BAR 0: assigned [mem
>>>>>>> 0xf4300000-0xf4303fff]
>>>>>>>     > >> [ 2620.877595] pci 0000:05:00.0: PCI bridge to [bus 06]
>>>>>>>     > >> [ 2620.877603] pci 0000:05:00.0:   bridge window [io
>>>>>>> 0x2000-0x2fff]
>>>>>>>     > >> [ 2620.877618] pci 0000:05:00.0:   bridge window [mem
>>>>>>> 0xf4300000-0xf43fffff]
>>>>>>>     > >> [ 2620.877630] pci 0000:05:00.0:   bridge window [mem
>>>>>>>     > >> 0xf4000000-0xf40fffff 64bit pref]
>>>>>>>     > >> [ 2620.877647] pcieport 0000:00:1c.3: PCI bridge to [bus
>>>>>>> 05-0c]
>>>>>>>     > >> [ 2620.877655] pcieport 0000:00:1c.3:   bridge window [io
>>>>>>> 0x2000-0x2fff]
>>>>>>>     > >> [ 2620.877667] pcieport 0000:00:1c.3:   bridge window [mem
>>>>>>>     > >> 0xf4300000-0xf7efffff]
>>>>>>>     > >> [ 2620.877677] pcieport 0000:00:1c.3:   bridge window [mem
>>>>>>>     > >> 0xf4000000-0xf40fffff 64bit pref]
>>>>>>>     > >> [ 2620.877990] pci 0000:05:00.0: enabling device (0000 ->
>>>>>>> 0003)
>>>>>>>     > >> [ 2620.878013] snd_hda_intel 0000:06:00.0: enabling device
>>>>>>> (0000
>>>>>>> -> 0002)
>>>>>>>     > >> [ 2620.882747] azx_single_wait_for_response: 108 callbacks
>>>>>>> suppressed
>>>>>>>     > >> [ 2620.882753] snd_hda_intel 0000:06:00.0: Codec #1 probe
>>>>>>> error;
>>>>>>>     > >> disabling it...
>>>>>>>     > >> [ 2620.887052] snd_hda_intel 0000:06:00.0: no AFG or MFG
>>>>>>> node found
>>>>>>>     > >> [ 2620.887058] snd_hda_intel 0000:06:00.0: no codecs
>>>>>>> initialized
>>>>>>>     > >
>>>>>>>     > > What if you once unload snd-hda-intel module and reload
>>>>>>> again while
>>>>>>>     > > keeping the card plugged?  I guess it still doesn't work,
>>>>>>> but just to
>>>>>>>     > > be sure...
>>>>>>>     > >
>>>>>>>     > > Overall, this look more like a problem of PCI core stuff.
>>>>>>> Better to
>>>>>>>     > > toss the issue to PCI people.
>>>>>>>     > >
>>>>>>>     > >
>>>>>>>     > > Takashi
>>>>>>>     > >
>>>>>>>     >
>>>>>>>     > I did alsa force-reload and the same error comes up. Do you
>>>>>>> know of a
>>>>>>>     > good starting point for presenting PCI issues?
>>>>>>>     >
>>>>>>>     >Ask on linux-pci at vger.kernel.org ?
>>>>>>>     >
>>>>>>>     >
>>>>>>>     >Takashi
>>>>>>>
>>>>>>>
>>>>>>> Bjorn has suggested it is not a PCI issue...
>>>>>>> http://article.gmane.org/gmane.linux.kernel.pci/39492
>>>>>>> Any other ideas in regards to this?
>>>>>>
>>>>>> After re-inserting the card, try to reload the driver module again.
>>>>>>
>>>>>>
>>>>>> Takashi
>>>>>>
>>>>>
>>>>> Okay, booted with card not inserted and with hda-intel driver
>>>>> blacklisted. Inserted card & loaded driver and same complaint came up...
>>>>> here is dmesg output http://pastebin.com/myBT23G1
>>>>
>>>> I meant reloading the module again without reinserting the device.
>>>> Though, I don't expect this would work, but just to be sure.
>>>>
>>>
>>> is alsa force-reload sufficient?
>>>
>>>> Other than that, I have no much clue.  You might put some delay in
>>>> each probe procedure and debug prints.  Check the values of
>>>> azx_read*() and azx_write*().  Especially if azx_read*() reads 0xff,
>>>> it means that the mapped PCI registers are wrong, which usually
>>>> indicates still some PCI errors (e.g. the device isn't powered up
>>>> properly).
>>>>
>>>>
>>>> Takashi
>>>>
>>>
>>> Bjorn asked this question I'm not sure if you ever saw it...
>>>
>>> On Thu, Feb 26, 2015 at 09:20:59AM +0100, Takashi Iwai wrote:
>>>
>>>   >> FYI, during the previous debug sessions, we found that the sound
>>>   >> driver gets only 0xff for mapped register accesses, so I suggested to
>>>   >> report to PCI devs.  IIRC, the non-hotplug board with this chip worked
>>>   >> in the past.
>>>
>>>   >I skimmed the previous emails but I missed this part.  Did you add
>>>   >instrumentation to the driver, or is it just obvious from the way the
>>>   >driver behaves that we're getting 0xff?
>>>
>>>   >Bjorn
>>>
>>>
>>> Also, in regards to debug prints and azx read write values. How do I do
>>> this? I have searched around I can't find anything.
>>>
>>
>> Please bear with me. Much of this is very new to me. I compiled a new
>> kernel with the following debug settings enabled. Am I moving in the
>> right direction?
>>
>> CONFIG_SND_VERBOSE_PRINTK=y
>> CONFIG_SND_DEBUG=y
>> CONFIG_SND_DEBUG_VERBOSE=y
>>
>> CONFIG_PCI_DEBUG=y
>>
>>
>> Here is the dmesg (i also do a force-reload)... http://pastebin.com/giRsPCUe
>> More output, but not sure if it has the information you are looking for.
>> and this...
>> http://www.alsa-project.org/db/?f=c69bc32b2795cc9cee2aa3cf205c8dab7583638d
>
> My suggestion isn't about a compile option but that you add some debug
> printk() calls manually around some codes.  We need to know the value
> written and read by azx_write*() and azx_read*() calls.  Especially
> the value read in pci_azx_read*() is more interesting. You can try to
> modify sound/pci/hda/hda_intel.c and add a printk() to each
> pci_azx_read*() function for printing the value to be returned.
> Beware that this will likely flood many messages, so just try once.
>
>
> Takashi
>

I can not find any reference to pci_azx_read in hda_intel.c

Take this for example...

/* receive a response */
static int azx_single_wait_for_response(struct azx *chip, unsigned int addr)
{
	int timeout = 50;

	while (timeout--) {
		/* check IRV busy bit */
		if (azx_readw(chip, IRS) & ICH6_IRS_VALID) {
			/* reuse rirb.res as the response return value */
			chip->rirb.res[addr] = azx_readl(chip, IR);
			return 0;
		}
		udelay(1);
	}
	if (printk_ratelimit())
		snd_printd(SFX "%s: get_response timeout: IRS=0x%x\n",
			   pci_name(chip->pci), azx_readw(chip, IRS));
	chip->rirb.res[addr] = -1;
	return -EIO;
}

can you please show me how to insert the printk command without breaking 
things?

-Alnie
