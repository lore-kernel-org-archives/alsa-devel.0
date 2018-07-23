From: Jussi Laako <jussi@sonarnerd.net>
Subject: Re: [PATCH] alsa/usb-audio: Topping DX7s quirk for DSD
	interface
Date: Mon, 23 Jul 2018 11:26:41 +0300
Message-ID: <133b10a8-95d0-7882-39dc-c3cf8f80aaab@sonarnerd.net>
References: <20180723080208.44235-1-yuleopen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [194.142.149.154])
 by alsa0.perex.cz (Postfix) with ESMTP id 41B7F2676CB
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2018 10:26:41 +0200 (CEST)
In-Reply-To: <20180723080208.44235-1-yuleopen@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yue Wang <yuleopen@gmail.com>, linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Nobutaka Okabe <nob77413@gmail.com>, Takashi Iwai <tiwai@suse.com>, Alberto Aguirre <albaguirre@gmail.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Hi,

> +	case USB_ID(0x152a, 0x8750): /* Topping DX7s */
0x152a is Thesycon's VID and if it's based on XMOS I'd recommend to try 
adding the 0x152a VID to the generic DSD capability auto-detect list 
instead of this old device specific list.

I consider it very likely that it would work that way and at the same 
time also cover all other devices with the same firmware and Thesycon's VID.


Best regards,

	- Jussi
