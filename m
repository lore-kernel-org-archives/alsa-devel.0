From: "Yann Le Brech" <yann@le-brech.fr>
Subject: Problem and workaround for Intel HDA
Date: Thu, 19 Jul 2007 18:58:42 +0200
Message-ID: <f3642ae30707190958idfedba3g923de8213d1a6881@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.232])
	by alsa0.perex.cz (Postfix) with ESMTP id BF982103811
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Jul 2007 18:58:43 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id m22so554405nzf
	for <alsa-devel@alsa-project.org>; Thu, 19 Jul 2007 09:58:42 -0700 (PDT)
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

The problem : missing controls of the sound cards for an Intel HDA,
Toshiba Satellite Pro U200

Full description :
I was using the kernel 2.6.19 for a while, and I got some interesting
functions like controlling the sound level on headphones or speakers
separately. Then I upgraded to the kernel 2.6.21.1 and suddently the
level controls changed, to useless level controls, like Master and PCM
only (and some other useless). I wanted to get back to the previous
control set, and I've found a solution by checking what was done in
debugging mode. The previous kernel was not detecting the model
config, but the new one did. So I simply strapped the detection
routine by a return -1 and it did the trick. I know its not the best
thing to do, but it was the simplest thing I thought about.

Outputs :
2.6.19's Alsa output :

ALSA sound/pci/hda/hda_intel.c:695: codec_mask = 0x3

2.6.21.1 :

ALSA sound/pci/hda/hda_intel.c:695: codec_mask = 0x3
ALSA sound/pci/hda/hda_codec.c:1757: hda_codec: model 'toshiba' is
selected for config 1179:1 (Toshiba U205)

How to see the problem :
Just see the list of controls in any mixer software.

Environment :
Toshiba Satellite Pro U200

Software :
KateOS 3.2 with Linux 2.6.19 (working) and 2.6.21.1 (not working)

Workaround :

int __devinit snd_hda_check_board_config(struct hda_codec *codec,
					 int num_configs, const char **models,
					 const struct snd_pci_quirk *tbl)
{
	return -1;  // WORKAROUND
	if (codec->bus->modelname && models) {
		int i;
		for (i = 0; i < num_configs; i++) {
			if (models[i] &&

-- 
a++
Y.
