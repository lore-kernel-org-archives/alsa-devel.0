From: Joachim Foerster <mls.JOFT@gmx.de>
Subject: Re: How to enforce 32bit access?
Date: Fri, 05 Oct 2007 19:09:53 +0200
Message-ID: <1191604193.5762.2.camel@localhost>
References: <1191339247.30745.23.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 2EC0410384E
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Oct 2007 19:09:56 +0200 (CEST)
In-Reply-To: <1191339247.30745.23.camel@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Lorenz Kolb <lorenz.kolb@lkmail.de>
List-Id: alsa-devel@alsa-project.org

Hi ALSA devs,

meanwhile I tried to put a constraint on SNDRV_PCM_HW_PARAM_FRAME_BITS
by the use of snd_pcm_hw_constraint_minmax() function with min=32 and
max=32, but still no success - the ALSA Library still makes 16bit
accesses, when playing mono (1 channel) files.

Any ideas?

On Tue, 2007-10-02 at 17:34 +0200, Joachim Foerster wrote:
> [...]
> 
> Therefore my question is:
> 
> In my driver for the controller, how do I tell ALSA, that it is only
> allowed to write in 32bit quantities?
> Is this possible at all?
> Or do I have to use a special .asoundrc file?

Thanks,
 Joachim
