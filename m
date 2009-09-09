From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: control names
Date: Wed, 9 Sep 2009 13:15:36 +0100
Message-ID: <20090909121536.GC9548@sirena.org.uk>
References: <98769532B4BB14429434178695419EAE5F76A259@bgsmsx501.gar.corp.intel.com>
	<20090801094626.GA7979@sirena.org.uk>
	<98769532B4BB14429434178695419EAE5F76AC7D@bgsmsx501.gar.corp.intel.com>
	<20090803101243.GA5959@sirena.org.uk>
	<98769532B4BB14429434178695419EAE5F937C6A@bgsmsx501.gar.corp.intel.com>
	<20090810163408.GA31393@rakim.wolfsonmicro.main>
	<98769532B4BB14429434178695419EAE5F9793FA@bgsmsx501.gar.corp.intel.com>
	<20090811104733.GA8221@rakim.wolfsonmicro.main>
	<98769532B4BB14429434178695419EAE66201FB8@bgsmsx501.gar.corp.intel.com>
	<alpine.LNX.2.00.0909091410480.12929@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F0CE2441E
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Sep 2009 14:15:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0909091410480.12929@eeebox2.perex-int.cz>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Harsha,
	Priya" <priya.harsha@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 09, 2009 at 02:11:34PM +0200, Jaroslav Kysela wrote:
> On Wed, 9 Sep 2009, Harsha, Priya wrote:

> > I am using a control name as "PCM Capture Switch". But the alsa mixer 
> > does not display the mute option for me to mute/unmute the capture path.

> > Same thing for playback works i.e, "PCM Playback Switch" displays a mute 
> > button in alsamixer for me to change....

> Did you press F4 to switch to the capture view?

Also note that alsamixer uses a different display for capture switches
in the UI - you won't see the same format button you'll see

   ------

if the switch is off or

   L    R
   CAPTUR

if it's on under the volume control.
