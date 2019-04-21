From: ecmk <info@ecmk.org>
Subject: Re: Kernel patch needed for Asus Q325UAR
Date: Sun, 21 Apr 2019 11:24:31 -0700
Message-ID: <c341a56c-be1d-2301-1bde-b8eb403c6391@ecmk.org>
References: <1887e6cb-0c33-664c-d3be-c282d8b797de@ecmk.org>
 <s5hmukp3s6o.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 31B12F80730
 for <alsa-devel@alsa-project.org>; Sun, 21 Apr 2019 20:24:40 +0200 (CEST)
In-Reply-To: <s5hmukp3s6o.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I just want to confirm that with kernel version 5.0.7-200 the problem 
still exists for Asus Q325UAR

Let me know if you need any additional information for the patch.

Thanks!

On 4/17/19 2:19 AM, Takashi Iwai wrote:
> On Fri, 12 Apr 2019 23:43:50 +0200,
> ecmk wrote:
>> No sound combined with quickly fading sounds for a few
>> seconds. Randomly working but with low quality distorted sound. The
>> model needs to be added to the kernel patch listed bellow.
>>
>>
>> Asus Q325UAR suffers from the same issues as discussed here:
>>
>>
>> [alsa-devel] [PATCH] ALSA: hda/realtek: Enable audio jacks of ASUS
>> UX391UA with, ALC294
>>
>> https://mailman.alsa-project.org/pipermail/alsa-devel/2018-December/143282.html
>>
>>
>> A detailed issue of the problem plus the solution is described here
>>
>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1784485?comments=all
> Hm, from the reports there, it's not clear whether the existing quirk
> for UX391UA works for your device.  Did you actually test it?  If yes,
> please give alsa-info.sh output running on your machine (with
> --no-upload option), so that I can cook up a patch.
>
>
> thanks,
>
> Takashi
