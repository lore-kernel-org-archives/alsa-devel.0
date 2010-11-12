From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ALSA UCM
Date: Fri, 12 Nov 2010 17:28:12 +0000
Message-ID: <20101112172812.GF28804@sirena.org.uk>
References: <alpine.LNX.2.00.1011041949180.29422@eeebox2.perex-int.cz>
	<1288897628.3277.99.camel@odin>
	<AANLkTikn6Q+6KUpZaDGXuX=bGHrbV_9s91C6u+rS5e22@mail.gmail.com>
	<1289046396.3318.53.camel@odin>
	<AANLkTina11GuK4jqP=DtD-OEjTiRtNa_yG0QKy7XDuxs@mail.gmail.com>
	<alpine.LNX.2.00.1011101608250.29422@eeebox2.perex-int.cz>
	<1289576480.3480.101.camel@odin>
	<alpine.LNX.2.00.1011121722090.29422@eeebox2.perex-int.cz>
	<1289580140.3480.117.camel@odin>
	<alpine.LNX.2.00.1011121743180.29422@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 61B5A103976
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 18:28:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1011121743180.29422@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, abraham duenas <aduejazz@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 12, 2010 at 05:55:50PM +0100, Jaroslav Kysela wrote:

> the ctl device for which will be cset commands applied. Also, Mark said 
> something that your code used some transformations for controls to specify 
> how the controls will be changed, but not-specified controls will be set 
> from previous (probably default) state, something like this:

I'm having a hard time parsing this but I *think* this is the ability to
look up a control by virtual function and have it mapped onto an actual
physical control (so for example master volume could change depending on
output).
