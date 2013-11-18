From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: Audio Mini Conference Minutes - Edinburgh 21st
 October 2013
Date: Mon, 18 Nov 2013 17:35:42 +0000
Message-ID: <1384796142.2319.12.camel@loki>
References: <1382985876.2334.64.camel@loki>
 <CA+v+29hOBcuH-teW+5si8qj9QD7o3bsMYFj8v-YfKJRM0XVn8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 978B0260818
 for <alsa-devel@alsa-project.org>; Mon, 18 Nov 2013 18:35:48 +0100 (CET)
In-Reply-To: <CA+v+29hOBcuH-teW+5si8qj9QD7o3bsMYFj8v-YfKJRM0XVn8w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wang Xingchao <wangxingchao2011@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, wangxingchao@xiaomi.com, ruyi@xiaomi.com, Eric Laurent <elaurent@google.com>
List-Id: alsa-devel@alsa-project.org

Hi Xingchao,

On Sat, 2013-11-16 at 17:01 +0800, Wang Xingchao wrote:
> Hi Liam,
> 
> Very exciting meeting, very nice meeting minutes, thanks very much!
> I'm quite interested with the "24 Bit HiRes Audio for Android" part,
> see comments inline.
> 
> 2013/10/29 Liam Girdwood <liam.r.girdwood@linux.intel.com>:

> >
> >
> > 24 Bit HiRes Audio for Android
> > ------------------------------
> >
> > How do we handle 24 bit audio at fast rates e.g. 192kHz. Being pushed by market.
> > Flac suggested as source media and not PCM.
> >
> > We could use offload, on roadmap for Hires audio on android PCM,
> > maybe float instead of 24 bit. Need for 192kHz, Probably not use effects.
> >
> 
> Now i'm working on Xiaomi TV and it's a very cool product,see page
> introduction here:
> http://www.xiaomi.com/mitv
> (Sorry here's only Chinese page yet, no english version. But hopefully
> you're attracted with the pictures)
> 
> It's running Android with Qualcom&Mstar's chipset. i hope we can
> support High Bit Rate audio with HDMI output
> in next generation, so i would see more update about this in Android.
> 
> Does android support HBR audio now? As i know from Dolby guys, no
> customers in Android area are buying Dolby TrueHD license, so i guess
> the answer is NO. Most of the customers are from AV receivers and
> BlueRay players.

Afaik, no one is using high Bit rate audio atm, but there is increasing
interest amongst Android OEMs.

> 
> Intel HDA claimed support HBR audio but i donot know if there's any
> ARM based chipset vendor claim supporting HBR audio with their HDMI controller.
> Even the ARM HDMI controller supports HBR transferring, seems Android
> software doesnot support yet. So given some vendors support HBR audio
> under
> Android, they're using private APIs, and the code maybe not in upstream yet.
> 

Most of the x86 and ARM HW will support HBR audio over ASoC PCM DAIs and
HDA, but I'm not sure about which HDMI audio devices support HBR in HW
atm...

ALSA certainly has support in the SW stack, so we probably looking at
having HBR added to the Android audio stack. 

> For TV and set-top boxes in home theater, users have higher quality
> requirement, just as you mentioned above. I would like xiaomi could
> know more schedule about this feature implementation and ready to make
> some contribution. we have plenty of users for testing every week of
> such cool features, so if any guys have codes ready for test under
> Android, it's really a good chance.
> 

It's probably best if you speak privately with Eric about helping with
development and testing of HBR audio.

Regards

Liam
