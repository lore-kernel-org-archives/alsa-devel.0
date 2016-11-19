From: Julia Lawall <julia.lawall@lip6.fr>
Subject: question about sound/soc/intel/boards/mfld_machine.c
Date: Sat, 19 Nov 2016 18:34:01 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1611191827190.1925@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, yang.jie@intel.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hello,

I wonder if the file sound/soc/intel/boards/mfld_machine.c is useful?
Until:

commit e56c72d5f201044b14191c5b83a25e17f2d68ccf
Author: Jie Yang <yang.jie@intel.com>
Date:   Thu Apr 2 15:37:02 2015 +0800

    ASoC: Intel: create boards folder and move sst boards files in

it was in the directory sound/soc/intel and mentioned in
sound/soc/intel/Makefile.  The above patch moved it to
sound/soc/intel/boards/, but didn't adjust its Makefile entry.  The patch:

commit b97169da06992ef04081e66ed22bbdb23dbf6610
Author: Jie Yang <yang.jie@intel.com>
Date:   Thu Apr 2 15:37:04 2015 +0800

    ASoC: Intel: create atom folder and move atom platform files in

removed it from sound/soc/intel/Makefile, but didn't move it anywhere.
As far as I can tell, there is currently no make information for the file
in the kernel.

Should the file be dropped?

julia
