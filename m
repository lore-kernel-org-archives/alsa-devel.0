From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Questions about virtual ALSA driver (dummy),
 PortAudio and full-duplex drops
Date: Tue, 06 Aug 2013 15:04:13 +0200
Message-ID: <5200F44D.4070104@ladisch.de>
References: <51EF41C8.2040701@imi.aau.dk>
 <201307241403.28873.gineera@aspect135.co.uk> <51F07150.1060004@imi.aau.dk>
 <51F0E3C5.4020400@ladisch.de> <51FD9AB6.4050408@imi.aau.dk>
 <5200D712.2040800@ladisch.de> <5200E0FE.1000205@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 933BC260308
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2013 15:04:23 +0200 (CEST)
In-Reply-To: <5200E0FE.1000205@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org, Smilen Dimitrov <sd@imi.aau.dk>
List-Id: alsa-devel@alsa-project.org

David Henningsson wrote:
> On 08/06/2013 12:59 PM, Clemens Ladisch wrote:
>>> On 2013-07-25 10:37, Clemens Ladisch wrote:
>>>> Your driver's .pointer callback must report the *actual* position at
>>>> which the hardware has finished reading from the buffer
>>
>> ... for a playback stream, or finished reading, for a capture stream.
>
> What if the pointer granularity is very coarse? E g, some hardware might
> only be able what period you're in (IIRC, I've seen this on the Tegra
> platform), rather than the actual sample. Would you recommend to report
> the latest period boundary in that case, or interpolating it with timers?

By reporting position x, the driver guarantees that the device has
finished reading (for a playback stream) before x, and that the
application is allowed to overwrite the buffer before x with new sample
data.

When the driver does not know the current position of the DMA
controller, it must report the last known 'safe' position (and set
SNDRV_PCM_INFO_BLOCK_TRANSFER).


Regards,
Clemens
