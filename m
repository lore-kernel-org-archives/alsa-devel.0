From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH 01/15] ASoC: hdac_hdmi: Fix to check num
	nodes correctly
Date: Wed, 2 Dec 2015 00:38:12 +0530
Message-ID: <20151201190807.GA5624@subhransu-desktop>
References: <1448991749-8091-1-git-send-email-subhransu.s.prusty@intel.com>
 <1448992031-8271-1-git-send-email-subhransu.s.prusty@intel.com>
 <s5hy4depd5q.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F22E261AE0
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 14:37:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hy4depd5q.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: patches.audio@intel.com, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 01, 2015 at 01:27:13PM +0100, Takashi Iwai wrote:
> On Tue, 01 Dec 2015 18:46:57 +0100,
> Subhransu S. Prusty wrote:
> > 
> > This patch fixes below static checker warning.
> > 	sound/soc/codecs/hdac_hdmi.c:416 hdac_hdmi_parse_and_map_nid()
> > 	warn: unsigned 'hdac->num_nodes' is never less than zero.
> > 
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > ---
> >  sound/soc/codecs/hdac_hdmi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
> > index 205f2c2..65596b9 100644
> > --- a/sound/soc/codecs/hdac_hdmi.c
> > +++ b/sound/soc/codecs/hdac_hdmi.c
> > @@ -415,7 +415,7 @@ static int hdac_hdmi_parse_and_map_nid(struct hdac_ext_device *edev)
> >  	int cvt_nid = 0, pin_nid = 0;
> >  
> >  	hdac->num_nodes = snd_hdac_get_sub_nodes(hdac, hdac->afg, &nid);
> > -	if (!nid || hdac->num_nodes < 0) {
> > +	if (!nid || hdac->num_nodes <= 0) {
> 
> Checking zero is good, but checking negative is wrong here for
> unsigned int.

Thanks for pointing. Will update.
> 
> 
> Takashi
> 
> >  		dev_warn(&hdac->dev, "HDMI: failed to get afg sub nodes\n");
> >  		return -EINVAL;
> >  	}
> > -- 
> > 1.9.1
> > 

-- 
