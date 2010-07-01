From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] - arecord - remove "front" and related
	devices from the output of list-pcm option of arecord
Date: Thu, 1 Jul 2010 17:44:04 +0800
Message-ID: <AANLkTilPjm8v_8Md0lopYGoFN4iPE5CNyd4QHiBFdv0f@mail.gmail.com>
References: <AANLkTinyBpf_qh6DGvj_V4UGY-JZUomNX6N32_WJpOjo@mail.gmail.com>
	<alpine.LNX.2.00.1007010745470.15497@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id E35B424584
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Jul 2010 11:44:06 +0200 (CEST)
Received: by vws11 with SMTP id 11so2158129vws.38
	for <alsa-devel@alsa-project.org>; Thu, 01 Jul 2010 02:44:04 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1007010745470.15497@eeebox2.perex-int.cz>
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

2010/7/1 Jaroslav Kysela <perex@perex.cz>

> On Thu, 1 Jul 2010, Raymond Yau wrote:
>
>  Replace "front" device by "hw" device  and remove "rear", "center_lfe" ,
>> "side" , "surroundxx" from the output of "arecord -L" since "front" device
>> cannot be used for capturing and the front device is for playback only  .
>>
>
> NAK. Fix alsa-lib/configuration to return proper "IOID".
>
>                                        Jaroslav
>

I have tried put "IOID" in many place such as usr/share/alsa/pcm/front.conf
,

it seem that hint_list_add() only add name and description in
alsa-lib/src/control/namehint.c

hint_list_add(struct hint_list *list,
             const char *name,
             const char *description)

I wonder "IOID" was never added to the hint list and that is why all devices
are Input/Output

dsnoop should be input and dmix should be output
