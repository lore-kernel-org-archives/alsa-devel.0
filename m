From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v2] ALSA: snd-usb-usx2y: remove bogus frame
	checks
Date: Mon, 07 Oct 2013 17:34:37 +0200
Message-ID: <5252D48D.5060608@gmail.com>
References: <1380728990-8443-1-git-send-email-zonque@gmail.com>
 <1381048163.1974.5.camel@yoda.heavyware> <27085905.a7dazzfD9V@arial>
 <5252CF30.7030002@gmail.com> <s5ha9ildrge.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f48.google.com (mail-bk0-f48.google.com
 [209.85.214.48])
 by alsa0.perex.cz (Postfix) with ESMTP id A1A4826516E
 for <alsa-devel@alsa-project.org>; Mon,  7 Oct 2013 17:34:39 +0200 (CEST)
Received: by mail-bk0-f48.google.com with SMTP id my13so2690237bkb.35
 for <alsa-devel@alsa-project.org>; Mon, 07 Oct 2013 08:34:39 -0700 (PDT)
In-Reply-To: <s5ha9ildrge.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Guido Aulisi <guido.aulisi@gmail.com>, Dr Nicholas J Bailey <nicholas.bailey@glasgow.ac.uk>
List-Id: alsa-devel@alsa-project.org

On 07.10.2013 17:35, Takashi Iwai wrote:
> At Mon, 07 Oct 2013 17:11:44 +0200,
> Daniel Mack wrote:
>>
>> On 07.10.2013 16:58, Dr Nicholas J Bailey wrote:
>>> For me, this patch alone fails in much the same way (possibly exactly the same 
>>> way) as before the previous patch.
>>>
>>> From audacity (probably not much use unless you know the source code... I 
>>> don't):
>>
>> [...]
>>
>>> nick@arial:/usr/src$ dmesg | tail
>>> [  111.667015] usb 2-1.6.4: New USB device strings: Mfr=0, Product=0, 
>>> SerialNumber=0
>>> [  114.707156] Sequence Error!(hcd_frame=3 ep=8in;wait=1024,frame=0).
>>> [  114.707156] Most probably some urb of usb-frame 1024 is still missing.
>>
>> You certainly haven't booted a kernel which contains the patch we're
>> talking about here. The only occurance of the error message you quote
>> was removed by this patch, so a patched kernel can't possibly produce
>> what you see in your logs.
> 
> Nicholas booted a kernel without your fix patch but only with my patch
> to disable the -EPIPE check, in order to see whether the latter alone
> suffices or not.  So he's testing with a right kernel :)

Oh, so *I* was referring to the wrong patch then.
Apologies for causing confusion :)


Daniel
