From: Bin Gao <bin.gao@intel.com>
Subject: Built-in speaker was not auto-muted on EeePC 1000H
Date: Wed, 24 Feb 2010 14:24:26 +0800
Message-ID: <1266992667.2302.503.camel@DG965>
Reply-To: bin.gao@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 0240624404
	for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2010 07:25:10 +0100 (CET)
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

The built-in speaker was not muted when a headphone was plugged.
I found this issue on EeePC 1000H and 1005HA, both of them have ALC269
codec. The kernel tested is 2.6.33-rc8. Is this a known alsa driver
regression? I remember 2.6.32 kernel worked fine for me. 

Thanks,
Bin
