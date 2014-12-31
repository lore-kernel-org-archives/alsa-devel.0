From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: DSD over HDMI: audio data packetization
Date: Wed, 31 Dec 2014 15:40:39 +0200
Message-ID: <54A3FCD7.2010902@iki.fi>
References: <1420032720.2102.14.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.ippnet.fi (mail3.ippnet.fi [62.197.168.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 01DE6260554
 for <alsa-devel@alsa-project.org>; Wed, 31 Dec 2014 14:40:42 +0100 (CET)
In-Reply-To: <1420032720.2102.14.camel@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xuebing Wang <xbing6@gmail.com>
Cc: Libin Yang <libin.yang@intel.com>, ";
 Mengdong Lin" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "; Wu Fengguang" <wfg@linux.intel.com>, ";
 Takashi Iwai" <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

31.12.2014, 15:32, Xuebing Wang kirjoitti:
> Hi Community,

Hi,

> I am trying to implement DSD (one bit audio) over HDMI, for Intel
> integrated graphics. I am referencing HDMI specification 1.3a.
> 
> Regarding audio data packetization, I am referencing spec:
> 5.3.4 Audio Sample Packet
> 7.6 Audio Data Packetization
> 
> Q1) Would you please point to me where is the source code to handle
> L-PCM audio sample packetization (to implement 5.3.4 Audio Sample
> Packet)?

It is done by the hardware.

> Q2) I admit that I did not carefully read HD-Audio specification. Is
> this possible that this L-PCM audio data packetization is done by
> *hardware* (e.g HDMI related widgets/pins)?

Yes.

> Q3) Did we implement "7.2 Audio Sample Clock Capture and Regeneration"?

That is done by hardware. With some HDA codecs the video driver
calculates the N/CTS values "manually", but AFAIK not on Intel HW.

> Thanks.
> Xuebing Wang
> 
> 


-- 
Anssi Hannula
