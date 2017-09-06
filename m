From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 2/3] ASoC: wm8741: Set OSR mode in
	hw_params()
Date: Wed, 6 Sep 2017 09:20:37 +0100
Message-ID: <20170906082037.tgseyekunu2cf4qx@localhost.localdomain>
References: <1504553653-8144-1-git-send-email-sergej@taudac.com>
 <1504553653-8144-3-git-send-email-sergej@taudac.com>
 <20170905161221.qopgxgaw4zhfzfvs@localhost.localdomain>
 <575ad555-0cab-66de-95b7-4dc1b379ca9c@taudac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BBB82673B5
 for <alsa-devel@alsa-project.org>; Wed,  6 Sep 2017 10:20:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <575ad555-0cab-66de-95b7-4dc1b379ca9c@taudac.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <sergej@taudac.com>
Cc: ce3a@gmx.de, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 05, 2017 at 08:36:24PM +0200, Sergej Sawazki wrote:
> Am 05.09.2017 um 18:12 schrieb Charles Keepax:
> > On Mon, Sep 04, 2017 at 09:34:12PM +0200, Sergej Sawazki wrote:
> > > +	/* oversampling rate */
> > > +	if (params_rate(params) > 96000)
> > > +		mode |= 0x0040;
> > > +	else if (params_rate(params) > 48000)
> > > +		mode |= 0x0020;
> > 
> > Should this not have a case for <= 48k as well? To reset the mode
> > if it was set on a previous playback.
> > 
> 
> It is reset in here:
> 
>     u16 mode = snd_soc_read(codec, WM8741_MODE_CONTROL_1) & 0x183;
> 
> For <= 48k we simply leave it 0. I though about an empty else statement, but
> it is kind of strange, too.
> 

Oops.. sorry yes that is fine.

> > > +
> > >   	/* bit size */
> > >   	switch (params_width(params)) {
> > >   	case 16:
> > > @@ -243,6 +250,7 @@ static int wm8741_hw_params(struct snd_pcm_substream *substream,
> > >   		params_width(params), params_rate(params));
> > >   	snd_soc_write(codec, WM8741_FORMAT_CONTROL, iface);
> > > +	snd_soc_write(codec, WM8741_MODE_CONTROL_1, mode);
> > 
> > Better to use an update_bits rather than basically open-code it
> > with read and then this write.
> > 
> 
> I have used write() and not update_bits() here to be consistent with the way
> the WM8741_FORMAT_CONTROL register is written. If we change it to
> update_bits(), we should refactor the WM8741_FORMAT_CONTROL write to use
> update_bits() too, right?
> 

Yeah that should probably be an update bits too by the looks of
it.

Thanks,
Charles
