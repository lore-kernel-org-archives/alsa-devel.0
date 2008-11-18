From: "naveen krishna ch" <naveenkrishna.ch@gmail.com>
Subject: Re: Jack insertion
Date: Tue, 18 Nov 2008 19:07:41 +0530
Message-ID: <ef0d8a250811180537j31c6e59bp56dc82fd9fd3d483@mail.gmail.com>
References: <ef0d8a250811172246i411bd978h7d252b6d536e6de7@mail.gmail.com>
	<20081118110341.GA23217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qb-out-1314.google.com (qb-out-1314.google.com [72.14.204.172])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E21E2455B
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 14:37:42 +0100 (CET)
Received: by qb-out-1314.google.com with SMTP id q15so2861229qbq.44
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 05:37:42 -0800 (PST)
In-Reply-To: <20081118110341.GA23217@sirena.org.uk>
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
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, linux-omap-open-source@linux.omap.com
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 18, 2008 at 4:33 PM, Mark Brown <broonie@sirena.org.uk> wrote:

> On Tue, Nov 18, 2008 at 12:16:18PM +0530, naveen krishna ch wrote:
>
> > Now my issue is is there any work regarding the Headset JACK
> > insertion/detection.
>
> > Earlier there was a proposal for a jack insertion layer.
>
> > Can anyone suggest me in this regard.
>
> The generic ALSA part of the API has been merged already - see
> include/sound/jack.h.
>
> For ASoC drivers you need to implement the actual detection in your
> machine driver.  Normally this would just hook into a GPIO.  You can
> then update the DAPM widget for the jack to mark it as in use or not in
> use (some existing drivers do this) and also hook into the generic
> userspace API (that's not been implemented by anyone yet).  Plan is to
> get something more generic into 2.6.30.


Thanks for  your early reply. I am a new to this SOC i started developing
the driver taking the  Gumsitcs OVERO  + TWL4030 ASOC codec driver as
reference.

But, i see the jack layer uses the structure

struct snd_device {
        struct list_head list;          /* list of registered devices */
        struct snd_card *card;          /* card which holds this device */
        snd_device_state_t state;       /* state of the device */
        snd_device_type_t type;         /* device type */
        void *device_data;              /* device structure */
        struct snd_device_ops *ops;     /* operations */
};

The latest ALSA SOC drivers ( In my case my driver ) uses

struct snd_soc_device {
        struct device *dev;
        struct snd_soc_machine *machine;
        struct snd_soc_platform *platform;
        struct snd_soc_codec *codec;
        struct snd_soc_codec_device *codec_dev;
        struct delayed_work delayed_work;
        struct work_struct deferred_resume_work;
         void *codec_data;
};

in this case what shall i do to make use of the jack abstraction layer.
If cant use the jack abstraction layer, can any one suggest me the other way
out

-- 
Thanks,
(: Naveen Krishna Ch :)
