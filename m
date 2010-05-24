From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Query about code organization for kernel driver.
Date: Mon, 24 May 2010 23:19:01 +0100
Message-ID: <20100524221900.GA13604@sirena.org.uk>
References: <AANLkTin91dBbESP2i_LyZKoL0KdBWFKzqKPIpuQyIIGY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 810BF103830
	for <alsa-devel@alsa-project.org>;
	Tue, 25 May 2010 00:19:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTin91dBbESP2i_LyZKoL0KdBWFKzqKPIpuQyIIGY@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Anksh Agarwal <anksh.agarwal@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 25, 2010 at 01:17:39AM +0530, Anksh Agarwal wrote:

> i am not aware how to split the audio path enable/disable code from the soc
> driver
> and which would be ideal directory to place them, since there is hardly any
> interaction
> between playback and device enable/disable routines? I think the device
> enable/disable code outside sound/ directory wont be a good idea as its
> to be specifically used by alsa playback/record only.

Could you be more specific about what you mean by "enable/disable
rountines" and a "list of devices"?  What are you actually trying to
control or enable and disable here?  Your description of having a sysfs
file for changing devices at runtime sounds like something that would
normally be done via the ALSA APIs but it's very hard to understand what
exactly you're controlling here.
