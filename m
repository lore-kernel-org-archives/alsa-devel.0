From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: Noise at end of audio file
Date: Mon, 20 Aug 2007 10:44:14 -0500
Message-ID: <B082902A12CAEE4EA7FE2ED20609013B0163C576@dlee15.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 1BDD224479
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Aug 2007 17:44:47 +0200 (CEST)
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id l7KFiGUe014327
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Mon, 20 Aug 2007 10:44:21 -0500
Received: from dsbe71.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.7/8.13.7) with ESMTP id l7KFiF7L028519
	for <alsa-devel@alsa-project.org>; Mon, 20 Aug 2007 10:44:15 -0500 (CDT)
Content-class: urn:content-classes:message
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

Hi,
 
I listen some noise at the end of playback of an audio file, with some
debug I noticed that the noise appears in the last two period of the
playback. I tried changing the minimum number of period (it was 16 and
changed to 32) but the noise appears even before. Any idea what could be
wrong?
 
Misael
