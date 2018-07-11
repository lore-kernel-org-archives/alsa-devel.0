From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Subject: Re: [PATCH v2] ASoC: hdac_hdmi: Program pin-port-mux
 during jack report event
Date: Wed, 11 Jul 2018 16:26:03 +0530
Message-ID: <20180711105603.GA23064@intel.com>
References: <1531290643-29312-1-git-send-email-sriramx.periyasamy@intel.com>
 <s5hpnzup8y6.wl-tiwai@suse.de> <20180711092545.GA30345@intel.com>
 <s5h4lh6ay3h.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 8282A267610
 for <alsa-devel@alsa-project.org>; Wed, 11 Jul 2018 13:00:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h4lh6ay3h.wl-tiwai@suse.de>
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
Cc: ALSA ML <alsa-devel@alsa-project.org>, Patches Audio <patches.audio@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jeeja KP <jeeja.kp@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 11, 2018 at 12:03:14PM +0200, Takashi Iwai wrote:
> On Wed, 11 Jul 2018 11:25:46 +0200,
> Sriram Periyasamy wrote:
> > 
> > On Wed, Jul 11, 2018 at 08:45:05AM +0200, Takashi Iwai wrote:
> > > On Wed, 11 Jul 2018 08:30:43 +0200,
> > > Sriram Periyasamy wrote:
> > > > +		if (port->pin->conn_index > 0)
> > > > +			snd_hdac_codec_write(&edev->hdev, port->pin->nid,
> > > > +						0, AC_VERB_SET_CONNECT_SEL,
> > > > +						port->pin->conn_index - 1);
> > > 
> > > And, here checks conn_index > 0 while...
> > > 
> > > > @@ -903,6 +931,9 @@ static int hdac_hdmi_set_pin_port_mux(struct snd_kcontrol *kcontrol,
> > > >  		}
> > > >  	}
> > > >  
> > > > +	if (ucontrol->value.enumerated.item[0] > 0)
> > > > +		port->pin->conn_index =	ucontrol->value.enumerated.item[0];
> > > 
> > > ... conn_index is set only non-zero here.
> > > 
> > > That is, once after a non-zero is passed, conn_index can't any longer
> > > back to zero.  I guess it's not intentional?
> > > 
> > 
> > No, it is intentional. For example, two ports are connected to the
> > display and user land set mux only for one port. Hence other port's
> > conn_index is set to default 0. When jack report happens for that port,
> > we would be writing invalid connection select index which will lead to
> > undefined hardware behaviour as per the HDA spec.
> > 
> > Though it is userland's mistake, it is better to take care in the driver.
> 
> Then wouldn't it be better to remember the last set value in
> hdac_hdmi_pin_mux_widget_event()?  The purpose of the patch is to
> restore the previous state.
> 

Since hdac_hdmi_pin_mux_widget_event() invoked only for current playback
pin-port-mux path, we wouldn't restore other port's indices. So
hdac_hdmi_jack_report() chosen which will restore other ports also in
all use cases.

Thanks,
Sriram.
