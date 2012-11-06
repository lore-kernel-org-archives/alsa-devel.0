From: Massimo Del Fedele <max@veneto.com>
Subject: Re: Fix for Asus G75 notebook subwoofer
Date: Tue, 06 Nov 2012 15:18:58 +0100
Message-ID: <k7b68h$epd$1@ger.gmane.org>
References: <k6rkr2$usv$1@ger.gmane.org> <s5hy5ifgmbq.wl%tiwai@suse.de>
 <k7ajdq$42u$1@ger.gmane.org> <s5hsj8ngkxe.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 24070261723
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2012 15:19:09 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1TVjzo-0005A7-Ud
 for alsa-devel@alsa-project.org; Tue, 06 Nov 2012 15:19:16 +0100
Received: from host118-251-dynamic.0-87-r.retail.telecomitalia.it
 ([87.0.251.118]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Tue, 06 Nov 2012 15:19:16 +0100
Received: from max by host118-251-dynamic.0-87-r.retail.telecomitalia.it with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Tue, 06 Nov 2012 15:19:16 +0100
In-Reply-To: <s5hsj8ngkxe.wl%tiwai@suse.de>
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

Il 06/11/2012 10:06, Takashi Iwai ha scritto:

>
> Could you attach to ML too?

I tried, but they're too big
>
>>
>> BTW, did you see the above patch (error in via_auto_fill_dac_nids) ?
>> My patch isn't correct either (fails when the 'continue' path is taken)
>> but it's better than now. I guess that code should be rewritten, it's
>> quite weird in respect to dac numbering.
>
> Could you elaborate a bit more?
>

Ok. here the original functions :

static bool is_empty_dac(struct hda_codec *codec, hda_nid_t dac)
{
	struct via_spec *spec = codec->spec;
	int i;

	for (i = 0; i < spec->multiout.num_dacs; i++) {     <--- uses spec->multiout.num_dacs as used DAC count
		if (spec->multiout.dac_nids[i] == dac)
			return false;
	}
	if (spec->hp_dac_nid == dac)
		return false;
	return true;
}


.....................

static bool __parse_output_path(struct hda_codec *codec, hda_nid_t nid,
				hda_nid_t target_dac, int with_aa_mix,
				struct nid_path *path, int depth)
{
	struct via_spec *spec = codec->spec;
	hda_nid_t conn[8];
	int i, nums;

	if (nid == spec->aa_mix_nid) {
		if (!with_aa_mix)
			return false;
		with_aa_mix = 2; /* mark aa-mix is included */
	}

	nums = snd_hda_get_connections(codec, nid, conn, ARRAY_SIZE(conn));
	for (i = 0; i < nums; i++) {
		if (get_wcaps_type(get_wcaps(codec, conn[i])) != AC_WID_AUD_OUT)
			continue;
		if (conn[i] == target_dac || is_empty_dac(codec, conn[i])) {       <--- calls is_empty_dac, but spec->multiout.num_dacs not set here
			/* aa-mix is requested but not included? */
			if (!(spec->aa_mix_nid && with_aa_mix == 1))
				goto found;
		}
	}
	if (depth >= MAX_NID_PATH_DEPTH)
		return false;
	for (i = 0; i < nums; i++) {
		unsigned int type;
		type = get_wcaps_type(get_wcaps(codec, conn[i]));
		if (type == AC_WID_AUD_OUT)
			continue;
		if (__parse_output_path(codec, conn[i], target_dac,
					with_aa_mix, path, depth + 1))
			goto found;
	}
	return false;

   found:
	path->path[path->depth] = conn[i];
	path->idx[path->depth] = i;
	if (nums > 1 && get_wcaps_type(get_wcaps(codec, nid)) != AC_WID_AUD_MIX)
		path->multi[path->depth] = 1;
	path->depth++;
	return true;
}

....................

static int via_auto_fill_dac_nids(struct hda_codec *codec)
{
	struct via_spec *spec = codec->spec;
	const struct auto_pin_cfg *cfg = &spec->autocfg;
	int i, dac_num;
	hda_nid_t nid;

	spec->multiout.dac_nids = spec->private_dac_nids;
	dac_num = 0;
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
			spec->private_dac_nids[i] = dac;   <---- should be, IMHO, spec->private_dac_nids[dac_num] instead
			dac_num++;
		}
	}
	if (!spec->out_path[0].depth && spec->out_mix_path.depth) {
		spec->out_path[0] = spec->out_mix_path;
		spec->out_mix_path.depth = 0;
	}
	spec->multiout.num_dacs = dac_num;     <--- sets spec->multiout.num_dacs ONLY at end of search, do is_empty_dac always returns true during search
	return 0;
}


Resuming ;

1) during scan, the spec->multiout.num_dacs is taken as the number of already used DACs, but this is updated jut at END of scan, so during scan
     the first DAC is always taken.
2) spec->private_dac_nids[i] = dac; should be spec->private_dac_nids[dac_num++] = dac; the 'continue' statement above can leave some holes of
     uninitializad data in spec->private_dac_nids.
3) spec->multiout.num_dacs sould be updated on EACH dac found, not just at end, otherwise you've got the problem at point 1

The patch I posted on former post is incomplete (don't solve the 'holes' due to continue statement), so it should be rewritten.
If you mean, I can do it correctly on next days.

Ciao

Max
