From: Jaroslav Kysela <perex@perex.cz>
Subject: finally, ALSA 1.0.24 is out
Date: Mon, 31 Jan 2011 16:16:40 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1101311605240.6272@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 5CADD24575
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 16:16:41 +0100 (CET)
Received: from server.perex.cz (server.perex.cz [172.16.0.20])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	536A9149FFA
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 16:16:41 +0100 (CET)
Received: from eeebox2.perex-int.cz (localhost [127.0.0.1])
	by server.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	359E0850D7
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 16:16:41 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello all,

 	after very intensive testing, I released all ALSA packages with 
version number 1.0.24(+) :

     * alsa-driver-1.0.24
     * alsa-lib-1.0.24.1
     * alsa-utils-1.0.24.2
     * alsa-tools-1.0.24
     * alsa-firmware-1.0.24
     * alsa-plugins-1.0.24
     * pyalsa-1.0.24

 	The full list of changes is here:

http://www.alsa-project.org/main/index.php/Changes_v1.0.23_v1.0.24

 	There is a ton of work in these parts (among others):

* alsa-driver
   - HDA driver
   - ASoC tree
   - USB driver
* alsa-library
   - Use Case Manager
* alsa-utils
   - alsaloop and alsaucm introduction
   - alsactl improvements
* alsa-tools
   - updated hdspmixer

 	Please, report compilation problems directly to me or to the 
alsa-devel mailing list.

 				Enjoy this release,
 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
