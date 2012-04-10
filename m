From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ALSA: hda - Fix internal mic for Lenovo Ideapad
	U300s
Date: Tue, 10 Apr 2012 11:37:32 +0300
Message-ID: <20120410083732.GA26832@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rcsinet15.oracle.com (rcsinet15.oracle.com [148.87.113.117])
	by alsa0.perex.cz (Postfix) with ESMTP id 580F124543
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Apr 2012 10:37:43 +0200 (CEST)
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
To: david.henningsson@canonical.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello David Henningsson,

This is a semi-automatic email about new static checker warnings.

The patch 18dcd3044e4c: "ALSA: hda - Fix internal mic for Lenovo 
Ideapad U300s" from Apr 2, 2012, leads to the following Smatch 
complaint:

sound/pci/hda/patch_conexant.c:4449 apply_fixup()
	 error: we previously assumed 'quirk' could be null (see line 4444)

sound/pci/hda/patch_conexant.c
  4443		quirk = snd_pci_quirk_lookup(codec->bus->pci, quirk);
  4444		if (quirk && table[quirk->value]) {
                    ^^^^^
Old check.

  4445			snd_printdd(KERN_INFO "hda_codec: applying pincfg for %s\n",
  4446				    quirk->name);
  4447			apply_pincfg(codec, table[quirk->value]);
  4448		}
  4449		if (quirk->value == CXT_FIXUP_STEREO_DMIC) {
                    ^^^^^^^^^^^^
New unchecked dereference.

  4450			snd_printdd(KERN_INFO "hda_codec: applying internal mic workaround for %s\n",
  4451				    quirk->name);

regards,
dan carpenter
