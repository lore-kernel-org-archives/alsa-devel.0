From: Tanu Kaskinen <tanuk@iki.fi>
Subject: Re: How to define card specific pcm devices?
Date: Fri, 07 Sep 2012 12:03:34 +0300
Message-ID: <1347008614.4213.19.camel@laptop>
References: <1344597903.4283.68.camel@IT-D-4QB9Z4J>
 <1345215040.2530.26.camel@IT-D-4QB9Z4J>
 <CAN8cciYX4krbJvb9PWQFswAKq0AqiC_oh20n+NB2Ak=BF8Zgxw@mail.gmail.com>
 <CAN8cciZH2SL7Dm0ykA+hfRoksngo9Z15pkTLHp+pXDYSKpm90w@mail.gmail.com>
 <1345262953.4864.12.camel@laptop>
 <CAN8cciYojFegq+cQ-=h6Yt4njO4pPyGB_zG2WkMT4A8euDV6Ww@mail.gmail.com>
 <1346823662.3629.17.camel@laptop>
 <CABS+qY3kEPr3aknPvTU+iRyGxSo2G_iDawv+fr7WBJrJQUO+2w@mail.gmail.com>
 <1346951914.4893.6.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 4DF4D26168B
 for <alsa-devel@alsa-project.org>; Fri,  7 Sep 2012 11:03:38 +0200 (CEST)
In-Reply-To: <1346951914.4893.6.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2012-09-06 at 18:18 +0100, Liam Girdwood wrote:
> On Wed, 2012-09-05 at 12:24 +0100, Girdwood, Liam wrote:
> > On 5 September 2012 06:41, Tanu Kaskinen <tanuk@iki.fi> wrote:
> >         On Wed, 2012-08-29 at 09:44 +0800, Raymond Yau wrote:
> >         > strictly speaking your mic is not a true stereo mic and the
> >         channel
> >         > map is [left, null] instead of the normal map [left,right]
> >         of line-in
> >         > or stereo mic
> >         
> >         
> >         I think specifying the channel map like you suggest would be a
> >         good
> >         solution. Supporting it would require some extra work in
> >         PulseAudio, but
> >         I think PulseAudio will anyway have to be extended to query
> >         the channel
> >         map information from UCM.
> >         
> >         Now the problem is that UCM doesn't provide the channel map
> >         information
> >         at all. Should the channel map be provided in the device
> >         "Value"
> >         section? Like this:
> >         
> >         SectionDevice."my-mono-mic" {
> >         
> >                 ...
> >         
> >                 Value {
> >                         # Does this value become redundant if
> >                         # the "CaptureChannelMap" value is added?
> >                         CaptureChannels "2"
> >         
> 
> I would expect to see a "1" here unless we cannot open the pcm in mono
> mode.

Me too, but the original problem was precisely that the pcm only
supports stereo, and the second channel is silent.

> >                         # Channel names match the constants in
> >                         # Takashi's proposed channel map API
> >                         CaptureChannelMap "FL, NA"
> >                 }
> >         
> >         }
> 
> This seems fine and should be a simple patch for UCM too. Pulsaudio
> could use the map information/preference from UCM (like above) to
> configure the driver using Takashi's new channel map API.

Ok, I plan to work on this soonish.

A question about the syntax: should the PHASE_INVERSE and DRIVER_SPEC
flags be supported also here, or is it enough to have just a simple list
of channels?

I think the syntax will have to support the flags, because if
DRIVER_SPEC is set, then the channel position is effectively unknown to
PulseAudio. The channel map may potentially affect routing decisions,
which is the main reason why the channel map information is needed in
UCM in addition to the new channel map API. The channel map API can be
used only with an already opened pcm handle, which is not very useful
when doing routing decisions.

-- 
Tanu
