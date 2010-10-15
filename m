From: Cem ERGEN <cemergen@gmail.com>
Subject: -32 broken pipe
Date: Fri, 15 Oct 2010 07:41:05 +0000
Message-ID: <AANLkTim_sdgs0VAU1Ncse9h8a+-3rsB9WbXCQBibdG8B@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.216.172])
	by alsa0.perex.cz (Postfix) with ESMTP id E0D25103BBA
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Oct 2010 09:41:06 +0200 (CEST)
Received: by qyk8 with SMTP id 8so1080225qyk.17
	for <alsa-devel@alsa-project.org>; Fri, 15 Oct 2010 00:41:06 -0700 (PDT)
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

hello
i've 8 hubs and each hubs has got 4 usb soundcards, i tried to install but i
cannot



[root@localhost ~]# 4 asoundinit_tx:1519 snd_pcm_hw_params() -32 Broken pipe
4 asoundinit_tx:1612 fail
/usr/sbin/safe_asterisk: line 125:  7171 Segmentation fault      nice -n
$PRIORITY ${ASTSBINDIR}/asterisk -f ${CLIARGS} ${ASTARGS}
Asterisk ended with exit status 139
Asterisk exited on signal EXITSTATUS-128.
cat: /var/run/asterisk.pid: No such file or directory




how could i fix that?
