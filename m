From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: IEC61937/SPDIF
Date: Tue, 14 Jun 2011 21:09:43 +0300
Message-ID: <4DF7A3E7.5080907@iki.fi>
References: <BANLkTik_MxbjfXDu13=ajRoaOUucHT+HWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tulikuusama.dnainternet.net (tulikuusama.dnainternet.net
	[83.102.40.132]) by alsa0.perex.cz (Postfix) with ESMTP id 41148244DA
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Jun 2011 20:09:49 +0200 (CEST)
In-Reply-To: <BANLkTik_MxbjfXDu13=ajRoaOUucHT+HWA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ajay khandelwal <ajay.lforum@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 14.06.2011 15:47, ajay khandelwal wrote:
> Hi All,

Hi!

I've worked with IEC61937, but I'm no ALSA expert, so I hope others
correct me if I'm wrong.

>  I have to develop driver for SPDIF output of my board connected to HDMI.
> 
> I'm not sure for following (specially IEC61937)
> 1) How should driver know if it is compressed audio or plain pcm

You can look at the bit 1 (0x02) of AES0 IEC958 channel status.

The driver generally provides IEC958 controls:
http://www.alsa-project.org/~tiwai/writing-an-alsa-driver/ch10s03.html
That are then used via hooks in "foo.pcm.hdmi.0" (or "foo.pcm.iec958.0"
for non-hdmi) definition in /usr/share/alsa/cards/foo.conf (look at
existing drivers for examples).
Applications can then set these flags by e.g. opening the ALSA audio
device as "hdmi:AES0=0x06,AES1=0x82" etc.

> 2) Is their any plugin available for IEC61937, I could see only for IEC958

No.

> 3) Who should create burst preamble, some plug in or driver.

Currently they are created by the applications themselves.

-- 
Anssi Hannula
