From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: When will Realtek High-Defintion audio codec
 ALC282 be supported?
Date: Thu, 12 Jul 2012 08:33:14 +0200
Message-ID: <4FFE6FAA.8070209@canonical.com>
References: <F46914AEC2663F4A9BB62374E5EEF8F81560FB@SHSMSX101.ccr.corp.intel.com>
	<F46914AEC2663F4A9BB62374E5EEF8F81561B7@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 591F524478
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Jul 2012 08:33:16 +0200 (CEST)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F81561B7@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 07/12/2012 04:57 AM, Lin, Mengdong wrote:
> Hi David,
>
> Do you have any plan to support ALC282? Could you give any comments?
>
> And could you or anyone share me the codec id/datasheet of ALC282? So I can try to configure it to share old driver of ALC2XX as you did for ALC280.
> http://www.mail-archive.com/stable@vger.kernel.org/msg10752.html
>
> Thanks
> Mengdong
>
> From: Lin, Mengdong
> Sent: Thursday, July 12, 2012 7:05 AM
> To: alsa-devel@alsa-project.org
> Cc: Lin, Mengdong
> Subject: When will Realtek High-Defintion audio codec ALC282 be supported?
>
> Hi,
>
> I'm going to have a platform with Realtek HDA ALC282 codec. But the driver has no support for ALC282 now. Does anybody know when ALC282 will be supported?
>
> I saw that another Realtek ALC280 is supported by just adding the codec id and still using 'patch_alc269'. I wonder if ALC282 can also be supported in this way if it's similar enough to other ALC2XX codecs. Could anyone share some idea about this?
>
> Thanks
> Mengdong

Hello Mengdong,

I know just as little as you do about Realtek ALC282. Chances are that 
Realtek haven't changed the codec much compared to ALC280, and then just 
another line next to the ALC280 would do just fine:

{ .id = 0x10ec0282, .name = "ALC282", .patch = patch_alc269 },

But I don't think Takashi would add such a line to the kernel without 
somebody testing that it actually works.
If you have the hardware available, you can try the above line, see if 
it works, and report back together with alsa-info for the affected system.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
