From: zhejiang <zhe.jiang@intel.com>
Subject: Alsa 1.0.15rc2 and oops with Dell M1210
Date: Sat, 29 Sep 2007 17:07:17 +0800
Message-ID: <1191056837.4984.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F22124371
	for <alsa-devel@alsa-project.org>;
	Sat, 29 Sep 2007 11:09:09 +0200 (CEST)
In-Reply-To: 
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

Seems that the spec->input_mux contains no item at all.
So system maybe crash in the snd_hda_input_mux_info() when try to copy
the items[].label,which is null pointer.

May you replace the function  stac92xx_mux_enum_info() in
alsa-driver-1.0.15rc2/alsa-kernel/pci/hda/patch_sigmatel.c ?

static int stac92xx_mux_enum_info(struct snd_kcontrol *kcontrol, struct
snd_ctl_elem_info *uinfo)
{
	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
	struct sigmatel_spec *spec = codec->spec;
	printk("spec->input_mux->num_items is %d
\n",spec->input_mux->num_items);
	if(!spec->input_mux->num_items)
		return 0;
	return snd_hda_input_mux_info(spec->input_mux, uinfo);
}

Does it still crash?
What's the number of num_items?

The pin_config for M1210  didn't include any input pin.
I wonder why.
