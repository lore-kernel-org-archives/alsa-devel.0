From: Deweloper <deweloper@wp.pl>
Subject: Re: hw/sw params API in alsa-lib miscompiled,
 result: unusable alsa-utils
Date: Tue, 21 Mar 2017 17:33:29 +0100
Message-ID: <20170321173329.05668ee0@mocarz.dom>
References: <20170320151949.1d7494b6@amazur-u.kat.adbgroup.pl>
 <d3512e34-5dde-33fc-6b4f-ad68f1b47550@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
 by alsa0.perex.cz (Postfix) with ESMTP id DAFB3267334
 for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2017 17:33:34 +0100 (CET)
Received: from user-31-174-88-217.play-internet.pl (HELO mocarz.dom)
 (deweloper@wp.pl@[31.174.88.217]) (envelope-sender <deweloper@wp.pl>)
 by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
 for <alsa-devel@alsa-project.org>; 21 Mar 2017 17:33:33 +0100
In-Reply-To: <d3512e34-5dde-33fc-6b4f-ad68f1b47550@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 21 Mar 2017 09:10:09 +0100
Clemens Ladisch <clemens@ladisch.de> wrote:

> Deweloper wrote:
> > I built alsa-lib  
> 
> How?
> 

./configure --host=i586-buildroot-linux-uclibc \
 --prefix=/usr --disable-static --enable-shared \
 --disable-aload --disable-topology --disable-thread-safety \
 --disable-rawmidi --disable-hwdep --disable-seq --disable-ucm \
 --disable-alisp --disable-old-symbols --disable-python \
 --with-max-cards=8 --with-pcm-plugins= --with-ctl-plugins=
