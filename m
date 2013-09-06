From: Ember Autumn Rose Leona <emberleona@gmail.com>
Subject: Help with editing the Raw Midi data with ALSA?
Date: Fri, 6 Sep 2013 11:02:19 -0700
Message-ID: <CAAVa-AFWJwBAYK2ix643bEVVraG0FkaEO-ovhfrYPZSSU53vdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f178.google.com (mail-vc0-f178.google.com
 [209.85.220.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 4917F261AB2
 for <alsa-devel@alsa-project.org>; Fri,  6 Sep 2013 20:02:20 +0200 (CEST)
Received: by mail-vc0-f178.google.com with SMTP id ha12so2383619vcb.23
 for <alsa-devel@alsa-project.org>; Fri, 06 Sep 2013 11:02:19 -0700 (PDT)
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

Dear ALSA team,

I just joined the mailing list on after being referred to it.

Is it possible for me to edit the Raw Midi data with ALSA... I looked
a RtMidi and that opens a port but doesn't help me Midi Poison or Midi
Message Map.

What I want to do is edit the Midi Messages, re-mapping the notes. I simply
want to flip the progression of the keys on a midi piano from high
notes to low notes. On the fly. Basically I want to take the note on
message byte and use the
note number as an index for an array of remapped keys.

I want to flip the keyboard on a D note for now... then later allow
users to turn this remapping off and on (on the fly.) Also it would be
nice to have certain note ranges  mapped to different programs/patches.

-Ember

PS> I wish I could help test the sound drivers... but I only have an
inexpensive intel integrated sound chip and I am on a dell which needs
to be replaced with something par.
