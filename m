From: =?ISO-8859-1?Q?Maximilian_G=FCntner?= <beomuex@gmx.de>
Subject: Re: SB0880 X-Fi Titanium Fatal1ty Pro (with codecgraph)
Date: Mon, 14 Jul 2008 15:23:16 +0200
Message-ID: <487B5344.7020709@gmx.de>
References: <1215985902.4196.11.camel@localhost> <s5h4p6rw5zu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id D49D12433F
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Jul 2008 15:23:04 +0200 (CEST)
In-Reply-To: <s5h4p6rw5zu.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Does this hack only work with the  X-Fi Titanium Fatal1ty Pro, or does 
it include support for all X-Fi based cards from Creative Labs?
I have got a Creative X-Fi Extreme Music, that gets infact recognized by 
my system but modprobing the patched source (modprobe snd-hda-intel, i 
hope this is the right one) does not work.
Here the lspci if this helps:

http://pastebin.com/f6e5fafcb


-- beomuex

Takashi Iwai wrote:
> At Sun, 13 Jul 2008 22:51:42 +0100,
> Tony "Chainsaw" Vroon wrote:
>   
>> Good evening,
>>
>> Just wanted to share that this card seems to be HD-Audio compatible (by
>> virtue of its UAA compatibility claim);
>> http://uk.europe.creative.com/products/product.asp?category=1&subcategory=208&product=17791
>>
>> For a while now, I've been trying to write a skeleton patch_creative.c
>> to hook up some basic playback functions. As this has failed, I will
>> instead post all information I can gather about the card, in the hope
>> that such a basic patch_creative.c can be written that I can then slowly
>> extend.
>> I was unable to set up proper PCM paths (and thus listen to any audio at
>> all), but did manage to get the card detected with a simple addition to
>> hda_intel.c:
>> +       /* Creative Labs UAA-compatible */
>> +       { PCI_DEVICE(0x1102, 0x000b), .driver_data =
>> AZX_DRIVER_CREATIVE },
>>
>> A guess at correct mixer controls would be:
>> HDA_CODEC_VOLUME("PCM Playback Volume", 0x02, 0x0, HDA_OUTPUT),
>> HDA_CODEC_MUTE("PCM Playback Switch", 0x02, 0x0, HDA_OUTPUT),
>> HDA_CODEC_VOLUME("Surround Playback Volume", 0x03, 0x0, HDA_OUTPUT),
>> HDA_CODEC_MUTE("Surround Playback Switch", 0x03, 0x0, HDA_OUTPUT),
>> HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x04, 1, 0x0,
>> HDA_OUTPUT),
>> HDA_CODEC_MUTE_MONO("Center Playback Switch", 0x04, 1, 0x0, HDA_OUTPUT),
>> HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x04, 2, 0x0, HDA_OUTPUT),
>> HDA_CODEC_MUTE_MONO("LFE Playback Switch", 0x04, 2, 0x0, HDA_OUTPUT),
>> HDA_CODEC_VOLUME("Side Playback Volume", 0x05, 0x0, HDA_OUTPUT),
>> HDA_CODEC_MUTE("Side Playback Switch", 0x05, 0x0, HDA_OUTPUT),
>>
>> Please find attached the codec details and the resulting codec graph.
>>     
>
> Thanks for reporting.
> I've had already a test patch on my unstable tree, but it's pending
> just because of lack of testing with the real hardware.
>
> Could you try the git tree
>     git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-unstable-2.6.git
> ?
>
> If an external ALSA-driver tarball is preferred, get
> alsa-driver-unstable from the below:
>     http://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/
>
>
> thanks,
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>   
