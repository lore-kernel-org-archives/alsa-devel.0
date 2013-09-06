From: "Keith A. Milner" <maillist@superlative.org>
Subject: Re: Help with editing the Raw Midi data with ALSA?
Date: Fri, 06 Sep 2013 23:08:17 +0100
Message-ID: <4431902.sYuv2gyIvb@kamdesktop>
References: <CAAVa-AFWJwBAYK2ix643bEVVraG0FkaEO-ovhfrYPZSSU53vdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f46.google.com (mail-wg0-f46.google.com [74.125.82.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 44C67261ACF
 for <alsa-devel@alsa-project.org>; Sat,  7 Sep 2013 00:08:22 +0200 (CEST)
Received: by mail-wg0-f46.google.com with SMTP id k14so3482525wgh.25
 for <alsa-devel@alsa-project.org>; Fri, 06 Sep 2013 15:08:22 -0700 (PDT)
In-Reply-To: <CAAVa-AFWJwBAYK2ix643bEVVraG0FkaEO-ovhfrYPZSSU53vdQ@mail.gmail.com>
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
Cc: Ember Autumn Rose Leona <emberleona@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Friday 06 Sep 2013 11:02:19 Ember Autumn Rose Leona wrote:
> Dear ALSA team,
> 
> I just joined the mailing list on after being referred to it.

I actually think this is the wrong place. Alsa-user might be more appropriate 
as you are probably talking about a program which uses the ALSA APIs, rather 
than developments to ALSA itself, which is what this list is for.

https://lists.sourceforge.net/lists/listinfo/alsa-user

Despite being off-topic, I will try to give some guidance.

> 
> Is it possible for me to edit the Raw Midi data with ALSA... I looked
> a RtMidi and that opens a port but doesn't help me Midi Poison or Midi
> Message Map.
> 
> What I want to do is edit the Midi Messages, re-mapping the notes. I simply
> want to flip the progression of the keys on a midi piano from high
> notes to low notes. On the fly. Basically I want to take the note on
> message byte and use the
> note number as an index for an array of remapped keys.
> 
> I want to flip the keyboard on a D note for now... then later allow
> users to turn this remapping off and on (on the fly.) Also it would be
> nice to have certain note ranges  mapped to different programs/patches.
> 

It sounds like you want to receive note events from a MIDI IN interface (e.g. 
from a keyboard) and want to transform them before pushing them out of a MIDI 
OUT interface?

If so, I strongly recommend you consider looking at Jack Connection Kit for 
this sort of application.

http://jackaudio.org/

Jack is a layer which sits over ALSA and provides, amongst other things, 
flexible connections and routing for audio and midi data. It will give you a 
lot of flexibility and allow you to connect your application to other 
applications (e.g. virtual midi keyboards like VMPK, and sound generators like 
Qsynth or Pianoteq).

If you aim to produce something that you will publish for other people to use 
in audio production, Jack is really the standard that people will expect.

If you want a starting point, something like KMidimon, which works directly 
with ALSA as well as via Jack, would give lots of useful example code:

http://kmidimon.sourceforge.net/

Cheers,

Keith
