From: Steve Longerbeam <stevel@embeddedalley.com>
Subject: a new synthesizer driver
Date: Wed, 18 Jul 2007 18:28:26 -0700
Message-ID: <469EBE3A.30002@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp108.biz.mail.mud.yahoo.com (smtp108.biz.mail.mud.yahoo.com
	[68.142.201.177])
	by alsa0.perex.cz (Postfix) with SMTP id 49D5B103834
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Jul 2007 03:28:29 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

I'm embarking on a big task: writing a new synthesizer driver. My device 
has all the ingredients for a MIDI wavetable sythesizer: 64 voices, each 
voice with envelope, pitch, and LFO controls. Also global effects like 
reverb. It's similar to the emu10k1.

So my first question would be, is the synth code under synth/emux/ 
general enough to use for a different synthesizer chip? Ie, can I 
implement my own operators in 'struct snd_emux_operators' and pass that 
to snd_emux_register() ?

Would it be a simple matter to make synth/emux/ a generic synth layer, 
by moving all the source in synth/emux/ up one level to synth/, and then 
rename all functions and data structures starting with "snd_emux" to 
"snd_synth" ? For instance, snd_emux_operators becomes 
snd_synth_operators, snd_emux_control() becomes snd_synth_control(), etc.

It seems this path is already partially completed, since 
synth/emux/soundfont.c is a generic soundfont loader.

The thing I want to avoid doing is creating a synth/my_synth/ directory 
and duplicating lots of code from synth/emux/ (including just copying 
soundfont.c verbatim!).

Steve
