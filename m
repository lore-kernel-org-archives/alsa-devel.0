From: sudarshan.bisht@nokia.com
Subject: [PATCH 0/1] Fixed issues/defects reported by Coverity
	tool
Date: Thu, 17 Mar 2011 11:34:36 +0200
Message-ID: <1300354477-1088-1-git-send-email-sudarshan.bisht@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa01.nokia.com (smtp.nokia.com [147.243.1.47])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F852103974
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 10:36:12 +0100 (CET)
Received: from localhost.localdomain (esdhcp-heru02554.research.nokia.com
	[172.21.25.54])
	by mgw-sa01.nokia.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id
	p2H9aA4u024531
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 11:36:11 +0200
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
        This patch has got fixes for many potential memory leaks. 


Sudarshan (1):
  alsa-lib: fixed coverity reported issues under "RESOURCE_LEAK"
    checker.

 modules/mixer/simple/sbase.c   |    1 +
 modules/mixer/simple/sbasedl.c |    2 +-
 src/conf.c                     |    2 ++
 src/control/control_hw.c       |    4 +++-
 src/pcm/pcm_file.c             |    5 +++--
 src/pcm/pcm_ladspa.c           |   20 ++++++++++++++------
 src/pcm/pcm_plug.c             |    5 ++++-
 src/pcm/pcm_rate.c             |    1 +
 src/rawmidi/rawmidi.c          |    4 +++-
 9 files changed, 32 insertions(+), 12 deletions(-)
