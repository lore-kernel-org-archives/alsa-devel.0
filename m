From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RFC PATCH 1/2] thinkpad-acpi: Add mute and mic-mute LED
 functionality
Date: Wed, 16 Oct 2013 09:35:20 -0300
Message-ID: <20131016123520.GB10787@khazad-dum.debian.net>
References: <1381925736-11399-1-git-send-email-david.henningsson@canonical.com>
 <1381925736-11399-2-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1381925736-11399-2-git-send-email-david.henningsson@canonical.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, platform-driver-x86@vger.kernel.org, ibm-acpi@hmh.eng.br, alex.hung@canonical.com, hui.wang@canonical.com
List-Id: alsa-devel@alsa-project.org

On Wed, 16 Oct 2013, David Henningsson wrote:
> Not sure if thinkpad_acpi should be dropped into include/linux
> though, any better suggestion?

I'm fine with it wherever...

> Should TPACPI_VERSION be increased because we added a new LED driver?

TPACPI_SYSFS_VERSION needs to be increased when you add some feature or
change some behaviour that userspace needs to know to be present/ausent AND
which cannot be detected by other means (such as the presence of a sysfs
node).  A good example is poll() support for sysfs nodes.

If you need to bump TPACPI_SYSFS_VERSION, you absolutely must add the proper
documentation for the feature to Documentation/laptops/thinkpad-acpi.txt.

TPACPI_VERSION is mostly cosmetic, and adding the mute LED driver looks like
as good a reason to bump it as any other.  You need to at least describe the
new functionality and bump the driver version and date in
Documentation/laptops/thinkpad-acpi.txt.

Other than that, it looks good from the thinkpad-acpi side.  I'll ack it if
you update Documentation/laptops/thinkpad-acpi.txt.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
