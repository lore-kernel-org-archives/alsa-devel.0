From: John Baboval <john.baboval@virtualcomputer.com>
Subject: [PATCH 0/1] ThinkPad T410[s] docking station line-out
Date: Thu, 02 Dec 2010 11:19:56 -0500
Message-ID: <4CF7C72C.4070203@virtualcomputer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server514.appriver.com (server514d.exghost.com [72.32.253.69])
	by alsa0.perex.cz (Postfix) with ESMTP id 022D7103AC6
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 17:19:57 +0100 (CET)
Received: from [72.32.253.153] (HELO fe04.exg4.exghost.com)
	by server514.appriver.com (CommuniGate Pro SMTP 5.3.2)
	with ESMTP id 136525532 for alsa-devel@alsa-project.org;
	Thu, 02 Dec 2010 10:20:05 -0600
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

Hopefully I get the protocol for this correct... If not, let me know and 
I'll re-submit.

On the docking station for the Lenovo T410 and T410s, the line-out 
doesn't work. The trouble seems to be that it generates a plug event, 
but then doesn't report that the jack is connected. So automute mutes 
the jack when you plug something into it. The following patch (next 
message) fixes it...

-John
