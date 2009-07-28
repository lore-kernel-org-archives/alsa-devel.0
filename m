From: Shilpa Kedar Walvekar <shilpa.walvekar@coreobjects.com>
Subject: Using Alsa for AD1981b on 9263
Date: Tue, 28 Jul 2009 14:00:21 +0530
Message-ID: <33A0EEB8D50198449794A1AB9DEB1E01866417C950@copuex01.coreobjects.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from colaex01.coreobjects.com (mailus.coreobjects.com [67.89.120.9])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A5BE245F7
	for <Alsa-devel@alsa-project.org>;
	Tue, 28 Jul 2009 10:30:30 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Alsa-devel@alsa-project.org" <Alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I am using AT91SAM9263 evaluation kit with AD1981b codec. I want to use alsa to play and record audio on this kit.

I tried to install the alsa library, alsa-oss, alsa-util. Alsa driver was part of kernel (2.6.27). I did, ./configure && make && make install for library, oss and util. Now when I try to do aplay -l following happens:
aplay: device_list:223: no soundcards found...

Don't know what is happening. Am I missing any step? What else should be done?
Please help me asap.

Regards,
--Shilpa.
