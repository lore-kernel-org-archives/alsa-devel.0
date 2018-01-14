From: Jussi Laako <jussi@sonarnerd.net>
Subject: ALSA device with slave clock
Date: Sun, 14 Jan 2018 22:37:28 +0200
Message-ID: <c0ec603c-9e3f-54fc-5dbd-7be6121ae5ae@sonarnerd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [194.142.149.154])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D1AF266CFE
 for <alsa-devel@alsa-project.org>; Sun, 14 Jan 2018 21:37:31 +0100 (CET)
Received: from [IPv6:fc00::2] (porkkala.uworld [IPv6:fc00::2])
 by mail.sonarnerd.net (Postfix) with ESMTP id A2FC62310C9
 for <alsa-devel@alsa-project.org>; Sun, 14 Jan 2018 22:37:28 +0200 (EET)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I've been fighting with some devices for the case where ALSA device is a 
clock slave. I'm also working on some patches/quirks to make some of 
these things work.

I have couple of questions in this domain I didn't find documented:

1) How is application supposed to use ALSA capture device when it 
doesn't know the sampling rate? For example with ASIO on Windows 
application sets sampling rate to 0 to indicate slave and then starts 
the device and retrieves the rate using ASIOGetSampleRate(). There are 
typically also reset request messages when the rate changes.

2) Some USB devices have indicator for lock status between set sampling 
rate and detected input rate. One such device I have is Motu 8D (UAC2 
device):
     Simple mixer control 'Internal Clock Validity',0
       Capabilities: pswitch pswitch-joined
       Playback channels: Mono
       Mono: Playback [on]
As long as the status is valid, I can set sampling rate to the same, or 
something else. When the status becomes invalid due to rate mismatch, 
ALSA fails to set any of the sampling rates, even correct one and 
there's an error message in dmesg: "usb 3-14: clock source 1 is not 
valid, cannot use". So the clock source cannot be made valid again by 
changing sampling rate once it has become invalid, because it is 
currently invalid...

3) What is the correct way to deal with clock slave device from both 
driver and application perspective? So that application can retrieve the 
current sampling rate, instead of setting one... UAC2 has provisions for 
this, but this doesn't seem to be supported by the current driver. I 
have also some hardware where I would like to do the same with I2S - 
where clock generator is outside of the SoC and the SoC is just a slave 
(for example S/PDIF or AES/EBU input to a SoC where clock is generated 
from the input stream using PLL).


Best regards,

	- Jussi
