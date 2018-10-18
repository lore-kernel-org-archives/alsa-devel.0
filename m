From: Takashi Sakamoto <mocchi.sakamoto113@gmail.com>
Subject: Re: Audio miniconference schedule
Date: Thu, 18 Oct 2018 19:12:35 +0900 (JST)
Message-ID: <alpine.DEB.2.21.1810181906180.25841@laptop>
References: <20181002195849.GA23818@sirena.org.uk>
 <20181016204852.GK2340@sirena.org.uk> <s5hefcpk2xq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B19C526759E
 for <alsa-devel@alsa-project.org>; Thu, 18 Oct 2018 12:12:47 +0200 (CEST)
Received: by mail-pl1-f193.google.com with SMTP id f18-v6so14124984plr.1
 for <alsa-devel@alsa-project.org>; Thu, 18 Oct 2018 03:12:47 -0700 (PDT)
In-Reply-To: <s5hefcpk2xq.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

On Tue, 16 Oct 2018, Takashi Iwai wrote:
> On Tue, 16 Oct 2018 22:48:52 +0200,
> Mark Brown wrote:
>>
>> As previously announced there's an audio miniconference happening on the
>> 21st in Edinburgh, meeting around 9am and getting started once enough
>> people have arrived (Cirrus people, please let me know if we need to
>> start later, some people have said they'll be arriving late so we won't
>> wait for everyone):
>>
>>    https://blog.sirena.org.uk/2018/09/19/2018-linux-audio-miniconfernce
>>
>> (yes there is a typo in the URL).  A number of people have proposed
>> topics so I just went through them and pulled them into a proposed
>> agenda, this time revised following feedback last time:
>>
>>   - Virtualization (Liam)
>>   - AVB (Liam)
>>   - SoundWire (Liam)
>>   - GObject introspection for language bindings (Sakamoto-san)
>>   - Integrating the ALSA control core (Sakamoto-san)
>>   - DSPs (Liam)
>>    - Sound Open Firmware (Liam)
>>    - Byte controls (Vinod/Patrick)
>>    - Calibration loading (Patrick)
>>    - Exposing graph at runtime (Patrick)
>>    - Batching commands (Patrick)
>>   - AGL (Stephane/Ronan)

Below items are detail of topics from me:
  * Integrating the ALSA control core
   * Obsolete 'dimen' member in container for information to an element
   * Remove limitation on a container for value array to an element
   * User-defined element set left by finished process
   * Expand restriction to the number of user-defined control element set
     per sound card
  * Another approach to produce language bindings by GObject Introspection.

You can see the resource here (WIP):
https://github.com/takaswie/presentations/blob/topic/20181021/20181021/contents.md

Several hours later I leave to Edinburgh. See you later.


Thanks

Takashi Sakamoto
