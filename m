From: David Henningsson <david.henningsson@canonical.com>
Subject: Future of the HDA driver
Date: Mon, 03 Oct 2011 14:01:00 +0200
Message-ID: <4E89A3FC.4070606@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 71A5824489
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Oct 2011 14:01:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi etc,

1) I think it would make sense to have a designated time and room for a 
"future of HDA" discussion in Prague. We could e g discuss input jacks 
as kcontrols, and exposing routing to user space, as IIRC Mark Brown was 
suggestion earlier. What do you think?

2) With Ubuntu 11.10 in a "Freeze" state and PulseAudio 1.0 out the 
door, I might have some time to contribute to the HDA driver...at least 
if not a lot of urgent stuff comes up, and up to the 3.2 merge window or 
so. (Any idea how far away that would be?) Do you think it would make 
sense to split hda_codec.c into hda_codec.c and hda_autoparser.c, move 
snd_hda_parse_pin_defcfg there, then add more functions as discovered to 
be useful to more than one autoparser?

3) One thing that has been annoyed me lately is the moving of hp out or 
speaker out to line out, which IMO leads to somewhat messy code. Seen in 
retrospect of course, don't you think it would make more sense to do let 
line_out_pins be "line out" only, and add one more variable primary_out 
that would be initialized as:

primary_out_pins = line_outs ? &line_out_pins : (speaker_outs ? 
&speaker_out_pins : (hp_outs ? &hp_out_pins : NULL))

..and then you could do something like:

#define hp_is_primary_out(_auto) ((_auto)->primary_out_pins == 
&(_auto)->hp_out_pins)

Redoing that will probably require careful reading to avoid regressions 
though...

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
