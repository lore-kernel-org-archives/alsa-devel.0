From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: sys/class entry not created for jack in machine driver
Date: Thu, 12 Mar 2009 04:54:16 -0500
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705ECEA5E07@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 33D5C1038A2
	for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2009 10:54:39 +0100 (CET)
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

I just noticed that the sys/class entry for the jack is not being created,
in my case for headset jack in sdp3430 machine driver.

When creating the SoC jack, the soc-jack mechanism creates a new generic
jack by calling snd_jack_new function. In that function, a new sound
device is created representing the jack device. But in the particular
case of jacks not belonging to a codec, they never get registered. A jack
device in a codec driver gets registered because codec when initializing
the SoC card (snd_soc_init_card) registers the sound card, and the sound
card registers all sound devices added to it, among them the jack device.

In the machine driver, the soc jack is created after the codec has been
initialized and consequently all sound devices attached to the card (till
that point) are already registered. Because of that, the jack device is
created but not registered.

I'm registering the jack device after it's created (in function
snd_jack_new) and now I get the sys/class entry for the headset jack in
my machine driver. What do you think about that solution?

-Misa
