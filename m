From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Can not rmmod snd_hda_codec_hdmi
Date: Tue, 23 Dec 2014 17:21:13 +0100
Message-ID: <680798B3-0846-423E-80F5-11AA542B563A@ladisch.de>
References: <1419332872.4067.10.camel@xbing-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 750F126054F
 for <alsa-devel@alsa-project.org>; Tue, 23 Dec 2014 17:21:29 +0100 (CET)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 901DB216EC
 for <alsa-devel@alsa-project.org>; Tue, 23 Dec 2014 11:21:28 -0500 (EST)
In-Reply-To: <1419332872.4067.10.camel@xbing-ubuntu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xuebing Wang <xbing6@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "; Takashi Iwai" <tiwai@suse.de>, Anssi Hannula <anssi.hannula@iki.fi>, ";
 Libin Yang" <libin.yang@intel.com>, ";
 Fengguang Wu" <fengguang.wu@intel.com>, ";
 Mengdong Lin" <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

Xuebing Wang wrote:
>rmmod: ERROR: Module snd_hda_codec_hdmi is in use

rmmod snd-hda-intel first.


Regards,
Clemens
