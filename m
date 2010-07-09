From: "Viliam Kubis" <viliam.kubis@gmail.com>
Subject: Re: Smart 5.1 function not working on VIA VT1708S with
 *three* jacks on mainboard
Date: Fri, 09 Jul 2010 13:05:00 +0200
Message-ID: <op.vfko2mysy9cctd@localhost>
References: <op.ve4vig0ny9cctd@localhost> <op.vff0au0jy9cctd@localhost>
	<4C35713E.1090709@ladisch.de> <op.vfi2hgary9cctd@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 7862610388E
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Jul 2010 13:05:02 +0200 (CEST)
Received: by mail-bw0-f51.google.com with SMTP id 4so1038905bwz.38
	for <alsa-devel@alsa-project.org>; Fri, 09 Jul 2010 04:05:02 -0700 (PDT)
In-Reply-To: <op.vfi2hgary9cctd@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I have tried the patch on clean (unpatched) patch_via.c. dmesg prints
out ***PATCH 08/07/10 as expected, but the surround does not work.
Surround and cen/lfe controls are also not created for alsamixer without
other patches. What does work is specifying -Dsurround40 for
speaker-test but there is no sound from rear speakers. If you want, I
can post the whole patched patch_via.c somewhere or we can work on new
patches starting with this one.

  On Thu, 08 Jul 2010 08:33:34 +0200, Clemens Ladisch <clemens@ladisch.de>
  wrote:

>> Viliam Kubis wrote:
>>> Hello, for quite some time the "Smart 5.1" function in alsa is not  
>>> working
>>> properly when motherboard has only 3 audio jacks.
>>>
>>> speaker-test -c 4 -t wav -Dsurround40
>>>
>>> Channels count (4) not available for playbacks: Invalid argument
>>
>> Please try the patch below.
>>
>> (This function uses 0x12 and 0x13 as the NIDs for the center/LFE and
>> side DACs.  Shouldn't these be 0x24 and 0x25, as per the datasheet?)
>>
>> --- a/sound/pci/hda/patch_via.c
>> +++ b/sound/pci/hda/patch_via.c
>> @@ -2265,6 +2265,13 @@ static int vt1708_auto_fill_dac_nids(str
>>  		}
>>  	}
>> +	/* for Smart 5.1, line/mic inputs double as output pins */
>> +	if (cfg->line_outs == 1) {
>> +		spec->multiout.num_dacs = 3;
>> +		spec->multiout.dac_nids[AUTO_SEQ_SURROUND] = 0x11;
>> +		spec->multiout.dac_nids[AUTO_SEQ_CENLFE] = 0x12;
>> +	}
>> +
>>  	return 0;
>>  }
>>
>


-- 
Using Opera's revolutionary e-mail client: http://www.opera.com/mail/
