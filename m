From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: Re: Alsa 1.0.15rc2 and oops with Dell M1210
Date: Sat, 29 Sep 2007 18:53:29 -0300
Message-ID: <200709291853.29592.herton@mandriva.com.br>
References: <1191056837.4984.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id 930D0244D4
	for <alsa-devel@alsa-project.org>;
	Sat, 29 Sep 2007 23:53:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id C0A1E17D60
	for <alsa-devel@alsa-project.org>; Sat, 29 Sep 2007 18:53:44 -0300 (BRT)
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new,
	port 10025)
	with LMTP id ab+mNtie3KBj for <alsa-devel@alsa-project.org>;
	Sat, 29 Sep 2007 18:53:37 -0300 (BRT)
Received: from [192.168.2.2] (200-103-138-174.ctame705.dsl.brasiltelecom.net.br
	[200.103.138.174])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 5762917D5D
	for <alsa-devel@alsa-project.org>; Sat, 29 Sep 2007 18:53:36 -0300 (BRT)
In-Reply-To: <1191056837.4984.12.camel@localhost.localdomain>
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

On Saturday 29 September 2007 06:07:17 zhejiang wrote:
> Seems that the spec->input_mux contains no item at all.
> So system maybe crash in the snd_hda_input_mux_info() when try to copy
> the items[].label,which is null pointer.
>
> May you replace the function  stac92xx_mux_enum_info() in
> alsa-driver-1.0.15rc2/alsa-kernel/pci/hda/patch_sigmatel.c ?
>
> static int stac92xx_mux_enum_info(struct snd_kcontrol *kcontrol, struct
> snd_ctl_elem_info *uinfo)
> {
> 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
> 	struct sigmatel_spec *spec = codec->spec;
> 	printk("spec->input_mux->num_items is %d
> \n",spec->input_mux->num_items);
> 	if(!spec->input_mux->num_items)
> 		return 0;
> 	return snd_hda_input_mux_info(spec->input_mux, uinfo);
> }
>
> Does it still crash?
> What's the number of num_items?

Thanks, I will try to enter in contact with the reporter and see what's going 
on (I don't have direct access to the hardware) and try this. And later I saw 
too I was wrong as the problem isn't input_mux as it's set to private_imux.

>
> The pin_config for M1210  didn't include any input pin.
> I wonder why.

Probably it's the reason for the bug, as 5stack model doesn't give problems on 
the same hardware.

--
[]'s
Herton
