From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Lost dB volumes on USB headset between 2.6.38 and
	3.0
Date: Tue, 16 Aug 2011 22:00:10 +0800
Message-ID: <CAN8cciZN9SQuJ0bLuTXKxujWU7qyzk2-bhavKFE6fHk1zNdqVw@mail.gmail.com>
References: <4E410361.7010808@canonical.com> <4E410E7D.8050903@ladisch.de>
	<4E4117C9.2090100@colin.guthr.ie> <s5hwremdagh.wl%tiwai@suse.de>
	<4E4A6338.6020309@colin.guthr.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 3582424424
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Aug 2011 16:02:03 +0200 (CEST)
Received: by fxh10 with SMTP id 10so4551fxh.38
	for <alsa-devel@alsa-project.org>; Tue, 16 Aug 2011 07:01:59 -0700 (PDT)
In-Reply-To: <4E4A6338.6020309@colin.guthr.ie>
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

2011/8/16 Colin Guthrie <gmane@colin.guthr.ie>:
> 'Twas brillig, and Takashi Iwai at 09/08/11 13:40 did gyre and gimble:
>> At Tue, 09 Aug 2011 13:19:37 +0200,
>> Colin Guthrie wrote:
>>>
>>>>
>>>> There are patches that might have introduced bugs, but these two patches
>>>> do remove dB information intentionally:
>>>>
>>>> ALSA: usb-audio - Don't expose broken dB ranges:
>>>> http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=59bb7f0eebe6


Revert this patch fix the problem for my logitech webcam
since dBmin and dBmax are still zero

ALSA endpoint.c:450: 2:3:1: add audio endpoint 0x86
dBMin 0 dBMax 0  min 0 max 1
control 1  UAC_FU_VOLUME 2
ALSA mixer.c:1186: [5] FU [Mic Capture Switch] ch = 1, val = 0/1/1
ALSA mixer.c:805: 5:2: cannot get min/max values for control 2 (id 5)
control 2  UAC_FU_VOLUME 2
dBmin 0 dBmax 0
ALSA mixer.c:1186: [5] FU [Mic Capture Volume] ch = 1, val = 0/1/1
ALSA mixer.c:805: 5:2: cannot get min/max values for control 2 (id 5)
usbcore: registered new interface driver snd-usb-audio
dBMin 1800 dBMax 3000  min 1200 max 1e00
