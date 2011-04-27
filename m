From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: alsactl has no 'names' command anymore
Date: Wed, 27 Apr 2011 12:22:56 +0200
Message-ID: <201104271222.57027.alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webbox687.server-home.net (webbox687.server-home.net
	[195.149.74.151])
	by alsa0.perex.cz (Postfix) with ESMTP id A1C5924369
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Apr 2011 12:22:59 +0200 (CEST)
Received: from comm.systec-electronic.de (178-25-116-119-dynip.superkabel.de
	[178.25.116.119])
	by webbox687.server-home.net (Postfix) with ESMTP id 72DA8778020
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Apr 2011 12:22:56 +0200 (CEST)
Received: from ws-stein.localnet (ws-stein.systec-electronic.de
	[192.168.10.93])
	by comm.systec-electronic.de (Postfix) with ESMTP id E3FE697C068
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Apr 2011 12:22:57 +0200 (CEST)
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

Hello,

alsactl doesn't have a names comamnd anymore. It was removed with commit 
ef8bfcecda9b500f6e71465a396cc5e01a2671bf but the help text still exists. 
Please consider reverting commit 6d32e055d73edfe6be90135c500dcb32491cf04d.
Thanks

Regards,
Alexander
