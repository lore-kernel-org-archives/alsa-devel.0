From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [LKML] Re: USB transfer_buffer allocations on 64bit systems
Date: Wed, 14 Apr 2010 09:18:22 -0400
Message-ID: <20100414131822.GC17171@phenom.dumpdata.com>
References: <20100412162947.GQ18855@one.firstfloor.org> <Pine.LNX.4.44L0.1004121252310.1702-100000@iolanthe.rowland.org> <20100413182233.GR30807@buzzloop.caiaq.de> <k2o74fd948d1004131646k1e0e1897z7594f77a580c6b9f@mail.gmail.com> <20100414100946.GS30807@buzzloop.caiaq.de> <t2w74fd948d1004140347k3447bffapb73856eacddfde55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <t2w74fd948d1004140347k3447bffapb73856eacddfde55@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pedro Ribeiro <pedrib@gmail.com>
Cc: linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Andi Kleen <andi@firstfloor.org>, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Greg KH <gregkh@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> So basically the BIOS is incorrectly reporting
> BIOS-e820: 0000000100000000 - 000000013c000000 (usable)

No. Count up the the sizes of the (usuable) entries. You will see
that when you provided mem=4GB, the E820 got truncated to stop at 4GB.
Without that it goes past the 4GB mark (which is correct).

Keep in mind, 4GB doesn't mean your usuable memory stops at 4GB. The
BIOS shuffles the memory around to stick in the BIOS, ACPI, PCI hole so
that part of the usable memory is above 4GB.
