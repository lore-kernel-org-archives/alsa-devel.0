From: Jussi Laako <jussi@sonarnerd.net>
Subject: Re: [PATCH 0/3] ALSA: snd-usb: Some small fixes to
 make Playback Design products work
Date: Fri, 22 Mar 2013 13:08:45 +0200
Message-ID: <514C3BBD.3020402@sonarnerd.net>
References: <1363522047-7515-1-git-send-email-zonque@gmail.com>
 <s5hehfduld0.wl%tiwai@suse.de> <5146DB40.2060000@gmail.com>
 <s5h620pukb4.wl%tiwai@suse.de> <51471B51.4000006@gmail.com>
 <514B79DA.6030203@sonarnerd.net>
 <7.0.0.16.2.20130321181551.0605bc60@akdesigninc.com>
 <514C2F34.6020307@sonarnerd.net> <s5hwqszag3e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [83.145.240.118])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A51C2664C2
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 12:08:46 +0100 (CET)
In-Reply-To: <s5hwqszag3e.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, Daniel Mack <zonque@gmail.com>, demian@auraliti.com, ray@auraliti.com, Andreas Koch <andreas@akdesigninc.com>
List-Id: alsa-devel@alsa-project.org

On 03/22/2013 12:23 PM, Takashi Iwai wrote:
> More important question is how consistent the format is.  If it's a
> device-specific closed format, it's not suitable as a standard format
> definition in the API level.

At least the ASIO way of two uint8_t based MSB/LSB formats is pretty 
much the standard common denominator. Rest of the possibly needed data 
arrangement can be handled by the driver.

For the DoP output it is already defined by Andreas:
http://dsd-guide.com/dop-open-standard

Which corresponds to the uint8_t with oldest bit in MSB. I'm now doing 
the packing for both packing styles in the application before sending it 
through ALSA. However, it would be cleaner for application to send 
uint8_t packets and handle the packing at driver level. Those pieces of 
custom USB hardware that don't use DoP but send raw DSD stream usually 
use either uint8_t or uint32_t containers. So the uint8_t is the lowest 
common denominator. So we wouldn't need to worry about the byte order in 
addition to bit order...


	- Jussi
