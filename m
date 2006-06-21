From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Update: emu1212m
Date: Wed, 21 Jun 2006 10:04:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0606211000590.9535@tm8103.perex-int.cz>
References: <44951964.9020509@superbug.co.uk> <4498FBC4.5090900@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <4498FBC4.5090900@superbug.co.uk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 21 Jun 2006, James Courtier-Dutton wrote:

> Update: I have now discovered how 1 works. I just need to write some
> code to get it working.
> 
> Question:
> For (1), the FPGA array is filled with 78756 bytes of netlist code.
> I suppose one could consider this 78756 bytes as firmware.
> Should this firmware sit somewhere in userspace?
> The trouble is, that if one changes some controls on the device, e.g.
> switching from SPDIF to ADAT digital outputs, a whole new different
> firmware image is loaded. So, one has multiple different firmware
> images, with one swapping between them. Should these firmware images be
> left in the kernel then, instead of using the userspace firmware api?

I think that the hardware configuration might be implemented using kernel 
module options, so that we can leave the firmware in the user space. It 
will also avoid FPGA design switching when default settings would be 
replaced with the user selected one using alsactl.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
