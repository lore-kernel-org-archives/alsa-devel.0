From: Alban Peignier <alban@tryphon.eu>
Subject: Looking for ideas to solve ruby alsa duplex problem
Date: Sat, 30 Oct 2010 12:19:33 +0200
Message-ID: <4CCBF135.9030507@tryphon.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.tryphon.org (potamus.tryphon.org [88.191.95.142])
	by alsa0.perex.cz (Postfix) with ESMTP id 90F6E1037F5
	for <alsa-devel@alsa-project.org>;
	Sat, 30 Oct 2010 12:19:36 +0200 (CEST)
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

Hi alsa guys,

We're working on a ruby binding for alsa :
http://projects.tryphon.eu/ruby-alsa/. PCM Playback and Capture are
supported for a long time (and used in production for several months).
Ruby developers can find the gem on http://rubygems.org/gems/ruby-alsa.

But we're trying to investigate a problem with "duplex mode" :
http://projects.tryphon.eu/ruby-alsa/ticket/4. We can't find a way to
record and playback simple stereo streams in the same process without
dummy hackings :-/ We don't need an extreme latency, just a simple
process to add/receive streams on network (our LinkStream/LinkBox project).

I hopes it's only a misusage of the ALSA API or a mistake in
hardware/software configurations. But after several weeks on this
problem, we need fresh ideas :)

Even if you have no idea about ruby, the Playback [0] and Capture [1]
are very simple wrappers around the native ALSA API [2] (mapped with
ruby ffi [3]). The alsa device is opened and configured using a shared
open method in Stream [4]. Very few code in fact.

I hope an expert eye will find a beginning of solution ;)

Kind regards,

0. http://projects.tryphon.eu/ruby-alsa/browser/lib/alsa/pcm/playback.rb
1. http://projects.tryphon.eu/ruby-alsa/browser/lib/alsa/pcm/capture.rb
2. http://projects.tryphon.eu/ruby-alsa/browser/lib/alsa/pcm/native.rb
3. http://github.com/ffi/ffi
4. http://projects.tryphon.eu/ruby-alsa/browser/lib/alsa/pcm/stream.rb
-- 

Alban Peignier - alban@tryphon.eu

Tryphon : Radio, Web and Free Software
http://www.tryphon.eu
