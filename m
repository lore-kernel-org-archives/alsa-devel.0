From: Aaron Plattner <aplattner@nvidia.com>
Subject: Re: NVIDIA HDMI: Channel remapping does not work for
	stereo?
Date: Tue, 29 Oct 2013 16:12:31 -0700
Message-ID: <527040DF.6090403@nvidia.com>
References: <5269ADEC.9060707@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com [216.228.121.143])
 by alsa0.perex.cz (Postfix) with ESMTP id 613322615A6
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 00:12:33 +0100 (CET)
In-Reply-To: <5269ADEC.9060707@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 10/24/2013 04:31 PM, Anssi Hannula wrote:
> Hi!
>
> I just noticed while testing the ALSA HDMI channel remapping code that
> my NVIDIA codec 0x10de0015 does not seem to follow the Audio Sample
> Packet (ASP) channel mapping (set by verb F34h as per HDA spec 7.3.3.41)
> when playing back stereo audio.
>
> This can be reproduced by e.g.:
> $ speaker-test -c2 -Dhdmi:CARD=NVidia,DEV=0 -m FR,FL
> The channels are reversed compared to what the printout is (i.e. the
> codec plays the streams straight-through instead of swapping channels as
> instructed).
>
> E.g. this works expectedly, however:
> $ speaker-test -c4 -Dhdmi:CARD=NVidia,DEV=1 -m FR,FL,RR,RL
>
> (note that recent sound git master or for-next is needed for these kind
> of remappings to work properly at all)
>
> On Intel HDMI codec 0x80862806 both work.
>
> While stereo right-left swapping is admittedly a rather corner-case
> situation, I guess we should probably refuse such chmaps when they are
> not supported.
>
> Aaron, do you have any information on whether this affects all NVIDIA
> HDMI codecs?

I don't know much about the audio side of things, I'm afraid.  The more 
knowledgeable people I asked about this said that they would expect a 
L/R swap to work.

"In fact the CTR/LFE channels have their mappings swapped.

The default mapping is:
Converter channel 0 mapped to ASP slot 0
Converter channel 1 mapped to ASP slot 1
Converter channel 2 mapped to ASP slot 3
Converter channel 3 mapped to ASP slot 2
Converter channel 4 mapped to ASP slot 4
Converter channel 5 mapped to ASP slot 5
Converter channel 6 mapped to ASP slot 6
Converter channel 7 mapped to ASP slot 7

In theory, you should be able to map any incoming channel, to any 
outgoing channel.


You can look at section7.3.3.41 of the HDA spec (Audio Sample Packet 
(ASP) Channel Mapping) for the information on this.

There is a way to manually send verbs and get their responses to see if 
the HW is programmed correctly.

To do this, you have to use the Immediate Command and response registers 
to issue a "Get ASP Channel Mapping" for each channel. The other 
parameters needed are the codec id and node id of the associated 
converter node.

It is a bit involved, but I can send you the info. If you have the codec 
and node ids already, it is actually relatively simple."

-- 
Aaron
