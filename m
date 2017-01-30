From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 00/19][RFC v2] ALSA: firewire-motu: new
 driver for MOTU FireWire series
Date: Mon, 30 Jan 2017 12:17:55 +0900
Message-ID: <d125f1b3-1325-1d1a-cc25-4bac0a961ae9@sakamocchi.jp>
References: <20170129035417.2095-1-o-takashi@sakamocchi.jp>
 <20170129133456.GC15067@marvin.atrad.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id E038A266CDA
 for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2017 04:17:58 +0100 (CET)
In-Reply-To: <20170129133456.GC15067@marvin.atrad.com.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Woithe <jwoithe@just42.net>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Jan 29 2017 22:34, Jonathan Woithe wrote:
> On Sun, Jan 29, 2017 at 12:53:58PM +0900, Takashi Sakamoto wrote:
>> This patchset updates a part of my previous RFC, just for MOTU FireWire
>> series.
>>
>> [RFC][PATCH 00/37] ALSA: firewire: support AMDTP variants
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-July/094789.html
>>
>> This patchset adds support for a part of MOTU FireWire series with their
>> functionality of packet streaming. Below models are newly supported:
>>  - 828
>>  - 828mk2
>>  - 828mk3 (FireWire/Hybrid)
>
> I like the general architecture of this driver.
>
> It's not clear to me whether you have utilised some information about these
> devices from FFADO or have duplicated the protocol reverse engineering
> process yourself.  If the former it would be nice to include a brief
> acknowlegement since the FFADO MOTU protocol documents and code represents a
> large body of work by several people which brought an otherwise undocumented
> protocol into the open.  If the latter then clearly it's a moot point.

If you had enough time to read codes in this patchset carefully and have 
enough knowledge about each layer related to packet streaming and IEEE 
1394 bus, you wouldn't have such opinion for this patchset.


Regards

Takashi Sakamoto
