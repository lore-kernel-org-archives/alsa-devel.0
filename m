From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 2/2] ALSA: Integrate control based jack
 reporting with core jack reporting
Date: Wed, 08 Feb 2012 14:35:29 +0100
Message-ID: <4F327A21.8030805@canonical.com>
References: <1328644128-32630-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1328644128-32630-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4F323405.8080902@canonical.com>
	<20120208114642.GG3120@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 9F41524419
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 14:35:30 +0100 (CET)
In-Reply-To: <20120208114642.GG3120@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On 02/08/2012 12:46 PM, Mark Brown wrote:
> On Wed, Feb 08, 2012 at 09:36:21AM +0100, David Henningsson wrote:
>> On 02/07/2012 08:48 PM, Mark Brown wrote:
>
>> I'd like these to match the names currently used in HDA, like this:
>
>> 	{ SW_MICROPHONE_INSERT, "Mic" },
>
> It seems odd to abbreviate this and nothing else but I'm not that
> fussed either way.
>
>> 	{ SW_LINEOUT_INSERT, "Line-Out" },
>> 	{ SW_VIDEOOUT_INSERT, "Video-Out" },
>
> For these it's really not normal English to hyphenate them, it looks
> strange to do so.

I guess it could be easier to parse if we avoid spaces in names, but 
right now there is no such parser AFAIK anyway, so it does not matter 
much. Video-Out is not present in HDA; I did that change to make it 
consistent with "Line-Out".

>> 	{ SW_LINEIN_INSERT, "Line" },
>
> It seems odd and a bit undescriptive to not specify the description here
> when it is specified for the outputs?
>
>> Actually, it matters less if we settle on the standard you set
>> above, or what the HDA currently does, as long as the names are the
>> same.
>
> Except for Mic where I don't mind either way I'd rather bring the HDA
> names into (but note that the idea is to remove the HDA specific jack
> controls - I think these names are used in other places though?).

I'll let Takashi have the final say about the names. But note that for 
HDA these names will not be enough, e g, we might have one "Front Mic" 
and one "Rear Mic" and need to know which one is which.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
