From: Tanu Kaskinen <tanuk@iki.fi>
Subject: Re: How to define card specific pcm devices?
Date: Wed, 05 Sep 2012 08:41:02 +0300
Message-ID: <1346823662.3629.17.camel@laptop>
References: <1344597903.4283.68.camel@IT-D-4QB9Z4J>
 <1345215040.2530.26.camel@IT-D-4QB9Z4J>
 <CAN8cciYX4krbJvb9PWQFswAKq0AqiC_oh20n+NB2Ak=BF8Zgxw@mail.gmail.com>
 <CAN8cciZH2SL7Dm0ykA+hfRoksngo9Z15pkTLHp+pXDYSKpm90w@mail.gmail.com>
 <1345262953.4864.12.camel@laptop>
 <CAN8cciYojFegq+cQ-=h6Yt4njO4pPyGB_zG2WkMT4A8euDV6Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 02BCD2652C4
 for <alsa-devel@alsa-project.org>; Wed,  5 Sep 2012 07:41:06 +0200 (CEST)
In-Reply-To: <CAN8cciYojFegq+cQ-=h6Yt4njO4pPyGB_zG2WkMT4A8euDV6Ww@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-08-29 at 09:44 +0800, Raymond Yau wrote:
> strictly speaking your mic is not a true stereo mic and the channel
> map is [left, null] instead of the normal map [left,right] of line-in
> or stereo mic

I think specifying the channel map like you suggest would be a good
solution. Supporting it would require some extra work in PulseAudio, but
I think PulseAudio will anyway have to be extended to query the channel
map information from UCM.

Now the problem is that UCM doesn't provide the channel map information
at all. Should the channel map be provided in the device "Value"
section? Like this:

SectionDevice."my-mono-mic" {

        ...

        Value {
                # Does this value become redundant if
                # the "CaptureChannelMap" value is added?
                CaptureChannels "2"

		# Channel names match the constants in
                # Takashi's proposed channel map API
                CaptureChannelMap "FL, NA"
        }

}

Opinions? (Liam added to CC - am I right in that you should be CC'd in
all UCM related discussions?)

-- 
Tanu
