From: "Jeremy Soller" <jeremy@system76.com>
Subject: Re:
 =?utf-8?q?=5BPATCH=5D_Headset=2C=09microphone_and_in?=
 =?utf-8?q?ternal_speaker_support_for_Tuxedo_XC_1509?=
Date: Fri, 03 May 2019 11:07:54 -0400
Message-ID: <529da7d1-ae84-4010-9fe8-6f9c69dfb4f9@www.fastmail.com>
References: <20190402135204.11563-1-rs@tuxedocomputers.com>
 <s5h8swrfm5v.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4CA49F80720
 for <alsa-devel@alsa-project.org>; Fri,  3 May 2019 17:08:00 +0200 (CEST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id 74BC4245
 for <alsa-devel@alsa-project.org>; Fri,  3 May 2019 11:07:58 -0400 (EDT)
In-Reply-To: <s5h8swrfm5v.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The use of PB51ED in the enum variant does not make complete sense. The System76 oryp5 is based on the P960ED and  P960EF models, not the PB51ED. I am about to add two more models that require similar fixups - NH58RCQ and NH70RCQ.

This patch basically applies to any current Clevo motherboards with an ALC1220 and a headphone combo jack. Perhaps something like ALC1220_FIXUP_CLEVO_HP_COMBO would be a better name?

-- 
  Jeremy Soller
  System76
  Engineering Manager
  jeremy@system76.com

On Wed, Apr 3, 2019, at 3:57 AM, Takashi Iwai wrote:
> On Tue, 02 Apr 2019 15:52:04 +0200,
> Richard Sailer wrote:
> > 
> > This adds a SND_PCI_QUIRK(...) line for the Tuxedo XC 1509.
> > 
> > The Tuxedo XC 1509 and the System76 oryp5 are the same barebone
> > notebooks manufactured by Clevo. To name the fixups both use after the
> > actual underlying hardware, this patch also changes System76_orpy5
> > to clevo_pb51ed in 2 enum symbols and one function name,
> > matching the other pci_quirk entries which are also named after the device ODM.
> > 
> > Signed-off-by: Richard Sailer <rs@tuxedocomputers.com>
> 
> Applied, thanks.
> 
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
