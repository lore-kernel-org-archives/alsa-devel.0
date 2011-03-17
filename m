From: sudarshan.bisht@nokia.com
Subject: [PATCH] *** Fixed issues/defects reported by Coverity
	tool ***
Date: Thu, 17 Mar 2011 10:12:18 +0200
Message-ID: <1300349539-32209-1-git-send-email-sudarshan.bisht@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da02.nokia.com (smtp.nokia.com [147.243.128.26])
	by alsa0.perex.cz (Postfix) with ESMTP id DA6761038C4
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 09:13:57 +0100 (CET)
Received: from localhost.localdomain (esdhcp-heru02554.research.nokia.com
	[172.21.25.54])
	by mgw-da02.nokia.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id
	p2H8DqZs015773
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 10:13:54 +0200
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

From: Sudarshan <sudarshan.bisht@nokia.com>

	Coverity Static Analysis helps developers find hard-to-spot,
yet potentially crash-causing defects early in the development phase,
reducing the cost,time, and risk of software errors.
	This patch has a fix for conditions where 1) variable is used 
evern after getting freed thus causing junk assignment and 2) double 
free of memory.

Sudarshan (1):
  alsa-lib: fixed coverity reported issues under "USE_AFTER_FREE"
    checker.

 src/control/control_hw.c |    1 +
 src/mixer/mixer.c        |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)
