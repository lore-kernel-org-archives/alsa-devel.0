From: sudarshan.bisht@nokia.com
Subject: [PATCH 0/1] Fixed issues/defects reported by Coverity
	tool
Date: Thu, 17 Mar 2011 11:28:06 +0200
Message-ID: <1300354087-755-1-git-send-email-sudarshan.bisht@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da02.nokia.com (smtp.nokia.com [147.243.128.26])
	by alsa0.perex.cz (Postfix) with ESMTP id E2E2410397C
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 10:29:44 +0100 (CET)
Received: from localhost.localdomain (esdhcp-heru02554.research.nokia.com
	[172.21.25.54])
	by mgw-da02.nokia.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id
	p2H9TfpG013393
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 11:29:41 +0200
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
	This patch has a fix for a situation where variable can become NULL 
after certain function call, but later not been checked before passing to 
the next function call. 

Sudarshan (1):
  alsa-lib: fixed coverity reported issues under "REVERSE_INULL"
    checker.

 src/control/setup.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)
