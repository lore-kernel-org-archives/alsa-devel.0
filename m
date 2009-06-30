From: Kevin Goodsell <kevin-list-alsa-devel@omegacrash.net>
Subject: load_for_all_cards bug
Date: Tue, 30 Jun 2009 12:37:10 -0700
Message-ID: <4A4A6966.20804@omegacrash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nightcrawler (dsl081-160-116.sea1.dsl.speakeasy.net
	[64.81.160.116])
	by alsa0.perex.cz (Postfix) with ESMTP id 054D91038BD
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Jun 2009 21:37:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

(I originally tried to send this via the moderator without subscribing 
to the list, but it never went through and I never received a moderator 
response. Apparently this list is set up as moderated, but nobody is 
actually moderating it.)

Summary: load_for_all_cards fails with existing configuration elements

In snd_config_hook_load_for_all_cards, the first call to 
snd_config_search attempts to locate an existing configuration node with 
the name of the driver.  Typically none is found, and everything is 
good. However, if such a node is located, the next line assumes it is a 
leaf node with type 'string' and calls snd_config_get_string to fetch 
the string value. If this fails, the entire hook is abandoned.

Because of this, setting something like the following in asoundrc:

cards.<driver name>.foo 0

is sufficient to disable the entire card-specific configuration.

As a concrete example, I have a HDA-Intel sound card. dmix.conf includes 
a way to set period_size, period_time, and periods by using 
configuration elements of the form cards.<driver name>.pcm.dmix.<var>. 
In ~/.asoundrc I add

cards.HDA-Intel.pcm.dmix.period_size 1024

This will cause HDA-Intel.conf to fail to load, and the pcm defined in 
default.conf will fail to find the device-specific pcm 
cards.HDA-Intel.pcm.default, and fall back on the default pcm using 
plughw.  By attempting to configure dmix, I have disabled it.

Fixing this may just be a matter of changing the line in 
snd_config_hook_load_for_all_cards from:

if (snd_config_search(root, fdriver, &n) >= 0) {

to:

if (snd_config_search(root, fdriver, &n) >= 0 && n->type != 
SND_CONFIG_TYPE_COMPOUND) {

I have not tested this.

-Kevin
