From: Tanu Kaskinen <tanuk@iki.fi>
Subject: Re: pulseaudio external mic jack detection - ASoC
 based card
Date: Wed, 22 Jul 2015 13:35:22 +0300
Message-ID: <1437561322.29189.1.camel@iki.fi>
References: <CANv6ZMYHA7V9Dt0xfxS6jdy5WTbho28p=7p9ZLZNw_tsSQbmfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id CE654265268
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2015 12:35:25 +0200 (CEST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 0B520203BF
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2015 06:35:25 -0400 (EDT)
In-Reply-To: <CANv6ZMYHA7V9Dt0xfxS6jdy5WTbho28p=7p9ZLZNw_tsSQbmfQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: maruthi srinivas <maruthi.srinivas.b@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2015-07-08 at 16:33 +0530, maruthi srinivas wrote:
> Hi,
> 
> I have a issue with mic jack status in Ubuntu "sound settings"  UI. 
>  When
> external mic is removed, UI still shows Mic.
> When compared to HD Azalia driver, UI shouldn't show any external Mic 
> jack
> information, if it is removed.
> 
> Codec driver I use reports jack status properly and uses
> snd_soc_jack_report().
> /proc/interrupts, /dev/input/eventX  reflects jack activity. But the 
> same
> is not reflected in UI.
> 
> I want to know how pulseaudio detect jack status for drivers which 
> follow
> ALSA SoC architecture.
> Does it read from any event from /dev/input/eventX ?

No, pulseaudio doesn't use the /dev/input devices, it reads the jack
state from the alsa mixer interface.

-- 
Tanu
