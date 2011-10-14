From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RFC 1/2] ASoC: soc-pcm: Add flag to ignore
	pmdown_time at pcm_close
Date: Fri, 14 Oct 2011 12:24:01 +0300
Message-ID: <10992537.0jJ7E3VM1G@barack>
References: <1318512215-2331-1-git-send-email-peter.ujfalusi@ti.com>
	<1318512215-2331-2-git-send-email-peter.ujfalusi@ti.com>
	<20111013140003.GM1098@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog102.obsmtp.com (na3sys009aog102.obsmtp.com
	[74.125.149.69]) by alsa0.perex.cz (Postfix) with ESMTP id 2ACBF243DE
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Oct 2011 11:23:57 +0200 (CEST)
Received: by mail-yw0-f46.google.com with SMTP id 31so109116ywp.33
	for <alsa-devel@alsa-project.org>; Fri, 14 Oct 2011 02:23:56 -0700 (PDT)
In-Reply-To: <20111013140003.GM1098@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 13 October 2011 15:00:03 Mark Brown wrote:
> On Thu, Oct 13, 2011 at 04:23:34PM +0300, Peter Ujfalusi wrote:
> > With this flag machine drivers can indicate that it is desired
> > to ignore the pmdown_time for DAPM shutdown sequence when
> > playback stream is stopped.
> > The DAPM sequence will be executed without delay in this case.
> =

> Why make this a per-machine control?  This seems like it'd be a property
> of the CODEC or possibly other chips rather than a machine specific thing?

I thought that depending on the environment we might need this or not for t=
he =

same component, and the best place for this is to be able to define it per =
dai =

link.
However I can move the flag as per codec configuration (within snd_soc_code=
c =

struct). Would that be better?

--
P=E9ter
