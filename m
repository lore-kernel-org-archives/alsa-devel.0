From: Daniel Mack <daniel@caiaq.org>
Subject: Re: [PATCH 3/3] asoc tlv320aic3x: add more
	routing	controls
Date: Fri, 25 Apr 2008 11:30:40 +0200
Message-ID: <20080425093040.GB18558@buzzloop.caiaq.de>
References: <20080425091809.GA18518@buzzloop.caiaq.de>
	<s5hod7yl265.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id D1917245CB
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Apr 2008 11:30:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hod7yl265.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 25, 2008 at 11:22:10AM +0200, Takashi Iwai wrote:
> > Add more routing controls to AIC3x chips to allow things like routing
> > the left PGA input to right line out.
> > 
> > Signed-off-by: Daniel Mack <daniel@caiaq.de>
> 
> It should be implemented rather with stereo mixer switches in
> general...

Not necessarily as left and right inputs of let's say the line input can
be used for entierly different things. Same is counts for the outputs. 
This is the case in my setup and I guess for mobile phone (what the chip
is made for) there will be more cases.

Controlling them with stereo mixers would just cause more confusion in
the already over-engineered chip, I fear.

Best regards,
Daniel
