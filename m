From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 2/3] ALSA: HDA: Rename "Front" to "Master
 Front" on ALC861VD and ALC887
Date: Mon, 22 Nov 2010 09:42:46 +0100
Message-ID: <4CEA2D06.4010205@canonical.com>
References: <4CE64381.4070003@canonical.com> <s5h1v6dsvgl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D1C3103886
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 09:42:47 +0100 (CET)
In-Reply-To: <s5h1v6dsvgl.wl%tiwai@suse.de>
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

On 2010-11-22 07:50, Takashi Iwai wrote:
> At Fri, 19 Nov 2010 10:29:37 +0100,
> David Henningsson wrote:
>>
>> Since "Front" controls headphones as well on these two codecs,
>> they should be labeled "Master Front" in order to be handled correct
>> by PulseAudio.
>
> Well, "Front" doesn't mean the physical output but rather the output
> channels.  So, it doesn't conflict with the fact that this control
> actually changes all outputs, as long as the output jacks are of front
> channels.  In that sense, even "Surround" is also a sort of Master
> control.
>
> That being said, I'm not happy with this rename.  If any, we should
> try to get rid of unnecessary front volume control.  But, just because
> PA gets confused doesn't sound like a right reason.
>
> Could you give the alsa-info.sh output for checking what mixer elements
> are created?

As you know PulseAudio needs consistent naming of volume controls, and 
this is not expressed clearly enough in the docs, so, what would you 
call a volume control that controls a front-line-out, but does not 
control a front-speaker or a front-headphone? PulseAudio assumes that if 
a control is named "Front", it does just that. So that's why I would 
prefer a rename to "Master Front".

As for alsa-info output, I believe anything in hda-emu/codecs/alc861vd-* 
would do, as they have nsteps=0 on NIDs 0x0c - 0x0f.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
