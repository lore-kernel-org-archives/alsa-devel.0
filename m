From: Jaroslav Kysela <perex@perex.cz>
Subject: TLV support for PCM (in driver)
Date: Wed, 16 Jan 2008 15:23:37 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0801161504450.7446@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id CD526243FF
	for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2008 15:23:37 +0100 (CET)
Received: from server.perex.cz (server.perex.cz [172.16.0.20])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	BF9BA14A0A8
	for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2008 15:23:37 +0100 (CET)
Received: from tm8103.perex-int.cz (localhost [127.0.0.1])
	by server.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	A43A98434C
	for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2008 15:23:37 +0100 (CET)
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

Hi,

	I am actually thinking to add TLV support to each PCM stream. The 
reason is to obtain various "static" information from the driver without 
even opening the PCM stream. The current API lack:

a) get channel info / name / position (e.g. Front Left Speaker)
   - not sure how to handle multichannel cards
   - I'm sure that this is something to be user configurable
b) get possible channels
c) get possible formats
d) various inter-PCM-device constraint description (e.g. if S/PDIF 
   PCM stream can be used with analog etc.)
e) eventually more information for device name hinting for userspace 
   (current problems for HDA, AC97, USB devices are that we have only one 
   .conf file per driver covering all hardware - we need to detect real 
   device capabilities and show only devices which can be really used)

	Opinions?

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
