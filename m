From: Massimo Del Fedele <max@veneto.com>
Subject: ALSA hda/patch_via -- Error in via_auto_fill_dac_nids
Date: Wed, 31 Oct 2012 16:54:21 +0100
Message-ID: <k6rhjc$u6m$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id D7C1526168B
 for <alsa-devel@alsa-project.org>; Wed, 31 Oct 2012 16:59:57 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1TTai4-0005LM-3S
 for alsa-devel@alsa-project.org; Wed, 31 Oct 2012 17:00:04 +0100
Received: from host247-229-dynamic.9-87-r.retail.telecomitalia.it
 ([87.9.229.247]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Wed, 31 Oct 2012 17:00:04 +0100
Received: from max by host247-229-dynamic.9-87-r.retail.telecomitalia.it with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Wed, 31 Oct 2012 17:00:04 +0100
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

The function should scan all paths from DACs to OUTS, but like it is just takes the first available DAC.
The problem arises here :

		if (dac) {
			spec->private_dac_nids[i] = dac;
			dac_num++;
		}

Which correctly adds DAC to used list, but doesn't update the total number of found DACs
in spec->multiout.num_dacs; following calls to is_empty_dac() will always return true
for already used DACs, making parse_output_path() return always the first one.

Corrected function should be like this :

static int via_auto_fill_dac_nids(struct hda_codec *codec)
{
	struct via_spec *spec = codec->spec;
	const struct auto_pin_cfg *cfg = &spec->autocfg;
	int i;
	hda_nid_t nid;

	spec->multiout.dac_nids = spec->private_dac_nids;
	spec->multiout.num_dacs = 0;
	for (i = 0; i < cfg->line_outs; i++) {
		hda_nid_t dac = 0;
		nid = cfg->line_out_pins[i];
		if (!nid)
			continue;
		if (parse_output_path(codec, nid, 0, 0, &spec->out_path[i]))
			dac = spec->out_path[i].path[0];
		if (!i && parse_output_path(codec, nid, dac, 1,
					    &spec->out_mix_path))
			dac = spec->out_mix_path.path[0];
		if (dac) {
			spec->private_dac_nids[i] = dac;
			spec->multiout.num_dacs++;
		}
	}
	if (!spec->out_path[0].depth && spec->out_mix_path.depth) {
		spec->out_path[0] = spec->out_mix_path;
		spec->out_mix_path.depth = 0;
	}
	return 0;
}

This one (and a few other changes) allows the subwoofer of asus g75 work correctly.
Sorry for not submitting a patch, I'm quite new to alsa; please tell me if/how I should do it.

Ciao
Max
