From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: sys/class entry not created for jack in machine
	driver
Date: Thu, 12 Mar 2009 14:39:31 +0000
Message-ID: <20090312143930.GC24376@sirena.org.uk>
References: <2C7D3DF36ADFFC479B44490D912B616705ECEA5E07@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D60FB103896
	for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2009 15:39:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705ECEA5E07@dlee07.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 12, 2009 at 04:54:16AM -0500, Lopez Cruz, Misael wrote:

> case of jacks not belonging to a codec, they never get registered. A jack
> device in a codec driver gets registered because codec when initializing
> the SoC card (snd_soc_init_card) registers the sound card, and the sound
> card registers all sound devices added to it, among them the jack device.

Ah, you should move the jack registration to the device initialisation -
it needs to happen before the card is registered.  Putting it in
sdp4030_twl4030_init() ought to do the job.

> I'm registering the jack device after it's created (in function
> snd_jack_new) and now I get the sys/class entry for the headset jack in
> my machine driver. What do you think about that solution?

That shouldn't be required.

BTW, when talking about code modifications you've done it's normally
helpful if you post the change you've made to reduce the chances of
miscommunication.
