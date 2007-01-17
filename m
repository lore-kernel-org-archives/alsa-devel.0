From: Eliot Blennerhassett <linux@audioscience.com>
Subject: [PATCH] asihpi driver 3.05.07
Date: Wed, 17 Jan 2007 13:06:05 +1300
Message-ID: <200701171306.05598.linux@audioscience.com>
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Greetings,

This patch includes changes between our release 30506 and 30507.
There are two bugfixes.  The rest of the changes are mostly cosmetic.
(Note I will be on vacation next week, so if you have any questions, be 
quick ;)

The patch is here:
http://audioscience.com/internet/download/beta/alsa-driver-hg3224_asihpi30507-1.patch

*ATTENTION* alsa requires updated firmware:
http://audioscience.com/internet/download/beta/asidsp_firmware-3.05.07.tar.bz2

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Changelog:
asihpi.c: Fix problem with capture hanging. Tweak verbose logging options.

hpi6205.c: Fix bus master buffer allocation

hpidspcd.c: Remove unused code

hpifunc.c: Doxygen comments

hpi.h: change some datastructures to improve compatibility with older driver, 
versions.  *requires matching DSP firmware*. 

other files: minor changes.
-- 
--
Eliot Blennerhassett
AudioScience Inc.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
