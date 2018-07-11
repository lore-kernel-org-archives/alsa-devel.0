From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Subject: Re: [PATCH v2] ASoC: hdac_hdmi: Program pin-port-mux
 during jack report event
Date: Wed, 11 Jul 2018 14:55:46 +0530
Message-ID: <20180711092545.GA30345@intel.com>
References: <1531290643-29312-1-git-send-email-sriramx.periyasamy@intel.com>
 <s5hpnzup8y6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A140267711
 for <alsa-devel@alsa-project.org>; Wed, 11 Jul 2018 11:29:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hpnzup8y6.wl-tiwai@suse.de>
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

On Wed, Jul 11, 2018 at 08:45:05AM +0200, Takashi Iwai wrote:
> On Wed, 11 Jul 2018 08:30:43 +0200,
> Sriram Periyasamy wrote:
> > 
> > @@ -167,6 +171,30 @@ static void hdac_hdmi_jack_report(struct hdac_hdmi_pcm *pcm,
> >  
> >  	if (is_connect) {
> >  		/*
> > +		 * Increment the usage count to ensure that the device
> > +		 * is runtime active to send verb across.
> > +		 */
> > +		pm_runtime_get_sync(&edev->hdev.dev);
> 
> This looks more reasonable now, but...
> 
> > +		/* set the device if pin is mst_capable */
> > +		if (hdac_hdmi_port_select_set(edev, port) < 0) {
> > +			dev_err(&edev->hdev.dev,
> > +				"port %d device select fail\n", port->id);
> > +			return;
> 
> It appears like an unbalanced pm refcount here in the error path.
> 

Thanks for pointing out. Will fix it.

> > +		}
> > +
> > +		/*
> > +		 * Restore the connection selection index of the
> > +		 * respective pin.
> > +		 */
> > +		if (port->pin->conn_index > 0)
> > +			snd_hdac_codec_write(&edev->hdev, port->pin->nid,
> > +						0, AC_VERB_SET_CONNECT_SEL,
> > +						port->pin->conn_index - 1);
> 
> And, here checks conn_index > 0 while...
> 
> > @@ -903,6 +931,9 @@ static int hdac_hdmi_set_pin_port_mux(struct snd_kcontrol *kcontrol,
> >  		}
> >  	}
> >  
> > +	if (ucontrol->value.enumerated.item[0] > 0)
> > +		port->pin->conn_index =	ucontrol->value.enumerated.item[0];
> 
> ... conn_index is set only non-zero here.
> 
> That is, once after a non-zero is passed, conn_index can't any longer
> back to zero.  I guess it's not intentional?
> 

No, it is intentional. For example, two ports are connected to the
display and user land set mux only for one port. Hence other port's
conn_index is set to default 0. When jack report happens for that port,
we would be writing invalid connection select index which will lead to
undefined hardware behaviour as per the HDA spec.

Though it is userland's mistake, it is better to take care in the driver.

Thanks,
Sriram.
