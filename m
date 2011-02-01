From: David Henningsson <david.henningsson@canonical.com>
Subject: Codecs without auto-parser (was: ALSA: HDA: Fix
 microphone(s) on Lenovo	Edge 13)
Date: Tue, 01 Feb 2011 08:37:25 +0100
Message-ID: <4D47B835.7090502@canonical.com>
References: <4D413CBE.9080409@canonical.com>
	<s5hd3nhcv7u.wl%tiwai@suse.de>	<4D42ADC2.7090001@canonical.com>
	<s5h1v3xw7o7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 3517B2438E
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 08:37:28 +0100 (CET)
In-Reply-To: <s5h1v3xw7o7.wl%tiwai@suse.de>
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

On 2011-01-28 13:10, Takashi Iwai wrote:
> At Fri, 28 Jan 2011 12:51:30 +0100,
> David Henningsson wrote:
>>
>> On 2011-01-28 09:01, Takashi Iwai wrote:
>>> And I hope that we should go further a bit for now -- more clean up of
>>> the cxt5066 code either checking BIOS pins or hp/mic/spk pre-defined
>>> pins.  Currently, the code is fairly messy (partly because of olpc
>>> support), and now is a good chance to improve it a bit more.
>>
>> Maybe so. I'm not sure I can commit to doing that work right now, as I
>> have other work commitments waiting for me to take care of them.
>
> OK.

Hmm. I got a few things cleared up yesterday, and so I might have some 
time to actually do this. However, it also seems like I have to fix an 
AD1984A machine, and that driver is in equally bad shape (as in: no 
auto-parser, just a list of models). I could add another model, but 
suppose I'd do this the right way, how would I do it?

I guess there are three options to start off with:

1) ad1988 seems to have an auto-parser. There are a lot of hardcoded 
nids in there, but I guess I could copy-and-paste some into a new 
auto-parser for ad1984a.

2) It seems to me like the most competent candidate for auto-parser 
currently is the cx_auto stuff - compared to other auto-parsers the 
hardcoded nids are fewer. Perhaps this one could be extended to also do 
auto-parsing for codecs from other vendors? Or at least some convenience 
functions moved to hda_codec.c in order to remove duplication between 
vendors?

3) There is also the generic parser. It seems to be the one most capable 
of handling randomly complex graphs, but is lacking automute/jack-detect 
support, and maybe other functions as well (?).

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
