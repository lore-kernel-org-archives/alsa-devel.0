From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: ALSA: hda - Fix internal mic for Lenovo Ideapad
	U300s
Date: Tue, 10 Apr 2012 11:47:56 +0200
Message-ID: <4F8401CC.8040106@canonical.com>
References: <20120410083732.GA26832@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C851104176
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Apr 2012 11:47:56 +0200 (CEST)
In-Reply-To: <20120410083732.GA26832@elgon.mountain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 04/10/2012 10:37 AM, Dan Carpenter wrote:
> Hello David Henningsson,
>
> This is a semi-automatic email about new static checker warnings.
>
> The patch 18dcd3044e4c: "ALSA: hda - Fix internal mic for Lenovo
> Ideapad U300s" from Apr 2, 2012, leads to the following Smatch
> complaint:
>
> sound/pci/hda/patch_conexant.c:4449 apply_fixup()
> 	 error: we previously assumed 'quirk' could be null (see line 4444)

Thanks for spotting - will provide patch shortly.


>
> sound/pci/hda/patch_conexant.c
>    4443		quirk = snd_pci_quirk_lookup(codec->bus->pci, quirk);
>    4444		if (quirk&&  table[quirk->value]) {
>                      ^^^^^
> Old check.
>
>    4445			snd_printdd(KERN_INFO "hda_codec: applying pincfg for %s\n",
>    4446				    quirk->name);
>    4447			apply_pincfg(codec, table[quirk->value]);
>    4448		}
>    4449		if (quirk->value == CXT_FIXUP_STEREO_DMIC) {
>                      ^^^^^^^^^^^^
> New unchecked dereference.
>
>    4450			snd_printdd(KERN_INFO "hda_codec: applying internal mic workaround for %s\n",
>    4451				    quirk->name);
>
> regards,
> dan carpenter
>



-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
