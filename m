From: Matt Flax <flatmax@flatmax.org>
Subject: [PLUGINS] Multichannel over I2S : extra cost of user
	space plugins
Date: Wed, 8 Mar 2017 23:18:15 +1100
Message-ID: <b4d4d4e3-1b94-4ff1-eabe-d3fe28b9b94c@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nsstlmta17p.bpe.bigpond.com (nsstlmta17p.bpe.bigpond.com
 [203.38.21.17]) by alsa0.perex.cz (Postfix) with ESMTP id 0159A26690D
 for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2017 13:18:20 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, hias@horus.com
List-Id: alsa-devel@alsa-project.org

Recently I was advised to channel multichannel audio over stereo I2S and 
unpack in user space with plugins.

I have questions about this approach.

Right now, with a hacked machine driver, I get DMA unpacking to 
multichannel for free. It works with all sample rates in silicon and it 
also works with all word sizes.

If I switch to user space ALSA plugin unpacking, as advised, can anyone 
answer the following questions please :

If I want to handle all word sizes which are currently implemented S16 
-> S32, do I need to use different plugins to handle different word sizes ?

Regarding the actual channel unpacking, will it cost a lot more to do 
this in user space, rather then using the DMA silicon ? The bcm2835 is 
not a very powerful processor and this is a concern.

Does anyone have an example plugin which will handle all word sizes 
through one plugin device ?


thanks

Matt
