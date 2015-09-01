From: frederik@ofb.net
Subject: feature request: alsamixer should show alternatives to
 function key bindings, at least F1/Help
Date: Mon, 31 Aug 2015 17:21:30 -0700
Message-ID: <20150901002130.GC15028@ofb.net>
Reply-To: frederik@ofb.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ofb.net (ofb.net [64.13.131.34])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F291260627
 for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2015 02:21:30 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In alsamixer, many options are bound to function keys. These are used
by my window manager, so I cannot use them in my terminal. The
alsamixer man page mentions that 'gnome-terminal' cannot use function
keys either.

I noticed from the "Help" screen that many function keys have
non-function-key alternatives, for instance instead of F6 I can press
"s". This is great, but there is one remaining problem: The legend (at
the top of the alsamixer screen) labels commands with their
function-key bindings. This includes "Help" which is labelled with
"F1". Seeing this, users are likely to assume that "F1" is the only
binding for "Help". But it turns out that one can also access "Help"
with "?" and "H". This can be learned by reading the man page or
pressing keys experimentally, but it would be nice if "Help" was just
labeled with either "?" or "H", as that allows people who are unable
to use function keys to easily access the help screen and then see
that alternate (non-function-key) bindings exist for other commands as
well.

As an aside, it seems odd to map "q" to "increase left volume"...

(from https://bugs.freedesktop.org/show_bug.cgi?id=91782, edited)
