From: LCID Fire <lcid-fire@gmx.net>
Subject: Quirks device not showing up
Date: Thu, 07 Jun 2007 22:58:03 +0200
Message-ID: <4668715B.1020208@gmx.net>
References: <46506D9D.4000701@gmx.net>	<75b66ecd0705201225w5e6a7e28t7a61f000cd5e2352@mail.gmail.com>	<s5hk5v2p4az.wl%tiwai@suse.de>
	<46520655.7000402@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 14B972463D
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Jun 2007 22:58:36 +0200 (CEST)
In-Reply-To: <46520655.7000402@gmx.net>
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

Well I defined a quirks for my usb device. I mined the probe code with
output and it creates a new driver instance for my device as well as it
finds the channels. Nevertheless I don't get my device listed in
userspace. Is there anything special to be done besides defining a quirks?
