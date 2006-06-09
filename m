From: Eliot Blennerhassett <linux@blennerhassett.gen.nz>
Subject: AudioScience asihpi HPI + ALSA drivers released.
Date: Fri, 9 Jun 2006 19:53:36 +1200
Message-ID: <200606091953.37432.linux@blennerhassett.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>, Delio Brignoli <dbrignoli@audioscience.com>
List-Id: alsa-devel@alsa-project.org


Get your smoking hot tarball here:

http://www.audioscience.com/internet/download/asihpi_hpi300_alsa1.0.11.tar.bz2
Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>

This replaces the contents of alsa-driver/pci/asihpi.  It builds a single 
module that supports both ALSA and HPI interfaces.
This is such a major reorganisation of the code that it doesn't make sense (to 
me anyway) to provide it as a patch against existing code.  Future minor 
changes certainly will be submitted as patches.

Currently requires the hpi driver to have been installed in order to install 
firmware (it doesn't depend on the hpi driver module at all though).
http://www.audioscience.com/internet/download/hpklinux-3.00.tar.gz

regards
 
--
Eliot Blennerhassett
AudioScience


Release notes v3.00 Jun-05-2006
Detailed Release notes here:
http://www.audioscience.com/internet/download/drvnotes.txt

Summary:

	ASI4xxx - errata workarounds for Intel 9XX chipset based computers. Not 100% 
guaranteed. 
	          Users must test before deployment.
	ASI50xx - 16-24 kHz not supported. 192 kHz channel assignment fixes.
	ASI6044 - Now runs at 225 Mhz. This fixes lockups on some Intel 9XX chipset 
based computers.
	ASI6416 - MP2 encode speed up. 16-Play mode added. Fix bug in 44.1->48 kHz 
sample rate converter.
	ASI66xx - added.
	Removed - ASI44xx, ASI4500, ASI4601, ASI8800.


Details:
	Linux Driver:
		- various maintainer build enhancements
		- firmware loading: better configure detection of directory,
		- dsp bin placed in asihpi subdirectory
		- RPM build uses configured firmware dir.
		- update library version from 0.0.0  to 1.0.0:
		- Add tone and silence detector APIs. Add async object and apis.
		- Add AdapterEnumerateProperty
		- Remove HPI_GetLastErrorDetail, gadwHpiSpecificError
		- update hpimod.c for 2.4 kernel
		- driver module improved cleanup after error during init
		- asihpirec/play format option changed to -f
		- asihpitest,asihpitune display correct control listing with disabled
		  controls
		- asihpi start script creates dev file even if driver loaded already by
		  hotplug
		- remove asihpireset from dist.  Split kernel out of hpios_linux.h
		- use new SMP locking
