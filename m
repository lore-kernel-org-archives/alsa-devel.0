From: jcdutton <jcdutton@users.sourceforge.net>
Subject: Re: [alsa-cvslog] CVS: alsa-kernel/pci/emu10k1 emu10k1_main.c,1.68,1.69
Date: Mon, 12 Sep 2005 22:42:20 +0100
Message-ID: <4325F63C.2010104@users.sourceforge.net>
References: <E1EE1am-0008Ff-8x@sc8-pr-cvs1.sourceforge.net>	<s5h7jdpq9eo.wl%tiwai@suse.de>	<432315ED.2040600@users.sourceforge.net> <s5h64t6ioko.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h64t6ioko.wl%tiwai@suse.de>
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
> At Sat, 10 Sep 2005 18:20:45 +0100,
> jcdutton wrote:
> 
>>Takashi Iwai wrote:
>>
>>>At Sat, 10 Sep 2005 02:24:12 -0700,
>>>James Courtier-Dutton wrote:
>>>
>>>
>>>>Update of /cvsroot/alsa/alsa-kernel/pci/emu10k1
>>>>In directory sc8-pr-cvs1.sourceforge.net:/tmp/cvs-serv31621/alsa-driver/alsa-kernel/pci/emu10k1
>>>>
>>>>Modified Files:
>>>>	emu10k1_main.c 
>>>>Log Message:
>>>>Summary: snd-emu10k1: ALSA bug#1297: Fix a error recognising the SB Live Platinum.
>>>>
>>>>The card does not have an AC97 chip.
>>>>.subsystem = 0x80611102
>>>
>>>
>>>Hmm, it seems that there is another model with the same subsystem ID,
>>>which has really an ac97 chip.
>>>
>>>
>>>Takashi
>>>
>>>
>>
>>I only know about bug#1297.
>>Is there another person who has this exact same card ID but different 
>>ac97 chip presence?
> 
> 
> Yes.  At least, two on SUSE Bugzilla:
> 	
> 	https://bugzilla.novell.com/show_bug.cgi?id=113149
> 
> 
> Takashi
> 
> 

Hum, well this is starting to become a real problem.
Can you ask the SUSE user to extract their sound card from their PC and 
read off the model name. It will be something like "SB0350".
I will do the same with the alsa bug user.

There must be some reliable way to identify the sound card. Just 
detecting the presence or absence of the AC97 chip is not enough for 
what I have planned for the more pro user which is to implement full 
control over the ADC chip via the I2C bus on the Platinum models.

If both the Platinum and the Player have the same model number on the 
card, then I will have to look for something else to determine the 
difference.

James


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
