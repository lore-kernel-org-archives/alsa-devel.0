From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Subject: Re: [PATCH] ALSA: hda: Add support for Medion WIM2160
Date: Wed, 07 Apr 2010 13:59:37 +0200
Message-ID: <4BBC73A9.4040008@gmail.com>
References: <j2mb2e8f9f71004060912n88d89a79ke46f427aee6c22cb@mail.gmail.com>	<s5h1ves4iol.wl%tiwai@suse.de>	<k2kb2e8f9f71004061008tc94b8ff7w2295d146211d1d2d@mail.gmail.com>	<s5hy6gzdcbd.wl%tiwai@suse.de>	<4BBC710C.3090802@gmail.com>
	<s5hk4sj3252.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f219.google.com (mail-ew0-f219.google.com
	[209.85.219.219])
	by alsa0.perex.cz (Postfix) with ESMTP id D2BEE1037FE
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Apr 2010 13:59:41 +0200 (CEST)
Received: by ewy19 with SMTP id 19so467029ewy.22
	for <alsa-devel@alsa-project.org>; Wed, 07 Apr 2010 04:59:41 -0700 (PDT)
In-Reply-To: <s5hk4sj3252.wl%tiwai@suse.de>
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

Op 07-04-10 13:58, Takashi Iwai schreef:
> At Wed, 07 Apr 2010 13:48:28 +0200,
> Maurus Cuelenaere wrote:
>    
>> Op 07-04-10 08:08, Takashi Iwai schreef:
>>      
>>> At Tue, 6 Apr 2010 19:08:45 +0200,
>>> Maurus Cuelenaere wrote:
>>>
>>>        
>>>> [1<text/plain; UTF-8 (quoted-printable)>]
>>>> Sorry, forgot to reply-all.
>>>>
>>>> On Tue, Apr 6, 2010 at 19:03, Takashi Iwai<tiwai@suse.de>   wrote:
>>>>
>>>>          
>>>>> At Tue, 6 Apr 2010 18:12:52 +0200,
>>>>> Maurus Cuelenaere wrote:
>>>>>
>>>>>            
>>>>>> This adds support for the Medion WIM2160 soundcard.
>>>>>> There's no PCI quirk added because it has the same PCI id as the
>>>>>> Medion MD2.
>>>>>>
>>>>>> Signed-off-by: Maurus Cuelenaere<mcuelenaere@gmail.com>
>>>>>>
>>>>>>              
>>>>> Thanks for the patch.
>>>>>
>>>>> Before applying it, a usual question -- doesn't model=auto work for
>>>>> your device?  If not, please give alsa-info.sh output (run with
>>>>> --no-upload option).
>>>>>
>>>>>
>>>>>            
>>>> Last time I tried, it didn't. Do you want me to retry?
>>>>
>>>>          
>>> Yes, please.  Please elaborate what didn't work, and give the
>>> corresponding alsa-inf.sh output, too.
>>>
>>>        
>> I've tried several different configurations, all of these were performed
>> by booting the kernel with bootparameter "snd-hda-intel.model=<model>"
>>
>> model=medion-wim2160: audio works, hp switching works, hp works
>> model=generic: audio works, hp does not
>> no parameters: nothing works
>> model=auto: audio works, hp does not
>>
>> The odd thing is that yesterday model=auto worked great, even including
>> automatic headphone switching..
>> Does the HDA chip perhaps retain its configuration across warm/cold reboots?
>>
>> Also, sometimes I needed to unmute and increase the volume when booting
>> some configurations.
>>      
> I fixed a few things today, and it might have broken.  Or your version
> didn't include the fix yet?  Anyway, please specify what version
> you've tested.
>
> If you tested git tree, use
>    git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
> either master, for-next or topic/hda branch.
>
> If you build from alsa-driver external tree, use snapshot tarball
>    ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-snapshot.tar.gz
>
> The corresponding GIT commits can be found in alsa-driver/HEAD and
> alsa-driver/alsa-kernel/HEAD files.
>    

I've been using official 2.6.33, I can try your git tree.

Do you want me to test it with model=auto?

-- 
Maurus Cuelenaere
