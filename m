From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Do not attempt to change DAI
 sysclk if stream is active
Date: Fri, 10 Jun 2011 14:56:10 +0300
Message-ID: <20110610145610.a2061e74.jhnikula@gmail.com>
References: <1307705335-2836-1-git-send-email-jhnikula@gmail.com>
	<20110610113529.GJ26436@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <stable-bounces@linux.kernel.org>
In-Reply-To: <20110610113529.GJ26436@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/stable>,
	<mailto:stable-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/mailman/private/stable/>
List-Post: <mailto:stable@linux.kernel.org>
List-Help: <mailto:stable-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/stable>,
	<mailto:stable-request@linux.kernel.org?subject=subscribe>
Sender: stable-bounces@linux.kernel.org
Errors-To: stable-bounces@linux.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, 10 Jun 2011 12:35:30 +0100
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Fri, Jun 10, 2011 at 02:28:55PM +0300, Jarkko Nikula wrote:
> 
> >  
> > +	if (mcbsp_data->active)
> > +		return 0;
> > +
> 
> Shouldn't we be returning -EBUSY or something here so the caller knows
> we didn't do what it asked (after checking to make sure it's not just
> trying to set the existing configuration)?  Otherwise it might get
> surprised, assume the new configuration and just move the bug elsewhere.

I was thinking to return -EBUSY here but went thinking is it really
worth of trouble? Machine drivers are calling this from their hw_params
callback  with the same configuration always (I suppose) for both
playback and capture and it sounded kind of overkill to check what is
existing configuration or skip the -EBUSY error.

-- 
Jarkko

_______________________________________________
stable mailing list
stable@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/stable
