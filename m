From: Wang Xingchao <wangxingchao2011@gmail.com>
Subject: Re: Can Realtek HD-A codec ALC282 support D3cold?
Date: Wed, 17 Apr 2013 11:52:50 +0800
Message-ID: <CA+v+29g9FQiP7cfwqxP2Ht-cGsD__v_K6-DF4-5kKbUJNPJ9Aw@mail.gmail.com>
References: <F46914AEC2663F4A9BB62374E5EEF8F8384425@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-da0-f44.google.com (mail-da0-f44.google.com
 [209.85.210.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 173C9261091
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 05:53:11 +0200 (CEST)
Received: by mail-da0-f44.google.com with SMTP id z20so570711dae.3
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 20:53:10 -0700 (PDT)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F8384425@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Mengdong,

2013/4/16 Lin, Mengdong <mengdong.lin@intel.com>
>
> Hi,
>
> (Sorry to post this message again)
>
> We want to put an idle HD-A codec into D3cold for more power saving and preparation for being power gated. The Realtek ALC282 is used in our test.
> Could anyone help to confirm whether ALC282 can support D3cold or not?
>
> I'm told that ALC282 can support D3cold. But my test shows it cannot.

Windows enabled D3Cold feature on ALC282 but it's close source so we
cannot assume it's the same thing for Linux. :)

>
> At first, ALC282 HW does not report that it can support D3cold.
> Its parameter "Supported Power States" returns 0xc000000f, means it only supports:  EPSS, CLKSTOP, D3hot, D2, D1 and D0.
> Is this a just mistake in reporting the bit, or D3cold is not supported all?
>

At least it reports it DOESNOT support D3Cold here, so i think at
least the D3cold verb donot work well, otherwise it's obvious a BUG.

Maybe There's some private operations to make ALC282 export the
feature of D3cold, could some guys from Realtek clarify this?

thanks
--xingchao
> Then when I explicitly set the audio function group to D3cold by verb 0x705, and then get its power state after 200ms by verb 0xf05,
> The codec response is 0x00000000: No PS-Error, both PS-Act and PS-set is D0. So it seems codec HW does not process the set power state command at all.
>
> Is there someone from Realtek or familiar with ALC282 here can share some information about this issue?
>
> Many thanks
> Mengdong
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
