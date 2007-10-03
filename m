From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: Re: Alsa 1.0.15rc2 and oops with Dell M1210
Date: Wed, 3 Oct 2007 16:58:35 -0300
Message-ID: <200710031658.35289.herton@mandriva.com.br>
References: <1191056837.4984.12.camel@localhost.localdomain>
	<200709291853.29592.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id 291F124524
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Oct 2007 21:58:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 5E23B1A365
	for <alsa-devel@alsa-project.org>; Wed,  3 Oct 2007 16:58:40 -0300 (BRT)
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new,
	port 10025)
	with LMTP id 7JuFtIo8DRjd for <alsa-devel@alsa-project.org>;
	Wed,  3 Oct 2007 16:58:36 -0300 (BRT)
Received: from fox.conectiva (fox.conectiva [10.0.2.195])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 8EDA91A364
	for <alsa-devel@alsa-project.org>; Wed,  3 Oct 2007 16:58:35 -0300 (BRT)
Received: from gotham.conectiva (gotham.conectiva [10.0.2.23])
	by fox.conectiva (Postfix) with ESMTP id 956D12F362
	for <alsa-devel@alsa-project.org>; Wed,  3 Oct 2007 16:58:35 -0300 (BRT)
In-Reply-To: <200709291853.29592.herton@mandriva.com.br>
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

Em Saturday 29 September 2007 18:53:29 Herton Ronaldo Krzesinski escreveu:
> On Saturday 29 September 2007 06:07:17 zhejiang wrote:
> > Seems that the spec->input_mux contains no item at all.
> > So system maybe crash in the snd_hda_input_mux_info() when try to copy
> > the items[].label,which is null pointer.
> >
> > May you replace the function  stac92xx_mux_enum_info() in
> > alsa-driver-1.0.15rc2/alsa-kernel/pci/hda/patch_sigmatel.c ?
> >
> > static int stac92xx_mux_enum_info(struct snd_kcontrol *kcontrol, struct
> > snd_ctl_elem_info *uinfo)
> > {
> > 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
> > 	struct sigmatel_spec *spec = codec->spec;
> > 	printk("spec->input_mux->num_items is %d
> > \n",spec->input_mux->num_items);
> > 	if(!spec->input_mux->num_items)
> > 		return 0;
> > 	return snd_hda_input_mux_info(spec->input_mux, uinfo);
> > }
> >
> > Does it still crash?
> > What's the number of num_items?

I received feedback from the reporter:
spec->input_mux->num_items is 0

Also sound works fine, no more crashes.

--
[]'s
Herton
