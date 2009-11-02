From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: question on snd_jack_report
Date: Mon, 2 Nov 2009 18:01:21 +0000
Message-ID: <20091102180121.GA9501@rakim.wolfsonmicro.main>
References: <DC9628ADC672424FAECF61709E90EDDE6A2486FB@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 33FC42434F
	for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2009 19:01:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <DC9628ADC672424FAECF61709E90EDDE6A2486FB@bgsmsx501.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Kp, Jeeja" <jeeja.kp@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 02, 2009 at 11:08:09PM +0530, Kp, Jeeja wrote:

> Sorry,it's evtest.c( this program polls /dev/input/eventX and prints
> the events). Basically when a Headphone is inserted into the jack, driver
> send snd_jack_report() with the status of present to ALSA. When the
> respective /dev/input/event5 is read from userspace, it must print the
> events. I don't see any events when snd_jack_report() is called.

Is there actually a state transition occurring?  You will only see an
event generated when the status of the jack changes so if the headphone
is repeatedly reported as present but never reported as absent then
you'll never see anything in user space.
