From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: [PATCH - aplay 1/1] aplay - option to dump
	HW	parameters
Date: Mon, 05 Mar 2012 15:43:08 +0100
Message-ID: <4F54D0FC.60103@ivitera.com>
References: <1330720378-24855-1-git-send-email-pavel.hofman@ivitera.com>
	<s5hfwdn6s90.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
	[84.242.75.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A42610432C
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 15:46:11 +0100 (CET)
In-Reply-To: <s5hfwdn6s90.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 5.3.2012 15:23, Takashi Iwai napsal(a):
> At Fri,  2 Mar 2012 20:32:58 +0000,
> pavel.hofman@ivitera.com wrote:
>>
>> From: Pavel Hofman <pavel.hofman@ivitera.com>
>>
>> Dumping HW parameters of the current device with snd_pcm_hw_params_dump,
>> a new option --dump-hw-params added.
> 
> Well, the purpose and the actual operation of this option is a bit
> unclear with such a short description.  Your patch adds the output of
> the pre-config state of the hw_params.  It makes sense since the
> post-config state is shown via -v option.  If this is the intended
> behavior, please write a bit more details in the man page.
> 
> 

Takashi, thanks for your reply. Could I call it hardware capabilities of
the device? Because that is what I think it is. E.g. I fixed that
ice1724 rate-lock incompletion with help of this dump and people have
been asking me about listing similar to ossinfo -v4.

Pavel.
