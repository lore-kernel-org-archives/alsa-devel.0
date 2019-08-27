From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 1/2] PCI: Add a helper to check Power Resource
 Requirements _PR3 existence
Date: Tue, 27 Aug 2019 17:13:21 -0500
Message-ID: <20190827221321.GA9987@google.com>
References: <20190827134756.10807-1-kai.heng.feng@canonical.com>
 <s5hr2567hrd.wl-tiwai@suse.de>
 <0379E973-651A-442C-AF74-51702388F55D@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0379E973-651A-442C-AF74-51702388F55D@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Peter Wu <peter@lekensteyn.nl>, Mika Westerberg <mika.westerberg@linux.intel.com>, Dave Airlie <airlied@redhat.com>
List-Id: alsa-devel@alsa-project.org

[+cc Peter, Mika, Dave]

https://lore.kernel.org/r/20190827134756.10807-1-kai.heng.feng@canonical.com

On Wed, Aug 28, 2019 at 12:58:28AM +0800, Kai-Heng Feng wrote:
> at 23:25, Takashi Iwai <tiwai@suse.de> wrote:
> > On Tue, 27 Aug 2019 15:47:55 +0200,
> > Kai-Heng Feng wrote:
> > > A driver may want to know the existence of _PR3, to choose different
> > > runtime suspend behavior. A user will be add in next patch.
> > > 
> > > This is mostly the same as nouveau_pr3_present().
> > 
> > Then it'd be nice to clean up the nouveau part, too?
> 
> nouveau_pr3_present() may call pci_d3cold_disable(), and my intention is to
> only check the presence of _PR3 (i.e. a dGPU) without touching anything.

It looks like Peter added that code with 279cf3f23870
("drm/nouveau/acpi: use DSM if bridge does not support D3cold").

I don't understand the larger picture, but it is somewhat surprising
that nouveau_pr3_present() *looks* like a simple predicate with no
side-effects, but in fact it disables the use of D3cold in some cases.

If the disable were moved to the caller, Kai-Heng's new interface
could be used both places.
