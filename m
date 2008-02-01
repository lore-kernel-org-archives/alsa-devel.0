From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: a7839e96 (PNP: increase max resources) breaks my
 ALSA intel8x0 sound card
Date: Fri, 1 Feb 2008 11:50:13 +1100 (EST)
Message-ID: <alpine.LFD.1.00.0802011149160.3198@www.l.google.com>
References: <fa.Kmpf0B4W44W1VefIME7+BnfUouY@ifi.uio.no>
	<479CCAAD.4080706@shaw.ca>
	<20080131145820.44171af2.akpm@linux-foundation.org>
	<47A2644B.4000905@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	by alsa0.perex.cz (Postfix) with ESMTP id DD8E71038FE
	for <alsa-devel@alsa-project.org>; Fri,  1 Feb 2008 01:50:20 +0100 (CET)
In-Reply-To: <47A2644B.4000905@shaw.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: alsa-devel@alsa-project.org, avuton@gmail.com, linux-kernel@vger.kernel.org, yakui.zhao@intel.com, shaohua.li@intel.com, Andrew Morton <akpm@linux-foundation.org>, trenn@suse.de, bjorn.helgaas@hp.com
List-Id: alsa-devel@alsa-project.org



On Thu, 31 Jan 2008, Robert Hancock wrote:
> 
> I think so. There was one objection that it introduced a dependency on pnpacpi
> loading after PCI bus enumeration, though.
> 
> Linus also suggested that pnpacpi could be marking the resources as "present
> but unused" so that drivers can request those regions but we still prevent
> dynamically assigning resources into them.

I _think_ that's what ACPI used to do before switching over to the PnPACPI 
thing, so I do think that "present but not reserved" approach is not just 
the right one, but also the (historically) tested one.

		Linus
