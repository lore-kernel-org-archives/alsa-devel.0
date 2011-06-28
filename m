From: Liam Girdwood <lrg@ti.com>
Subject: Re: Jack event API - decision needed
Date: Tue, 28 Jun 2011 17:34:28 +0100
Message-ID: <4E0A0294.5060804@ti.com>
References: <4DFF4D15.6050809@canonical.com>	<20110627120743.GA20707@sirena.org.uk>
	<4E0A00E3.5000102@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id C2BFA103890
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Jun 2011 18:34:35 +0200 (CEST)
In-Reply-To: <4E0A00E3.5000102@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kay Sievers <kay.sievers@vrfy.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Graeme Gregory <gg@slimlogic.co.uk>, Lennart Poettering <lennart@poettering.net>
List-Id: alsa-devel@alsa-project.org

On 28/06/11 17:27, David Henningsson wrote:
> On 2011-06-27 13:07, Mark Brown wrote:
>> On Mon, Jun 20, 2011 at 03:37:25PM +0200, David Henningsson wrote:
>>
>>> 1) We're continuing the path with /dev/input devices
>>
>>> 2a) We'll rewrite these devices to be read-only ALSA mixer controls
>>
>>> 2b) We'll rewrite these devices to be something within ALSA, but not
>>> exactly mixer controls.
>>
>>> For options 2a) and 2b) I guess the existing /dev/input thing should be
>>> deprecated and/or removed. So part of decision should maybe be based on
>>> information about how widespread the usage of these devices are
>>> currently...?
>>
>> So, this discussion seems to have ground to a halt.
> 
> Yes, unfortunately, and without a clear consensus. That puts me in a 
> difficult position, because I'm trying to get the job done. And very 
> preferrable, in the next release of Ubuntu (which is to be released on 
> October this year). I've been talking to a few of my colleagues here at 
> Canonical, and here's how we reason currently:
> 
> We have the input layer. We also have a set of patches for supporting 
> this in PulseAudio (although currently unmerged and I'm not sure about 
> their current quality/state).

I know that these are working on Panda and that Graeme is addressing review comments for upstream. Don't know his ETA yet though.

Liam
