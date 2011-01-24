From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 2/2] ALSA: HDA: Add a new model "asus" for
	Conexant 5066/205xx
Date: Mon, 24 Jan 2011 13:12:39 +0100
Message-ID: <4D3D6CB7.5070102@canonical.com>
References: <4D398008.8080707@canonical.com> <s5hzkqshpdm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 9ACE92440F
	for <alsa-devel@alsa-project.org>; Mon, 24 Jan 2011 13:12:42 +0100 (CET)
In-Reply-To: <s5hzkqshpdm.wl%tiwai@suse.de>
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

On 2011-01-22 17:31, Takashi Iwai wrote:
> At Fri, 21 Jan 2011 13:46:00 +0100,
> David Henningsson wrote:
>>
>> BugLink: http://bugs.launchpad.net/bugs/701271
>>
>> This new model, named "asus", is identical to the "hp_laptop" model,
>> except for the location of the internal mic, which is at pin 0x1a.
>> It is used for Asus K52JU and Lenovo G560.
>>
>> Signed-off-by: David Henningsson<david.henningsson@canonical.com>
>
> Applied, but to topic/asoc branch, as these involve rewrites.
> Thanks.

You mean the topic/hda branch, right? Does this mean it'll not be in 
2.6.38, and will it be if I provide a backport for the second patch?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
