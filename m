From: Alain Kalker <a.c.kalker@gmail.com>
Subject: [BUG] src/conf/alsa.conf: Hard-coded path
 `/etc/asound.conf`, needs `@func sysconfdir`.
Date: Sun, 5 Mar 2017 19:17:55 +0100
Message-ID: <a844ffab-3a8b-bc92-9296-0554682553cf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f177.google.com (mail-wr0-f177.google.com
 [209.85.128.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 4420226583C
 for <alsa-devel@alsa-project.org>; Sun,  5 Mar 2017 19:17:57 +0100 (CET)
Received: by mail-wr0-f177.google.com with SMTP id l37so102921132wrc.1
 for <alsa-devel@alsa-project.org>; Sun, 05 Mar 2017 10:17:57 -0800 (PST)
Received: from [192.168.1.116] ([84.245.9.255])
 by smtp.googlemail.com with ESMTPSA id o70sm11682914wmi.26.2017.03.05.10.17.55
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 05 Mar 2017 10:17:55 -0800 (PST)
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

The file `src/conf/alsa.conf` contains the hard-coded path 
`/etc/asound.conf`, which in some use cases may not be correct.

One particular use case: Termux[1], a "Linux subsystem for Android", 
plans to use ALSA plugins to communicate with the OpenSL ES 
implementation in Android. In doing so, it needs to not conflict with 
any vendor provided ALSA implentation, which could conceivably use an 
`/etc/asound.conf` of its own. At any rate, the system `/etc` directory 
is normally not writable by non-root users of Android.

I would suggest adding a `snd_func_sysconfdir` in `src/confmisc.c 
(analogous to `snd_func_datadir`) so packagers and users can place a 
global `asound.conf` file in a directory to which they have write access 
and which doesn't conflict with the systems ALSA.
The desired path can already be specified at build time by using 
`./configure --sysconfdir=<dir>`, which conveniently defaults to 
PREFIX/etc in any case. It is available as configure variable: 
`sysconfdir='${prefix}/etc'`, and only needs to be substituted to be 
available to `src/confmisc.c`.

Kind regards,

Alain Kalker

[1]: https://termux.com/
