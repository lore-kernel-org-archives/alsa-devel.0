From: "Robas, Teodor" <teodor.robas@gmail.com>
Subject: Re: ALSA-SOC support for OpenRD Client/Ultimate
Date: Sat, 13 Nov 2010 09:43:49 +0200
Message-ID: <4CDE41B5.8050505@gmail.com>
References: <4CDB9122.20706@gmail.com> <20101112165105.GE28804@sirena.org.uk>
	<877hgi31o0.fsf@lechat.rtp-net.org>
Reply-To: teodor.robas@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A6664103819
	for <alsa-devel@alsa-project.org>; Sat, 13 Nov 2010 08:43:54 +0100 (CET)
Received: by bwz8 with SMTP id 8so3813492bwz.38
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 23:43:54 -0800 (PST)
In-Reply-To: <877hgi31o0.fsf@lechat.rtp-net.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


Solved. All functions I tried (playback, volume control, muting) work fine.

The codec is found as:
cs42l51-codec 0-004a: found device cs42l51 rev 1

Manny thanks for this driver.

Also thanks to Mark Brown for pointing the info in the right direction.


On 11/12/2010 07:13 PM, Arnaud Patard (Rtp) wrote:
> Mark Brown<broonie@opensource.wolfsonmicro.com>  writes:
>
> Hi,
>
>> On Thu, Nov 11, 2010 at 08:45:54AM +0200, Robas, Teodor wrote:
>>
>>> I am writing to this list in the hope that somebody can clear me out
>>> if this platform is supported and I am doing something wrong, or if
>>> it is still work in progress.
>
> You have an OpenRD Client or Ultimate ? I'll consider you have an
> Ultimate.
>
> You need to patch some files (assuming the Ultimate as a cs42l51 at i2c
> address 4a like the Client) like I did in the patch sent with this mail.
>
>>
>>> The drivers that I think should work with my hardware (OpenRD ultimate)
>>> are located in sound/soc/kirkwood/*.
>>
>> Please remember to always CC maintainers on posts to Linux lists.  I've
>> added a CC to Arnaud and not cut any text for his benefit.
>>
>>> Sound on this device worked (partially) with the default software
>>> it came but not with the latest about 10 kernels I have tried.
>>>
>>> I added bellow the output of alsa-info.sh script. If needed I can look
>>> for more or try to fix it (with some help).
>>>
>>>
>>> Best Regards,
>>> Teodor
>>>
>
> [...]
>
>>> Module
>>> snd_soc_kirkwood
>>> snd_soc_core
>>> snd_pcm
>>> snd_timer
>>> snd
>>> snd_page_alloc
>>> bridge
>>> stp
>>> llc
>>> nfsd
>>> lockd
>>> nfs_acl
>>> auth_rpcgss
>>> sunrpc
>>> exportfs
>>> loop
>>> xgifb
>>> fb
>>> cfbcopyarea
>>> mv_cesa
>>> cfbimgblt
>>> aes_generic
>>> cfbfillrect
>>> sd_mod
>>> crc_t10dif
>>> usb_storage
>>> sata_mv
>>> libata
>>> ehci_hcd
>>> scsi_mod
>>> usbcore
>>> mv643xx_eth
>>> libphy
>>> nls_base
>
> I don't see snd-soc-openrd.ko and snd-soc-kirkwood-i2s.ko loaded and you
> need them. Also, please give kernel boot logs if the sound is still not
> working with my patch and all needed modules loaded. Checking if the
> codec is still a cs42l51 at 0x4a would be nice too.
>
> Arnaud
>
>


-- 
  _
( )   ascii ribbon campaign - against html e-mail
  X    www.asciiribbon.org   - against proprietary attachments
/ \
