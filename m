From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH v2 1/1] ASoC: core: Do not print an actual
	error when deferring probe
Date: Wed, 18 May 2016 17:53:49 +0200
Message-ID: <2174266.52DIgyL9R9@ws-stein>
References: <1463584020-6085-1-git-send-email-alexander.stein@systec-electronic.com>
 <20160518152028.GM8104@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webbox1416.server-home.net (webbox1416.server-home.net
 [77.236.96.61]) by alsa0.perex.cz (Postfix) with ESMTP id 7CB60260647
 for <alsa-devel@alsa-project.org>; Wed, 18 May 2016 17:53:51 +0200 (CEST)
In-Reply-To: <20160518152028.GM8104@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Ricard Wanderlof <ricard.wanderlof@axis.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wednesday 18 May 2016 16:20:28, Mark Brown wrote:
> On Wed, May 18, 2016 at 05:07:00PM +0200, Alexander Stein wrote:
> > In case there is no DAI (yet), do not print an error, this might happen
> > a lot of times. Print a notice instead.
> 
> Oh, and the other thing about this which I should have mentioned is that
> it applies to every single resource acquisition in the kernel - this
> needs addressing at a global error rather than piecemeal.  Raphael was
> intending to work on avoiding probe deferral in the first place by
> sorting probe and there were also some proposals to have a helper for
> printing error messages which would suppress the display of probe
> deferral errors before the final run at late initcall.  Obviously the
> second mechanism is substantially simpler to implement.

I remember those patches a bit. But working with late initcall sound to me 
this has no effect on probe deferral in drivers loaded by modules, no?

Regards,
Alexander
