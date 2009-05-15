From: Nickolas Lloyd <ultrageek.lloyd@gmail.com>
Subject: Re: [PATCH] snd-hda-intel: add controls to toggle DC
 bias on mic ports
Date: Fri, 15 May 2009 15:17:27 +0000
Message-ID: <4A0D8787.9010104@gmail.com>
References: <4A0B14B8.2030705@gmail.com> <s5hoctua2ne.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 85B781039B9
	for <alsa-devel@alsa-project.org>;
	Sat, 16 May 2009 00:08:33 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so1543921ywq.2
	for <alsa-devel@alsa-project.org>; Fri, 15 May 2009 15:08:32 -0700 (PDT)
In-Reply-To: <s5hoctua2ne.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Matthew Ranostay <mranostay@embeddedalley.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 13 May 2009 18:43:04 +0000,
> Nickolas Lloyd wrote:
>   
>> This patch adds a mixer control for the STAC92XX boards to control the
>> DC bias of mic ports, allowing recording from both powered and
>> non-powered sources.  It replaces the "Mic Output Switch" with "Mic Jack
>> Mode" to switch between Mic, Line In, and Line Out.
>>
>> Signed-off by: Nickolas Lloyd <ultrageek.lloyd@gmail.com>
>>
>> Note: diffed against alsa-driver-20090513
>>     
>
> Thanks, applied now.
>
> BTW, I think we should change also "Line as Output Switch" to "Line-In
> Jack Mode" or so to make the code consistent.  Care to create a patch?
>
>
> Takashi
>
>   
I'd be happy to.  Also, as it is now, the control will only be added if
autocfg.line_out_type is set to AUTO_PIN_LINE_OUT, so this control may
not be added for all mic ports.  I was thinking of making the enum show
only two entries, Line in and Mic in for these other mics.  Thoughts?

Thanks,
Nick
