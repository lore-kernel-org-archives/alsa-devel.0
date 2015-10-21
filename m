From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ASoC: Intel: Add Skylake HDA platform driver
Date: Wed, 21 Oct 2015 23:53:14 +0300
Message-ID: <20151021205314.GA9839@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id B3F892612AE
 for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2015 22:53:40 +0200 (CEST)
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
To: jeeja.kp@intel.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Jeeja KP,

This is a semi-automatic email about new static checker warnings.

The patch a40e693c7f5e: "ASoC: Intel: Add Skylake HDA platform 
driver" from Jul 9, 2015, leads to the following Smatch complaint:

sound/soc/intel/skylake/skl-pcm.c:802 skl_get_position()
	 warn: variable dereferenced before check 'substream->runtime' (see line 792)

sound/soc/intel/skylake/skl-pcm.c
   791		struct snd_pcm_substream *substream = hstr->substream;
   792		struct hdac_ext_bus *ebus = get_bus_ctx(substream);
                                            ^^^^^^^^^^^^^^^^^^^^^^
Dereference inside function.

   793		unsigned int pos;
   794		int delay;
   795	
   796		/* use the position buffer as default */
   797		pos = snd_hdac_stream_get_pos_posbuf(hdac_stream(hstream));
   798	
   799		if (pos >= hdac_stream(hstream)->bufsize)
   800			pos = 0;
   801	
   802		if (substream->runtime) {
                    ^^^^^^^^^^^^^^^^^^
Checked too late.

   803			delay = skl_get_delay_from_lpib(ebus, hstream, pos)
   804							 + codec_delay;

regards,
dan carpenter
