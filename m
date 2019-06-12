From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH] ASoC: codec: hdac_hdmi: fix pin
 connections at cvt enable
Date: Wed, 12 Jun 2019 16:20:29 +0300 (EEST)
Message-ID: <alpine.DEB.2.21.1906121615310.4409@eliteleevi>
References: <20190612115509.3400-1-kai.vehmanen@linux.intel.com>
 <s5hzhmnm287.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9E973F80794
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 15:19:36 +0200 (CEST)
In-Reply-To: <s5hzhmnm287.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: libin.yang@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, pierre-louis.bossart@linux.intel.com, Kai Vehmanen <kai.vehmanen@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,


On Wed, 12 Jun 2019, Takashi Iwai wrote:

> On Wed, 12 Jun 2019 13:55:09 +0200,
> Kai Vehmanen wrote:
> > +			curr = snd_hdac_codec_read(hdev, port->pin->nid,
> > +						   0, AC_VERB_GET_CONNECT_SEL,
> > +						   0);
> > +			if (curr != cvt_idx) {
> > +				snd_hdac_codec_write(hdev,
> > +						     port->pin->nid, 0,
> > +						     AC_VERB_SET_CONNECT_SEL,
> > +						     cvt_idx);
> > +				dev_dbg(&hdev->dev,
> > +					"%s: %s set connect %d -> %d\n",
> > +					__func__, cvt->name, port->pin->nid,
> > +					cvt_idx);
> 
> You can simply restore all pins without reading.  The read costs much
> more time than writes.

aa, thanks, you are probably right. I actually had just the write in my 
first version of the patch, but I ended up adding the read just be on the 
safe side. But true, write with same connection should not have any 
side-effects. I'll change this in v2.

Br, Kai
