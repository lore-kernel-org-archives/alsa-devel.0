From: Jaroslav Kysela <perex@perex.cz>
Subject: alsa-lib: add-on configs directory changed to
	/etc/alsa/conf.d
Date: Wed, 4 Apr 2018 10:12:50 +0200
Message-ID: <a38c315a-e7b8-8531-e010-08c5f486d3b5@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FB152675C8
 for <alsa-devel@alsa-project.org>; Wed,  4 Apr 2018 10:12:52 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 4BC83A0046
 for <alsa-devel@alsa-project.org>; Wed,  4 Apr 2018 10:12:52 +0200 (CEST)
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA
 for <alsa-devel@alsa-project.org>; Wed,  4 Apr 2018 10:12:51 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

   I pushed two commits to the alsa-lib package which changes the
default location for the add-on config files to /etc/alsa/conf.d from
/usr/share/alsa/alsa.conf.d . The reason is to follow the scheme like in
other packages. Also, the users might want to change or disable contents
in those 'default' files.

   Example paths from other packages:

# find /etc -type d -name conf.d
/etc/fonts/conf.d
/etc/NetworkManager/conf.d
/etc/libblockdev/conf.d
/etc/sssd/conf.d
/etc/httpd/conf.d

  Commmits:


http://git.alsa-project.org/?p=alsa-lib.git;a=commit;h=93e03bdc2a3dcd5d12516f5de78e14d88a32ff2c
http://git.alsa-project.org/?p=alsa-lib.git;a=commit;h=78505dccd23546cc77e5221cb21c01325bc0138d

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
