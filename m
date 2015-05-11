From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: commit b1ef29725865 (ACPI _REV=2) causes sound
 regression on Dell XPS 13 [Was: Discussion around quirking the _REV
 behavior for the XPS 13 (2015) until 4.2]
Date: Mon, 11 May 2015 20:26:58 +0200
Message-ID: <20150511182658.GA8516@isilmar-3.linta.de>
References: <55401602.5050907@dell.com>
 <55480021.1090402@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from linta.de (isilmar-3.linta.de [188.40.101.200])
 by alsa0.perex.cz (Postfix) with ESMTP id 884C5260631
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2015 20:26:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <55480021.1090402@dell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mario Limonciello <mario_limonciello@dell.com>, robert.moore@intel.com, lv.zheng@intel.com, rafael.j.wysocki@intel.com
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, broonie@kernel.org, alsa-devel@alsa-project.org, han.lu@intel.com
List-Id: alsa-devel@alsa-project.org

Hi,

(CC'ing sound experts)

indeed, commit b1ef29725865 causes a severe regression -- actually, it
causes sound to be totally unusuable on the Dell XPS 13 (2015) on
Debian jessie, while it works fine in 4.0 / with b1ef29725865 reverted.

According to an off-list discussion, the sound breakage (and not just some
jack detection issue) seems to be caused due to alsa-lib being too old.
The matter is further complicated by the issue that the driver
asks for some firmware blob intel/IntcPP01.bin which (at least) I
cannot find anywhere.

Under the no-regression rule, this means that either b1ef29725865 needs
to be reverted or we need to find another solution to this matter, such as
an override. And I think it is needed for longer than just for 4.1, as it
will continue to be cause regressions on quite recent userspace.

Best,
	Dominik


PS/OT: Probably I'm preaching to the choir, but @Mario: it's a pity the
XPS (or some versions of it) with pre-installed Ubuntu actually ships
with a Wifi adapter which seems to be unsupported by upstream Linux...


On Mon, May 04, 2015 at 06:26:25PM -0500, Mario Limonciello wrote:
> 
> On 04/28/2015 06:21 PM, Mario Limonciello wrote:
> >Hi,
> >
> >Due to b1ef2972586577e0ca9675254ee141f65a8824e5 landing recently as a result of some previous ACPI community discussion, the Dell XPS 13 (2015) no longer has fully functional audio.  In case you aren't aware, the XPS 13 (2015) switches audio modes based upon a combination of what's detected for the _OSI string and _REV values. When "Windows 2013" is found with _REV=2 the audio codec will be configured for I2S audio mode.  When "Windows 2013" with _REV=5 is found it will be configured for HDA audio mode.
> >
> >I2S audio is improving, but not as mature as HDA audio mode is at this point.  Currently jack detection does not work properly in 4.1 with I2S audio codecs.  I've been notified that the support for jack detection will be landing in 4.2.  I'd like to discuss the possibility of including a quirk for the _REV behavior when the DMI information corresponding to the Dell XPS 13 (2015) is detected for 4.1.  This will let it continue to run in HDA mode until I2S mode is mature.
> >
> >I'd also like to plan for the quirk to be dropped when jack detection has landed for 4.2 (or if it gets pushed out further when it lands for 4.3).
> >
> >Would you guys be open to that?
> >
> >Thanks,
> Hello,
> 
> I just wanted to follow up on this, I would like to come up with a solution before it's too late for 4.1 on the XPS 13 (2015).
> 
> Thanks,
