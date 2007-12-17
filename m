From: Hans-Christian Egtvedt <hcegtvedt@atmel.no>
Subject: Is the mixer interface in the kernel protect against
	concurrent	access?
Date: Mon, 17 Dec 2007 15:13:37 +0100
Message-ID: <1197900817.1365.38.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (nat-132.atmel.no [80.232.32.132])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A1FF244E8
	for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2007 15:14:19 +0100 (CET)
Received: from [10.191.252.83] (dhcp-252-083.norway.atmel.com [10.191.252.83])
	by relay.atmel.no (8.13.4/8.13.4) with ESMTP id lBHEEIxg054958
	for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2007 15:14:18 +0100 (CET)
	(envelope-from hcegtvedt@atmel.no)
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

I am solving a locking bug in the at73c213 SPI sound driver, and
wondered if the mixer API is protected against concurrent access in
ALSA? Or should I implement a mutex to protect my hardware against
concurrent access?

-- 
Mvh
Hans-Christian Egtvedt
