From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: SoC Machine Code Suggestions
Date: Wed, 27 Jun 2007 17:48:08 +0100
Message-ID: <1182962888.3172.72.camel@localhost.localdomain>
References: <61c0054e0706270847n42fbd896lc2e778e1e3862380@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id A035810385B
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jun 2007 18:48:09 +0200 (CEST)
In-Reply-To: <61c0054e0706270847n42fbd896lc2e778e1e3862380@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Kavan <pkavan@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2007-06-27 at 10:47 -0500, Paul Kavan wrote:

> 
> First. when the pcm interface starts/stops, I get a pop that comes from the
> codec analog output transitioning some. 

Does your codec have a digital mute ?

Fwiw, you may want read the application notes in the codec datasheet for
minimising any pops and clicks. 

It's also sometimes useful to minimise any output gains at startup and
then ramp them up to the desired volume before playback starts on some
devices.

> Now, there may be some hardware
> fixes to this, but what I would like to do it mute the amp until the last
> possible second before audio is played. I can accomplish this with a simple
> gpio call, but am not sure where best to turn the mute on and off. Any
> suggestions with that would be appreciated.
> 

Turning the amp on and off will probably also cause a pop. It's just a
matter of finding what pops the least. You could add your GPIO amp code
to the machine driver say in startup/shutdown, but please bear in mind
the amp may take a little time to get up and running. 

Liam
