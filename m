From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] ALSA: HDA: Fix jack creation for codecs
 with front and rear Line In
Date: Tue, 31 Jan 2012 19:52:32 +0800
Message-ID: <CAN8cciYsOdhpWOD-b5ybFuajamV89MB74=P7fV+ADY1DtyYsDA@mail.gmail.com>
References: <1327997055-7855-1-git-send-email-david.henningsson@canonical.com>
	<CAN8ccibRNQAEopWKYdifHcsa84xDYsbH6KmTUWiQrR7o0PvHNA@mail.gmail.com>
	<4F27BFFE.6090400@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E080103A74
	for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2012 12:52:34 +0100 (CET)
Received: by wera1 with SMTP id a1so4492374wer.38
	for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2012 03:52:34 -0800 (PST)
In-Reply-To: <4F27BFFE.6090400@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2012/1/31, David Henningsson <david.henningsson@canonical.com>:
> On 01/31/2012 09:29 AM, Raymond Yau wrote:
>> 2012/1/31, David Henningsson<david.henningsson@canonical.com>:
>>> If a codec has both a front and a rear Line In, two controls both
>>> named "Line Jack" will be created, which causes parsing to fail.
>>> While a long term solution might be to name the jacks differently,
>>> this extra check is consistent with what is already being done in many
>>> auto-parsers, and will also protect against other cases when two
>>> inputs have the same label.
>>>
>>> BugLink: https://bugs.launchpad.net/bugs/923409
>>> Signed-off-by: David Henningsson<david.henningsson@canonical.com>
>>> ---
>>
>> I have doubt since most of ad1988 6stack-dig quirks have two Line In (
>> one is ext front and the other is int ATAPI and the "Input Source"
>> controls are broken
>
> Well, it won't fix any "Input Source" controls, of course. Only jack
> creation later, assuming you have your autocfg struct set up correctly.
>

There is another bug in snd_hda_parse_def_pincfg() when bios assigned
two Line Out at ext front and rear 0x14 and 0x1b

autoconfig: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
   speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
   hp_outs=0 (0x0/0x0/0x0/0x0/0x0)
   mono: mono_out=0x0
   dig-out=0x1e/0x0
   inputs: Rear Mic=0x18 Front Mic=0x19 Line=0x1a


https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5518
