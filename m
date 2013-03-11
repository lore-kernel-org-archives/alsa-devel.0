From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: Re: [PATCH v2] davinci-mcasp: Add support for
 multichannel playback
Date: Mon, 11 Mar 2013 07:01:58 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ED40278@DBDE01.ent.ti.com>
References: <1361983125-32717-1-git-send-email-michal.bachraty@streamunlimited.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3C660@DBDE01.ent.ti.com>
 <513616F7.2020201@gmail.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3D3ED@DBDE01.ent.ti.com>
 <20130306105713.GF4896@opensource.wolfsonmicro.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3D448@DBDE01.ent.ti.com>
 <5139936D.9080001@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id EB2A72650A9
 for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2013 08:02:09 +0100 (CET)
In-Reply-To: <5139936D.9080001@topic.nl>
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
To: Mike Looijmans <mike.looijmans@topic.nl>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 08, 2013 at 12:59:49, Mike Looijmans wrote:
> 
> I have 9 codecs connected, and the main problem to solve was to get the 
> system to start ALL of them instead of just one.
> 
> I solved that by creating a "multiplex" codec, which in itself doesn't 
> do anything. It exports a mixer where you can switch on/off the codecs 
> you want to use, and it forwards all commands (_ops) to the codecs that 
> are enabled. The serializer settings are sent to the asp driver as if 
> they are TDM masks (using the bits to enable serializers instead).
> 
> In userland you see 10 codecs, you can use each separately, or use the 
> 10th codec (the multiplexer) to use any combination of other codecs.
> 

Interesting approach. I was thinking more on the lines of how to expose
the different serializer-codec pairs to the core. Since there's only one
DMA interface for the different serializers doing this in a generic
manner looked complicated, at least to me.

I am aware of couple of multi-channel systems that preferred the approach
that I mentioned. In one, a cascading of codecs was preferred so as to free
up the extra serializer pads for different functions at the SoC level. 
There was a custom app to split the data coming in from different channels
but since it freed up a few pads, this approach was preferred. In another,
sending SPDIF data to an HDMI transmitter was preferred, again to free up
some pads. It finally depends on what the use-case is and which system level
constraints are more important to satisfy.

It would be good if you could post the changes that made so that we can
discuss on how the approach in detail and possibly enhance the core to
handle the multi-codec scenarios that use-cases like your require.

Regards,
Vaibhav
