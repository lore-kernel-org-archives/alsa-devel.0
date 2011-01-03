From: Veselin Georgiev <anrieff@gmail.com>
Subject: Support for X-Fi external front panel - how hard would
	it be to add it?
Date: Mon, 3 Jan 2011 02:10:35 +0200
Message-ID: <201101030210.35718.anrieff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 8F06424746
	for <alsa-devel@alsa-project.org>; Mon,  3 Jan 2011 01:12:09 +0100 (CET)
Received: by ewy19 with SMTP id 19so5447488ewy.38
	for <alsa-devel@alsa-project.org>; Sun, 02 Jan 2011 16:12:09 -0800 (PST)
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

Hi guys,

I have a Creative X-fi Fatal1ty edition card that goes along with an external 
front panel (I/O) module, mounted in the 5.25" bay.
So I see there is no support for the front panel in the ALSA X-fi driver, and 
I'm wondering how hard would it be to add it? Is it at all feasible?

I'm hazy on the following stuff:
- Does one need to reverse-engineer how the sound card communicates with the 
front panel, or there are datasheets about that available?
- Correct me if I'm wrong, but AFAIK, the emu10k1 driver works fine with SB 
Live! or Audigy-based front-panels, so why not borrow some code from there and 
hack it into the ctxfi?

I'm ready to try out some hacking with this and get my hands dirty with code 
if required.

On a related note, there should be some official statement in the wiki saying 
that the front panel is not supported, as I did a lot of googling, checking 
various ubuntu/fedora forum posts that hinted the lack of support, and I'm 
still puzzled... :s

Best Regards,
Veselin Georgiev
