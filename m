From: Alan Young <Alan.Young@IEE.org>
Subject: Use of snd_atomic_write_t for dshare and friends
Date: Mon, 7 Nov 2016 15:29:29 +0000
Message-ID: <58209DD9.8060905@IEE.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EF54266DE4
 for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2016 16:29:30 +0100 (CET)
Received: by mail-wm0-f48.google.com with SMTP id a197so189574923wmd.0
 for <alsa-devel@alsa-project.org>; Mon, 07 Nov 2016 07:29:30 -0800 (PST)
Received: from [192.168.11.11] (13.110.6.51.dyn.plus.net. [51.6.110.13])
 by smtp.googlemail.com with ESMTPSA id r72sm14120360wmd.21.2016.11.07.07.29.29
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Nov 2016 07:29:30 -0800 (PST)
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

Would it make sense for dshare, and other d-* plugins, to use a shared 
snd_atomic_write_t in the shared memory segment and associated 
snd_atomic_write_xxx() & snd_atomic_read_xxx() calls?
