From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [ALSA] Enable capture from line-in and CD on
	Revolution 5.1
Date: Wed, 26 Jun 2013 10:53:05 +0300
Message-ID: <20130626075305.GB1895@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1050.oracle.com (aserp1050.oracle.com [141.146.126.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 7721A264EAA
 for <alsa-devel@alsa-project.org>; Wed, 26 Jun 2013 11:12:43 +0200 (CEST)
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by aserp1050.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with ESMTP id
 r5Q7sDjG022834
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <alsa-devel@alsa-project.org>; Wed, 26 Jun 2013 07:54:14 GMT
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: voss@seehuhn.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

[ This warning is very old, but I was working on some related code and
  didn't know how to fix it ].

Hello Jochen Voss,

This is a semi-automatic email about new static checker warnings.

The patch a58e7cb16dfa: "[ALSA] Enable capture from line-in and CD on 
Revolution 5.1" from Oct 4, 2006, leads to the following Smatch 
complaint:

sound/i2c/other/ak4xxx-adda.c:808 build_adc_controls()
	 error: we previously assumed 'ak->adc_info' could be null (see line 789)

sound/i2c/other/ak4xxx-adda.c
   788			if (ak->type == SND_AK5365 && (idx % 2) == 0) {
   789				if (! ak->adc_info || 
                                      ^^^^^^^^^^^^
Old check.

   790				    ! ak->adc_info[mixer_ch].switch_name) {
   791					knew.name = "Capture Switch";
   792					knew.index = mixer_ch + ak->idx_offset * 2;
   793				} else
   794					knew.name = ak->adc_info[mixer_ch].switch_name;
   795				knew.info = ak4xxx_switch_info;
   796				knew.get = ak4xxx_switch_get;
   797				knew.put = ak4xxx_switch_put;
   798				knew.access = 0;
   799				/* register 2, bit 0 (SMUTE): 0 = normal operation,
   800				   1 = mute */
   801				knew.private_value =
   802					AK_COMPOSE(idx/2, 2, 0, 0) | AK_INVERT;
   803				err = snd_ctl_add(ak->card, snd_ctl_new1(&knew, ak));
   804				if (err < 0)
   805					return err;
   806	
   807				memset(&knew, 0, sizeof(knew));
   808				knew.name = ak->adc_info[mixer_ch].selector_name;
                                            ^^^^^^^^^^^^^^^^^^^^^
New dereference.

   809				if (!knew.name) {
   810					knew.name = "Capture Channel";

regards,
dan carpenter
