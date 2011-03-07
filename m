From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: Re: [RFC][PATCH] ASoC: Move symmetric rate check
	for	substreams to hw_params
Date: Mon, 7 Mar 2011 18:21:32 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870370843B37@dbde02.ent.ti.com>
References: <1299498963-1134-1-git-send-email-vaibhav.bedia@ti.com>
	<20110307120924.GC1829@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 67649103827
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 13:51:40 +0100 (CET)
In-Reply-To: <20110307120924.GC1829@sirena.org.uk>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Afzal,
	Mohammed" <afzal@ti.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Monday, March 07, 2011 5:39 PM, Mark Brown wrote:
> On Mon, Mar 07, 2011 at 05:26:03PM +0530, Vaibhav Bedia wrote:
>> Currently the symmetric rate check is present in the
>> snd_pcm_open() call. However this causes snd_pcm_open() to
>> fail for the 2nd substream is 
>> the 2nd call to snd_pcm_open() is made before the 1st
>> substream has 
>> set a non-zero rate by calling snd_pcm_hw_params().
>> 
>> Fix this by moving the call to snd_pcm_apply_symmetry() to
>> soc_pcm_hw_params(). 
> 
> This means that applications won't be constrained by the
> current settings so can't automatically choose the required
> rate.  ALSA is just fundamentally racy here, if you want to
> reliably open bidirectional streams you need to serialise the
> startup of the two directions.    

When a custom application is written then the race condition can be avoided. 

However right now a simple test like "arecord -f dat | aplay -f dat" fails. One way to make it work
is to make sure that a call to arecord/aplay (or some dummy app which just sets some valid rate and returns) 
has been made before both are invoked simultaneously.

Regards,
Vaibhav
