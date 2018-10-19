From: Thierry Bultel <thierry.bultel@iot.bzh>
Subject: AGL / Questions about the upcoming features of Alsa
Date: Fri, 19 Oct 2018 14:08:57 +0200
Message-ID: <1d03de2c-9064-e29d-7c1b-da255436bf22@iot.bzh>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.iot.bzh (mail.iot.bzh [51.254.0.103])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C91D267939
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2018 14:08:59 +0200 (CEST)
Content-Language: en-US
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
Cc: "Fulup [ IoT.bzh ]" <fulup@iot.bzh>, Stephane Desneux <sdx@iot.bzh>
List-Id: alsa-devel@alsa-project.org

Hi,

My name is Thierry Bultel from Iot.bzh,
and I am part of the responsible team for the audio framework (aka, 4A) 
in Automotive Grade Linux.

For the ones interested in the audio architecture in AGL (and the ones 
that will read my list of questions below),
these are useful links to follow:

New AVIRT driver in replacement of SND_ALOOP:
https://iot.bzh/download/public/2018/amm-dresden/ALSA_Virtual_Dynamic_Sound_Card.pdf

4A framework kickstart:
https://iot.bzh/download/public/2018/amm-dresden/4a-kickstart-Loic-IoTbzh-Dresden-2018.pdf

In AGL, we have used the Alsa framework intensively. I wish I could meet 
the Alsa team next week in Edimburg
but unfortunately I will not be available at that date.

Other colleagues of mine will be there, however.

Here are some points that I would like to be addressed at this meeting:

- ioplug PCMs:
There are known issues about potential (effective !) deadlocks when 
using ioplug PCMs.
We have worked around this by setting LIBASOUND_THREAD_SAFE=0
Is there any pending work to avoid doing this and fix the bug ?

- capture dispatching
According to the experts, what would be the most effective way to 
implement a capture dispatcher ?
The need is to have several applications listening to the same 
microphone. Is JACK the most suitable solution (at this time) ?
(more precisely, this could behave as a 1to1 switch or 1toN, by 
duplicating the audio stream).
A kernel solution based on AVIRT with routing could easily be done, too.

- Documentation:
Is there any pending rework of the documentation for having it a little 
bit more detailed ?
For instance, having a page explaining the roles of period_size and 
buffer_size, would be great, since it impossible
to perform sound playback correctly in an application, without 
understanding those notions.

- Could something like a dynamic setting of the parameters of the rate 
converter plugin, become a reality one day ?

- What is you overall mind about the AVIRT driver that we (with 
Fiberdyne) are developing ?

- Is there a release features roadmap for Alsa (kernel & library) ?

- What is your feeling about PipeWire, which could eventually replace 
PulseAudio (and seems to also invade the JACK land) ?

Thanks !
Thierry Bultel
