From: Fulup Ar Foll <fulup.arfoll@iot.bzh>
Subject: Reset to clean state after
	snd_ctl_add_integer_elem_set ?
Date: Tue, 18 Jul 2017 12:30:30 +0200
Message-ID: <5e7c39f0-6eeb-4ef6-44f9-c281533f08a3@iot.bzh>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f48.google.com (mail-lf0-f48.google.com
 [209.85.215.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 92D742664EB
 for <alsa-devel@alsa-project.org>; Tue, 18 Jul 2017 12:30:32 +0200 (CEST)
Received: by mail-lf0-f48.google.com with SMTP id z78so10210080lff.0
 for <alsa-devel@alsa-project.org>; Tue, 18 Jul 2017 03:30:32 -0700 (PDT)
Received: from [10.20.1.21] ([46.18.96.42])
 by smtp.googlemail.com with ESMTPSA id e37sm1691990edb.65.2017.07.18.03.30.30
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Jul 2017 03:30:30 -0700 (PDT)
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

I'm using snd_ctl_add_boolean_elem_set and snd_ctl_add_integer_elem_set 
to create some user kernel controls. While the operation work find I did 
not find any simple command to erase all those controls.

Even "/usr/sbin/alsactl --init" does not remove those added controls. 
The only way I find is to prevent  /usr/sbin/alsactlto happen during 
reboot to really reset the ALSA driver to an initial state, which is 
really not pratical when developing/debugging.

Question: is there a simple method to return to a clean and fresh state 
after snd_ctl_add_xxxx without rebooting the machine ?

Thank you

Fulup
