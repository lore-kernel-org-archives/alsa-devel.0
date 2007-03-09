From: Randy Cushman <rcushman_linux@earthlink.net>
Subject: RFC: Enhance AD AC '97 mixer control names
Date: Fri, 09 Mar 2007 10:53:49 -0500
Message-ID: <45F1830D.9020609@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mta10.adelphia.net (mta10.adelphia.net [68.168.78.202])
	by alsa0.perex.cz (Postfix) with ESMTP id 0BCD22448E
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2007 16:53:56 +0100 (CET)
Received: from [127.0.0.1] (really [67.20.25.133]) by mta10.adelphia.net
	(InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
	id <20070309155355.RDMO2272.mta10.adelphia.net@[127.0.0.1]>
	for <alsa-devel@alsa-project.org>; Fri, 9 Mar 2007 15:53:55 +0000
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The Analog Devices multichannel AC '97 CODECs are configured in ALSA to 
use ADI Compatibility Mode (aka AC '97 No Compatibility Mode).  Because 
of this, the function of some "Playback" controls differ from the AC '97 
standard.  I propose renaming the controls to more closely match their 
function.  If no one objects, I will prepare a patch for this.  Details 
follow:

(For each table I will identify the controls using the default AC '97 
names.)

Standard AC '97 control functions:
Master - Front pin attenuation
Headphone - Headphone pin attenuation
PCM - Multichannel DAC level
Surround - Surround pin attenuation
Center - Center pin attenuation
LFE - LFE pin attenuation

Names currently assigned  for the AD1888, AD1980 and AD1985 CODECs (the 
AD1986 currently uses the default names):
Master - Master Surround
Headphone - Master
PCM - PCM
Surround - Surround
Center - Center
LFE - LFE

ADI function for AD1888, AD1980 and AD1985 CODECs:
Master - Front, Center and LFE pin attenuation
Headphone - Surround or Headphone pin attenuation
(These CODECs have shared pins that are used for either Surround or 
Headphone)
PCM - Front channel DAC level
Surround - Surround channel DAC level
Center - Center channel DAC level
LFE - LFE channel DAC level

ADI function for AD1986 CODEC:
Master - Multichannel pin attenuation
Headphone - Headphone pin attenuation
PCM - Front channel DAC level
Surround - Surround channel DAC level
Center - Center channel DAC level
LFE - LFE channel DAC level

Proposed control names for AD1888, AD1980 and AD1985 CODECs:
Master - Master (Front, Center and LFE)
Headphone - Surround or Headphone
PCM - PCM Front
Surround - PCM Surround
Center - PCM Center
LFE - PCM LFE

Proposed control names for AD1986 CODEC:
Master - Master Multichannel
Headphone - Headphone
PCM - PCM Front
Surround - PCM Surround
Center - PCM Center
LFE - PCM LFE

Randy Cushman



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
