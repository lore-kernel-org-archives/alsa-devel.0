From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Unsupported Valley View 'LPE' adapter?
Date: Sat, 30 Nov 2013 22:45:14 +0100
Message-ID: <529A5C6A.70604@ladisch.de>
References: <1385840039.2566.12.camel@adam.happyassassin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 58B31261A97
 for <alsa-devel@alsa-project.org>; Sat, 30 Nov 2013 22:46:03 +0100 (CET)
In-Reply-To: <1385840039.2566.12.camel@adam.happyassassin.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Williamson <awilliam@redhat.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Harsha Priya <priya.harsha@intel.com>
List-Id: alsa-devel@alsa-project.org

Adam Williamson wrote:
> In Windows' Device Manager I see an 'Intel SST Audio Device' with PCI ID
> 0x86:0f28. Indeed, the PCI ID database has this listed as "ValleyView
> LPE Audio Controller" - http://pci-ids.ucw.cz/read/PC/8086/0f28 . But
> hda-intel does not have 0f28 as a supported device.
>
> So...what is this 0f28?

It is not an HDA controller.  The SST thingy uses I=B2S codecs.

> Is support for it going to be added?

There is something in sound/soc/mid-x86/, but that is only for the
Medfield platform.  The PCI SST driver that was not merged four years
ago used the ID 080a.

Only Intel knows.

> Is there any info I can provide to help?

"lspci -vv -d 8086:0f28"?


Regards,
Clemens
