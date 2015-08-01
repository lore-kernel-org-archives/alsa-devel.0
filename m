From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: Abouut adv7511 driver
Date: Sat, 01 Aug 2015 12:44:06 +0300
Message-ID: <2068811.mrRDGz9M57@avalon>
References: <87zj2cvqi7.wl%kuninori.morimoto.gx@renesas.com>
 <55BB2704.4070509@metafoo.de>
 <87y4hwviyu.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <87y4hwviyu.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Magnus <magnus.damm@gmail.com>, alsa-devel@vger.kernel.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hello,

On Friday 31 July 2015 08:21:16 Kuninori Morimoto wrote:
> Hi Lars
> Cc Magnus, Laurent
> 
> > > I noticed Analog Devices has adv7511 support on
> > > http://wiki.analog.com/resources/tools-software/linux-drivers/drm/adv751
> > > 1
> > > 
> > > And I tried this driver on my board, and it works.
> > > 
> > > if my understanding was correct, latest linux kernel doesn't have
> > > adv7511 "sound" support yet.
> > > Thus, I would like to have it on linux kernel.
> > > According to this driver/file, it is under GPL-2, so it is no problem
> > > from license point of view.
> > > 
> > > According to git log Signd-off-by, Lars/Mark are listed on this adv7511
> > > sound driver. but I wonder why it is not on upstream ? Are there some
> > > reason ??
> > > If you don't mind, I would like to send it to ML.
> > > This is OK ?
> > 
> > The reason why the driver is not upstream at the moment is that the way it
> > implements things is definitely not the right way. But there is still a
> > lot of discussion on what actually is the right way to implement audio
> > support for HDMI devices. Once that has been sorted out the driver will
> > hopefully go upstream.

Beside the in-kernel API, have you given a thought to DT bindings for HDMI 
encoders ? Some platforms use DT bindings based on OF graph for the video 
path, would it make sense to model the audio path similarly ? The 
implementation could become a bit of a challenge though.

> Thank you for explaining this background.
> I understand. feel free to contact me if you want me test.

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
