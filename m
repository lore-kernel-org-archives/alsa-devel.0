From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC PATCH] Inverted internal mic
Date: Tue, 19 Jun 2012 09:43:07 +0200
Message-ID: <4FE02D8B.7050201@canonical.com>
References: <4F4C9714.1080307@canonical.com> <s5haa43ux7u.wl%tiwai@suse.de>
	<4F4CA438.90103@canonical.com> <s5hvcmrp7ji.wl%tiwai@suse.de>
	<4F4CD1AF.2050409@canonical.com> <s5hboojozx7.wl%tiwai@suse.de>
	<4F4CE264.7040008@canonical.com>
	<loom.20120619T050139-760@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 2FB562433F
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jun 2012 09:43:09 +0200 (CEST)
In-Reply-To: <loom.20120619T050139-760@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 06/19/2012 05:07 AM, Eliot Blennerhassett wrote:
> David Henningsson<david.henningsson<at>  canonical.com>  writes:
>> On 02/28/2012 02:22 PM, Takashi Iwai wrote:
>>> At Tue, 28 Feb 2012 14:07:59 +0100,
>>> David Henningsson wrote:
>>> Is there a way we can
>>>> know the corresponding processing coefficients to set for ALC268 and
>>>> ALC272X as well?
>>>
>>> AFAIK, no, it was specific to the codec model.
>>
>> Ok, then we can only hope for Kailang to supply this information if
>> possible. And if not possible we could attempt the workaround (when/if
>> we agree on it...) for these devices as well?
>
> Greetings,
>
> Any chance that there has been any progress on this?
> I have a machine with dmic and ALC272X (details below) that exhibits this
> problem, and can test any proposed patch.

We have a patch in for the Thinkpad U300s, but that one had a Conexant 
codec.
I haven't had time to start working on kernel patches for the Realtek 
ones yet, but meanwhile, I'm tracking known machines here:

https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1002978

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
