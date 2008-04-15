From: "Vitaly V. Ch" <vitaly.v.ch@gmail.com>
Subject: ac97_bus: exports duplicate symbol ac97_bus_type
	(owned by kernel)
Date: Tue, 15 Apr 2008 15:31:10 +0000
Message-ID: <6efe08af0804150831u68bc6104h9aa24f97624618ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 133F9103806
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Apr 2008 17:31:22 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 5so1062563ywr.2
	for <alsa-devel@alsa-project.org>; Tue, 15 Apr 2008 08:31:10 -0700 (PDT)
Content-Disposition: inline
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

#modprobe snd_via82xx
#dmesg|tail
ac97_bus: exports duplicate symbol ac97_bus_type (owned by kernel)
snd_ac97_codec: disagrees about version of symbol ac97_bus_type
snd_ac97_codec: Unknown symbol ac97_bus_type
snd_via82xx: Unknown symbol snd_ac97_resume
snd_via82xx: Unknown symbol snd_ac97_set_rate
snd_via82xx: Unknown symbol snd_ac97_update_bits
snd_via82xx: Unknown symbol snd_ac97_mixer
snd_via82xx: Unknown symbol snd_ac97_bus
snd_via82xx: Unknown symbol snd_ac97_update_power
snd_via82xx: Unknown symbol snd_ac97_suspend
snd_via82xx: Unknown symbol snd_ac97_get_short_name
snd_via82xx: Unknown symbol snd_ac97_tune_hardware

any ideas?

\\wbr Vitaly
