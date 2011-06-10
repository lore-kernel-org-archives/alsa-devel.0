From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Do not attempt to change DAI
 sysclk if stream is active
Date: Fri, 10 Jun 2011 12:59:54 +0100
Message-ID: <20110610115954.GK26436@opensource.wolfsonmicro.com>
References: <1307705335-2836-1-git-send-email-jhnikula@gmail.com>
	<20110610113529.GJ26436@opensource.wolfsonmicro.com>
	<20110610145610.a2061e74.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <stable-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110610145610.a2061e74.jhnikula@gmail.com>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/stable>,
	<mailto:stable-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/mailman/private/stable/>
List-Post: <mailto:stable@linux.kernel.org>
List-Help: <mailto:stable-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/stable>,
	<mailto:stable-request@linux.kernel.org?subject=subscribe>
Sender: stable-bounces@linux.kernel.org
Errors-To: stable-bounces@linux.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 10, 2011 at 02:56:10PM +0300, Jarkko Nikula wrote:

> I was thinking to return -EBUSY here but went thinking is it really
> worth of trouble? Machine drivers are calling this from their hw_params
> callback  with the same configuration always (I suppose) for both
> playback and capture and it sounded kind of overkill to check what is
> existing configuration or skip the -EBUSY error.

One fairly common case is selecting the system clock rate to a fixed
multiple of the sample rate so applications that try to set up different
playback and record rates trigger issues.

_______________________________________________
stable mailing list
stable@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/stable
