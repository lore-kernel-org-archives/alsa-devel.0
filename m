From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Jack insertion
Date: Tue, 18 Nov 2008 13:57:40 +0000
Message-ID: <20081118135736.GA29982@sirena.org.uk>
References: <ef0d8a250811172246i411bd978h7d252b6d536e6de7@mail.gmail.com>
	<20081118110341.GA23217@sirena.org.uk>
	<ef0d8a250811180537j31c6e59bp56dc82fd9fd3d483@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4CD6324567
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 14:57:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ef0d8a250811180537j31c6e59bp56dc82fd9fd3d483@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: naveen krishna ch <naveenkrishna.ch@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-omap-open-source@linux.omap.com
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 18, 2008 at 07:07:41PM +0530, naveen krishna ch wrote:

> But, i see the jack layer uses the structure

> struct snd_device {
>         struct list_head list;          /* list of registered devices */
>         struct snd_card *card;          /* card which holds this device */

Look at how you register a jack - it's with the snd_card and....

> The latest ALSA SOC drivers ( In my case my driver ) uses

> struct snd_soc_device {

...the ASoC device is just a particular way of implementing the generic
snd_card and has a snd_card as a member.

> in this case what shall i do to make use of the jack abstraction layer.
> If cant use the jack abstraction layer, can any one suggest me the other way
> out

You can use the snd_card of the ASoC card directly.
