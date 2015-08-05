From: Kailang <kailang@realtek.com>
Subject: Re: Verb for 0x17 pin config
Date: Wed, 5 Aug 2015 07:07:06 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A17A1F78C@RTITMBSV09.realtek.com.tw>
References: <6FAB7C47BCF00940BB0999A99BE3547A17A1F778@RTITMBSV09.realtek.com.tw>
 <s5hh9oeb4qy.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DB43265B97
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 09:07:10 +0200 (CEST)
In-Reply-To: <s5hh9oeb4qy.wl-tiwai@suse.de>
Content-Language: zh-TW
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
Cc: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

 

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de] 
> Sent: Wednesday, August 05, 2015 2:59 PM
> To: Kailang
> Cc: (alsa-devel@alsa-project.org)
> Subject: Re: Verb for 0x17 pin config
> 
> On Wed, 05 Aug 2015 08:42:03 +0200,
> Kailang wrote:
> > 
> > Hi Takashi,
> >  
> > commit 
> > 
> http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/?id
> > =977e627684df0f60bdf2a768ec4772f42fe843fc
> > ALSA: hda/realtek - Support Dell headset mode for ALC298
> > 
> > Dell had use verb to do speaker preset. So, The same SSID 
> maybe 0x17 verb was different.
> > 
> > 0x17 0x90170110
> > 0x17 0x90170140
> > 0x17 0x90170150
> > 
> > Upper verb will show on this case.
> > 
> > Could I change it to quirk for SSID?
> 
> It would be one option.  OTOH, right now we have a patch to 
> add 0x90170110, so the only missing is 0x90170150.  Just 
> adding it would be an easier option, I suppose.
> 
So, you mean I add as below patch.

+	SND_HDA_PIN_QUIRK(0x10ec0298, 0x1028, "Dell", ALC298_FIXUP_DELL1_MIC_NO_PRESENCE,
+		ALC298_STANDARD_PINS,
+		{0x12, 0x90a60130},
+		{0x13, 0x40000000},
+		{0x14, 0x411111f0},
+		{0x17, 0x90170110},
+		{0x1d, 0x4068a36d},
+		{0x21, 0x03211020}),

+	SND_HDA_PIN_QUIRK(0x10ec0298, 0x1028, "Dell", ALC298_FIXUP_DELL1_MIC_NO_PRESENCE,
+		ALC298_STANDARD_PINS,
+		{0x12, 0x90a60130},
+		{0x13, 0x40000000},
+		{0x14, 0x411111f0},
+		{0x17, 0x90170150},
+		{0x1d, 0x4068a36d},
+		{0x21, 0x03211020}),

Right?


> 
> Takashi
> 
> ------Please consider the environment before printing this e-mail.
> 
