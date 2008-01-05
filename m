From: Tim Jackson <lists@timj.co.uk>
Subject: alsa-firmware licensing
Date: Sat, 05 Jan 2008 14:15:31 +0000
Message-ID: <477F9103.9010304@timj.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.firecluster.net (blixt.firecluster.net [89.16.161.116])
	by alsa0.perex.cz (Postfix) with ESMTP id CEC9B103854
	for <alsa-devel@alsa-project.org>; Sat,  5 Jan 2008 15:15:56 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

As part of the Fedora Project [1], I'm trying to package [2] the ALSA 
firmware up for easy distribution to Fedora users.

The trouble is that the licensing seems unclear. Specifically:

a) Several firmwares claim to be under the GPL but don't specify a 
version and don't include source - see 
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3411

b) More worryingly, the Emagic EMI 2|6 firmware appears to be under a 
"license" which prohibits ANY redistribution. Quoting from 
emi_26_62/license.txt (my emphasis):

"The firmware contained herein is Copyright (c) 1999-2002 Emagic
as an unpublished work. This notice does not imply unrestricted
or public access to this firmware which is a trade secret of Emagic,
and which ***may not be reproduced, used, sold or transferred to
any third party without Emagic's written consent.***"

Does the ALSA project have special authorisation ("written consent") to 
distribute this? Who within the ALSA project is responsible for the 
-firmware package and might be able to help resolve some of these 
queries? Does anyone have a contact at Emagic (which seems to have been 
bought by Apple) to discuss relaxing the firmware conditions slightly?


Any information most welcome. We'd really like to get the firmware in 
Fedora.

Thanks,

Tim

[1] http://www.fedoraproject.org/
[2] https://bugzilla.redhat.com/show_bug.cgi?id=217259
