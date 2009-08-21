From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH] various acer-mic-internal bugs solution
Date: Fri, 21 Aug 2009 14:22:44 +0300
Message-ID: <1250853764.11435.3.camel@maxim-laptop>
References: <4A8B36E0.6080404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C5AD24588
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Aug 2009 13:22:51 +0200 (CEST)
Received: by bwz25 with SMTP id 25so402802bwz.32
	for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2009 04:22:50 -0700 (PDT)
In-Reply-To: <4A8B36E0.6080404@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: epic <epicadocan@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2009-08-19 at 00:18 +0100, epic wrote:
> Several mic related bugs maybe solved with this patch or a derived one
> 
> 
>  1  -My internal-mic was not working and front jack mic sound was
> terrible (useless for headset mic).
> 
>  2  -Detected offset level from inputs {line, mic}, this offset level
> increases with specific [boost] and/or [capture(NID 0x23)] gain.
> 
> * I just played around several days compiling and testing alsa with my
> acer-alc268, checked all data communication with alc268, pin config etc.
> and tested different values for offset in pins.
> 
> * Found internal-mic comes alive with a 50% offset v_reference and mic
> sound is much better.
> 
> *This patch applies/solves only for alc268 with option model=acer in
> alsa-base.conf, but i think the others acer-alcxxx bugs maybe solved in
> the same way.
> 
> 	changing PIN_VREF80 to PIN_VREF50 at
> 		NID 0x18 mic
> 		NID 0x19 internal-mic
> 		NID 0x1a line-in (not tested)
> 
> *Don't know what can happen to other acer-alcxxx, so i only patched
> acer-alc268. But this patch solved my mic-internal issue and most
> important for me now i can use a headset mic.
> 
> *It remains a level offset, lower than before, but mic is usable, the
> level is  showed in the pictures.
> 


I have acer too (Aspire 5720)

And I also see high DC offsets on both internal and external mics
(and sound quality of internal mic is very bad)

But doesn't help here.
I have set the voltage on the corresonding pins using hda-verb, and I an
hardly notice any difference
(maybe the internal mic is already destroyed by high voltage...)


sudo ./hda-verb /dev/snd/hwC0D0 0x19 SET_PIN_WIDGET_CONTROL 0x21

(this one for internal mic)


Best regards,
	Maxim Levitsky
