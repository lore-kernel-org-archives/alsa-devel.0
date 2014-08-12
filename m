From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] [PATCH 12/15] oxfw: Add support for Behringer/Mackie
	devices
Date: Tue, 12 Aug 2014 09:33:14 +0200
Message-ID: <53E9C33A.2090508@ladisch.de>
References: <1399991272-5807-1-git-send-email-o-takashi@sakamocchi.jp>
	<1399991272-5807-13-git-send-email-o-takashi@sakamocchi.jp>
	<53E795C5.1010506@ladisch.de> <53E95664.7020707@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <53E95664.7020707@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, fenlason@redhat.com, ffado-devel@lists.sf.net, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> On Aug 11 2014 00:54, Clemens Ladisch wrote:
>> Takashi Sakamoto wrote:
>>> +	/* IDs are unknown but able to be supported */
>>> +	/*  Mackie(Loud), d.2 pro */
>>> +	/*  Mackie(Loud), d.4 pro */
>>> +	/*  Mackie(Loud), U.420 */
>>> +	/*  Mackie(Loud), U.420d */
>>
>> To support all Mackie devices, use one ID entry with only the vendor ID,
>> and abort with -ENODEV from the _probe function if the hardware is not
>> actually an OXFW97x device (try to read the HARDWARE_ID and/or
>> FIRMWARE_ID registers).
>
> In this idea, OXFW driver transfers the transaction(s) for all of
> Mackie(Loud) devices on IEEE 1394 bus when they're probed. I want to
> avoid such changes possible to affects the other models on the same bus
> because I'm afraid of side effects.

The only other known Mackie devices are the 400F/1200F.  The Fireworks
firmware doesn't blow up if you try to read unsupported registers, but
if you want to be sure, you can blacklist these two IDs.

Or just do the detection like the Windows driver, through the vendor/
model name strings (this is what my old Fireworks driver did because
I didn't know all model IDs; see match_echofire_device_name).  The
Mackie driver's .inf file has this list of device identifiers:

"AVC\Loud_Technologies_Inc.&Onyxi&typ_1"
"AVC\Loud_Technologies_Inc.&Onyx_1640i&typ_1"
"AVC\Loud_Technologies_Inc.&Onyx-i&typ_1"
"AVC\Loud_Technologies_Inc.&d.Pro&typ_1"
"AVC\Loud_Technologies_Inc.&Mackie_Onyx_Satellite&typ_1"
"AVC\Loud_Technologies_Inc.&Tapco_LINK.firewire_4x6&typ_1"
"AVC\Loud_Technologies_Inc.&U.420&typ_1"
"AVC\Mackie&Onyx_Firewire&typ_1"

(This format is documented at <http://msdn.microsoft.com/en-us/library/windows/hardware/ff556371.aspx>;
apparently, spaces are replaced with "_".)


Regards,
Clemens

------------------------------------------------------------------------------
