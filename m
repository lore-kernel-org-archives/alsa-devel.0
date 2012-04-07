From: madhukesh s <madhukeshs@gmail.com>
Subject: sgtl5000 module install fails during instantiation for
	i.MX53 QSB
Date: Sat, 7 Apr 2012 12:02:59 +0530
Message-ID: <CADT92yYuO1Kcany5HkpoeqxR4OneeN576sErwxGrer_fuFMbRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 9C72B2414E
	for <alsa-devel@alsa-project.org>;
	Sat,  7 Apr 2012 08:33:02 +0200 (CEST)
Received: by laap9 with SMTP id p9so2593352laa.38
	for <alsa-devel@alsa-project.org>; Fri, 06 Apr 2012 23:32:59 -0700 (PDT)
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
Cc: festevam@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi,

On insmod'ing alsa modules for i.MX53 QSB, I get the following error:

root@freescale-qsb:/lib/modules/2.6.38.8+# modprobe snd-soc-sgtl5000
snd_soc_instantiate_card:Entry
snd_soc_instantiate_card:Entry
soc_probe_dai_link:Entry
soc_probe_codec: Probing for card sgtl5000-audio
sgtl5000_enable_regulators:Entry
_regulator_get: devname = 1-000a
sgtl5000 1-000a: regulator_bulk_get [for (null)]: Failed to get supply
'VDDA': -19
sgtl5000_enable_regulators: regulator_bulk_get err!!!
print_constraints: 1-000a: 1200 mV normal
_regulator_get: devname = 1-000a
sgtl5000 1-000a: regulator_bulk_get [for (null)]: Failed to get supply
'VDDA': -19
sgtl5000 1-000a: Failed to request supplies:1 -19
sgtl5000 1-000a: asoc: failed to probe CODEC sgtl5000.1-000a: -19
asoc: failed to probe codec sgtl5000.1-000a
asoc: failed to instantiate card sgtl5000-audio: -19

On adding more printks, I realize that "_regulator_get" function is
failing(not able to find supply VDDA).

The statically built module gives no such errors. Can someone give some
info on this?

Regards,
maas
