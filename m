From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC][PATCH 0/3] ALSA: fireface: new driver for
	RME	Fireface series (MIDI only)
Date: Mon, 7 Dec 2015 08:37:22 +0100
Message-ID: <56653732.6000107@ladisch.de>
References: <1449408224-13955-1-git-send-email-o-takashi@sakamocchi.jp>
 <20151206215744.GA6103@marvin.atrad.com.au>
 <5664E06C.9080705@sakamocchi.jp>
 <20151207013748.GD6213@marvin.atrad.com.au>
 <5664E64E.7000807@sakamocchi.jp> <5664E961.9080907@sakamocchi.jp>
 <20151207022112.GF6213@marvin.atrad.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 065AD2650BD
 for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2015 08:37:23 +0100 (CET)
In-Reply-To: <20151207022112.GF6213@marvin.atrad.com.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Woithe <jwoithe@just42.net>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

Jonathan Woithe wrote:
> On Mon, Dec 07, 2015 at 11:05:21AM +0900, Takashi Sakamoto wrote:
>> Furthermore, 0x0010 is not always true because the address range which
>> drivers allocate on the controller is different depending on situation.
>
> In general that's true.  For the FF400 at least though the non-nodeID
> component is effectively hard coded on other systems.

That's just because this value happens to be the first free address in
the FireWire address space.  If you had other FireWire devices whose
drivers allocated addresses, you would see different values.  (Maybe
even for multiple FF devices, but the driver might be able to share the
range for all devices.)


Regards,
Clemens
