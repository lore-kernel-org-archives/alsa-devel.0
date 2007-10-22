From: william estrada <MrUmunhum@popdial.com>
Subject: Re: USB device gives wrong data?
Date: Mon, 22 Oct 2007 09:58:38 -0700
Message-ID: <471CD6BE.4090209@popdial.com>
References: <47192528.9080403@popdial.com>
	<1193034894.13299.1217094833@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from MAIL02.inside.adbasesystems.com (mail.1dial.com [64.136.164.73])
	by alsa0.perex.cz (Postfix) with ESMTP id 70C722491B
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Oct 2007 18:58:34 +0200 (CEST)
In-Reply-To: <1193034894.13299.1217094833@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: "linux-audio-user@lists.linuxaudio.org" <linux-audio-user@lists.linuxaudio.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens,

   I respect your options and appreciate your time, but from what I have read,
for a U8 format, silence is represented by a x'7F'.  Do you have a source for
your option?

   In pcm_misc.c seems to support your statement:

> static struct pcm_format_data pcm_formats[SNDRV_PCM_FORMAT_LAST+1] = {
.
.
> 	[SNDRV_PCM_FORMAT_U8] = {
> 		.width = 8, .phys = 8, .le = -1, .signd = 0,
> 		.silence = { 0x80 },

   So I guess I need to make my filter flexible to match the current hardware
device driver?

   How would you filter out noise?  I am new to these interfaces and would like
to find a good place to get more information about filters, noise, etc.  Any
URLs that you could recommend?

   Thanks again for your time.

William Estrada
MrUmunhum@popdial.com
Mt-Umunhum-Wireless.net ( http://Mt-Umunhum-Wireless.net )
Ymessenger: MrUmunhum



Clemens Ladisch wrote:
> william estrada wrote:
>> I think I have found a problem with the USB sound driver?  It appears
>> that the current drive returns a x'81' for silence but it should be a
>> x'7f'.
> 
> The USB audio driver returns whatever data is sent by the device
> 
>> When I use my laptop's sound device and record without a mic, I get
>> a file full of x'7f's.  If I do the same with my cheap-o USB device
>> I get a file full of x'81's.
> 
> For unsigned 8-bit samples, silence is x'80'.
> 
> Apparently, both devices have some DC offset and are quite noisy.
> 
>> I have written a recording program that I have a 'silence' filter
>> that filters out segments of dead air.  It works with the laptop's
>> sound device but not the USB device.  The filter works by remove
>> x'7f's after allowing a selectable amount.
> 
> Your filter should be able to detect silence even when noise is present.
> 
>> Sorry for the multiple posting, not sure where is should have gone.
> 
> The the linux-audio-dev list, of course.  ;-)
> 
> 
> Regards,
> Clemens
> 
