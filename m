From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Codecs without auto-parser
Date: Wed, 02 Feb 2011 16:16:21 +0100
Message-ID: <4D497545.4000605@canonical.com>
References: <4D413CBE.9080409@canonical.com>	<s5hd3nhcv7u.wl%tiwai@suse.de>	<4D42ADC2.7090001@canonical.com>	<s5h1v3xw7o7.wl%tiwai@suse.de>	<4D47B835.7090502@canonical.com>
	<s5hvd13xwv9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 415A924584
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2011 16:16:26 +0100 (CET)
In-Reply-To: <s5hvd13xwv9.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 2011-02-01 22:34, Takashi Iwai wrote:
> At Tue, 01 Feb 2011 08:37:25 +0100,
> David Henningsson wrote:
>>
>> On 2011-01-28 13:10, Takashi Iwai wrote:
>>> At Fri, 28 Jan 2011 12:51:30 +0100,
>>> David Henningsson wrote:
>>>>
>>>> On 2011-01-28 09:01, Takashi Iwai wrote:
>>>>> And I hope that we should go further a bit for now -- more clean up of
>>>>> the cxt5066 code either checking BIOS pins or hp/mic/spk pre-defined
>>>>> pins.  Currently, the code is fairly messy (partly because of olpc
>>>>> support), and now is a good chance to improve it a bit more.
>>>>
>>>> Maybe so. I'm not sure I can commit to doing that work right now, as I
>>>> have other work commitments waiting for me to take care of them.
>>>
>>> OK.
>>
>> Hmm. I got a few things cleared up yesterday, and so I might have some
>> time to actually do this.
>
> Great.
>
>> However, it also seems like I have to fix an
>> AD1984A machine, and that driver is in equally bad shape (as in: no
>> auto-parser, just a list of models).
>
> Yeah, I know...
>
>> I could add another model, but
>> suppose I'd do this the right way, how would I do it?
>>
>> I guess there are three options to start off with:
>>
>> 1) ad1988 seems to have an auto-parser. There are a lot of hardcoded
>> nids in there, but I guess I could copy-and-paste some into a new
>> auto-parser for ad1984a.
>
> Well... AD1988 and AD1984A aren't so similar, IIRC.
> AD1984A is more straightforward hardware implementation while AD1988
> can have more connections.  Also AD1988 auto-parser isn't in the best
> form in comparison with other codecs.
>
> That being said, if AD1984A can fit with AD1988's auto-parser (i.e.
> my memory was too vague), it's fine.  We can adapt it.
>
> If this is hard, one more quirk model won't be too bad for AD1984A
> since this is a pretty simple codec, and there won't be so more devices
> with this old chip.

Ok. I had one more look at AD1988's auto-parser and I don't think it's 
good to start off that one.

>> 2) It seems to me like the most competent candidate for auto-parser
>> currently is the cx_auto stuff - compared to other auto-parsers the
>> hardcoded nids are fewer. Perhaps this one could be extended to also do
>> auto-parsing for codecs from other vendors? Or at least some convenience
>> functions moved to hda_codec.c in order to remove duplication between
>> vendors?
>
> Yes, I can loudly tell people "I have a dream, unify all codec parsers!" :)
> But, I'm afraid that a big hammer doesn't work.  The topology is fairly
> different between codecs, and resolving all makes the parser complex.
> So, some hints would be needed to simplify the logic, after all.
>
>> 3) There is also the generic parser. It seems to be the one most capable
>> of handling randomly complex graphs, but is lacking automute/jack-detect
>> support, and maybe other functions as well (?).
>
> The generic parser is the very first parser, and it never worked rightly.
> This should be really replaced with a more clever one.

Hrmm...am I the only one thinking that your answer to 2) and 3) are in 
direct contradiction? :-)

I'm looking at fill_cx_auto_dacs. That doesn't look like Conexant 
specific stuff at all. cx_auto_hp_automute looks quite generic as well, 
except for a pointer deref in the beginning. 
cx_auto_build_output_controls could be merged with 
xxxx_create_multi_out_ctls present in the Realtek and Analog parsers. 
And so on.

Shouldn't we move and rename fill_cx_auto_dacs to hda_codec.c and use it 
for all codecs, instead of hardcoding dac nids everywhere? At least in 
general? (There might be exceptions, where there is a dac you don't want 
to use.)

Anyway, you wanted some work done to Conexant 5066. Could you clarify 
that a little? You likely want to call snd_hda_parse_pin_def_config - 
but are you expecting yet another auto-parser after that? Or just to 
choose model based on the result? And should we remove all the model 
quirks (except possibly for OLPC) afterwards?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
