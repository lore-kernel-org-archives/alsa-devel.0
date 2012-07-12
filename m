From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: When will Realtek High-Defintion audio codec
 ALC282 be supported?
Date: Thu, 12 Jul 2012 02:57:39 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F81561B7@SHSMSX101.ccr.corp.intel.com>
References: <F46914AEC2663F4A9BB62374E5EEF8F81560FB@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 46FDA24396
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Jul 2012 04:58:00 +0200 (CEST)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F81560FB@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "david.henningsson@canoinical.com" <david.henningsson@canoinical.com>
List-Id: alsa-devel@alsa-project.org

Hi David,

Do you have any plan to support ALC282? Could you give any comments?

And could you or anyone share me the codec id/datasheet of ALC282? So I can try to configure it to share old driver of ALC2XX as you did for ALC280.
http://www.mail-archive.com/stable@vger.kernel.org/msg10752.html

Thanks
Mengdong

From: Lin, Mengdong
Sent: Thursday, July 12, 2012 7:05 AM
To: alsa-devel@alsa-project.org
Cc: Lin, Mengdong
Subject: When will Realtek High-Defintion audio codec ALC282 be supported?

Hi,

I'm going to have a platform with Realtek HDA ALC282 codec. But the driver has no support for ALC282 now. Does anybody know when ALC282 will be supported?

I saw that another Realtek ALC280 is supported by just adding the codec id and still using 'patch_alc269'. I wonder if ALC282 can also be supported in this way if it's similar enough to other ALC2XX codecs. Could anyone share some idea about this?

Thanks
Mengdong
