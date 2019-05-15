From: ayman.bagabas@gmail.com
Subject: Re: [PATCH v1 2/2] sound: Enable micmute led for Huawei laptops
Date: Wed, 15 May 2019 16:54:23 -0400
Message-ID: <39f32949f84185c87b245b594131824b1865d1ee.camel@gmail.com>
References: <20190513203009.28686-1-ayman.bagabas@gmail.com>
         <20190513203009.28686-3-ayman.bagabas@gmail.com>
         <s5hk1erj20h.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hk1erj20h.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Hui Wang <hui.wang@canonical.com>, Chris Chiu <chiu@endlessm.com>, Daniel Drake <drake@endlessm.com>, Jian-Hong Pan <jian-hong@endlessm.com>, Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, Jaroslav Kysela <perex@perex.cz>, Kailang Yang <kailang@realtek.com>, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2019-05-15 at 15:11 +0200, Takashi Iwai wrote:
> On Mon, 13 May 2019 22:30:06 +0200,
> Ayman Bagabas wrote:
> > Since this LED is found on huawei laptops, we can hook it to
> > huawei-wmi platform driver which uses the common WMI interface
> > present
> > in these laptops to control the LED.
> > 
> > I've also made some renames and used product name instead of common
> > name
> > to avoid confusion.
> > 
> > Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
> 
> This looks applicable independently from the patch 1?
> If so, it can go via sound git tree while another via x86-platform
> tree.
> 

Yes it is. Will send another one.

> 
> thanks,
> 
> Takashi
> 
