From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl_ssi: Fix channel swap on
	playback start
Date: Mon, 3 Apr 2017 15:20:14 -0700
Message-ID: <20170403222013.GB21156@Asurada-Nvidia>
References: <1491058131-31366-1-git-send-email-festevam@gmail.com>
 <CAG5mAdyg9jbNcGi6kNLf5s1wk7HkchM5-MjVVJNuATU07HtrUQ@mail.gmail.com>
 <CAOMZO5BiRrRurJUsLb_pgSEw+ByZSSg6b3sRz17tKUXT1wRaSw@mail.gmail.com>
 <a572220b-5bbd-9e47-31c4-ba272c5d28e7@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f68.google.com (mail-pg0-f68.google.com [74.125.83.68])
 by alsa0.perex.cz (Postfix) with ESMTP id A2274266972
 for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2017 00:20:10 +0200 (CEST)
Received: by mail-pg0-f68.google.com with SMTP id 81so32651235pgh.3
 for <alsa-devel@alsa-project.org>; Mon, 03 Apr 2017 15:20:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <a572220b-5bbd-9e47-31c4-ba272c5d28e7@invoxia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Sascha Hauer <kernel@pengutronix.de>, Timur Tabi <timur@tabi.org>, Caleb Crome <caleb@crome.org>, Mark Brown <broonie@kernel.org>, Max Krummenacher <max.krummenacher@toradex.com>, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 04, 2017 at 12:05:57AM +0200, Arnaud Mouiche wrote:

> The Patch break something. I'm not even able to to make two
> consecutives 'aplay' in order to generate something correct  on the
> external SSI bus.
> - boot
> - aplay -D hw:1,0 -r 48000 -c 2 -f S16_LE /dev/urandom
> Playing raw data '/dev/urandom' : Signed 16 bit Little Endian, Rate
> 48000 Hz, Stereo
> ^CAborted by signal Interrupt...
> 
> => ok
> 
> - aplay -D hw:1,0 -r 48000 -c 2 -f S16_LE /dev/urandom
> Playing raw data '/dev/urandom' : Signed 16 bit Little Endian, Rate
> 48000 Hz, Stereo
> aplay: pcm_write:1702: write error: Input/output error
> 
> => no clock on external bus.

It's probably because of the nr_active_streams and keep_active in
the fsl_ssi_config() are not working correctly any more since the
TE abd RE are always set -- wondering why Fabio and Max don't see
any problem; is there any diff between vanilla and -next?
