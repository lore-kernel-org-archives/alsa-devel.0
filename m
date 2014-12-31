From: Xuebing Wang <xbing6@gmail.com>
Subject: DSD over HDMI: audio data packetization
Date: Wed, 31 Dec 2014 21:32:00 +0800
Message-ID: <1420032720.2102.14.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f171.google.com (mail-pd0-f171.google.com
 [209.85.192.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B00B260554
 for <alsa-devel@alsa-project.org>; Wed, 31 Dec 2014 14:32:07 +0100 (CET)
Received: by mail-pd0-f171.google.com with SMTP id y13so20960037pdi.2
 for <alsa-devel@alsa-project.org>; Wed, 31 Dec 2014 05:32:06 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Libin Yang <libin.yang@intel.com>, ";
 Mengdong Lin" <mengdong.lin@intel.com>, ";
 Wu Fengguang" <wfg@linux.intel.com>, ";
 Takashi Iwai" <tiwai@suse.de>, "; Anssi Hannula" <anssi.hannula@iki.fi>
List-Id: alsa-devel@alsa-project.org

Hi Community,

I am trying to implement DSD (one bit audio) over HDMI, for Intel
integrated graphics. I am referencing HDMI specification 1.3a.

Regarding audio data packetization, I am referencing spec:
5.3.4 Audio Sample Packet
7.6 Audio Data Packetization

Q1) Would you please point to me where is the source code to handle
L-PCM audio sample packetization (to implement 5.3.4 Audio Sample
Packet)?

Q2) I admit that I did not carefully read HD-Audio specification. Is
this possible that this L-PCM audio data packetization is done by
*hardware* (e.g HDMI related widgets/pins)?

Q3) Did we implement "7.2 Audio Sample Clock Capture and Regeneration"?

Thanks.
Xuebing Wang
