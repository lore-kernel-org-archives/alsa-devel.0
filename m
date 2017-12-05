From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [alsa-lib][PATCH 3/4] pcm: linear,
 route: handle linear formats with 20-bit sample on 4 bytes
Date: Tue, 5 Dec 2017 17:14:18 +0100
Message-ID: <bfbf0d73-4857-4e37-b629-f6fb1de0925e@maciej.szmigiero.name>
References: <06db78be-2d91-c996-5a5b-d408ff4a84fa@maciej.szmigiero.name>
 <0eaf46f0-5ea3-0d37-7570-731e31ad1485@sakamocchi.jp>
 <d505240a-7a88-4e2c-5fbb-8c6d53377de0@maciej.szmigiero.name>
 <374411db-aae1-e2d7-e7af-15f1f8310231@sakamocchi.jp>
 <s5hshcprzn8.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C5F9266AE1
 for <alsa-devel@alsa-project.org>; Tue,  5 Dec 2017 17:14:21 +0100 (CET)
In-Reply-To: <s5hshcprzn8.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

On 05.12.2017 15:57, Takashi Iwai wrote:
> On Tue, 05 Dec 2017 15:37:09 +0100,
> Takashi Sakamoto wrote:
>>
>> Hi,
>>
(..)
>> In my opinion, addition of constraint of PCM hardware parameters to
>> these PCM plugins is preferable to insertion of the assertions,
>> because abort inner library is bad idea itself. Proper errors should
>> be returned
>> to applications in protocol via alsa-lib PCM APIs. It's more friendly to
>> usual developers and users.
> 
> Well, it's basically moot to discuss about it, as
> snd_pcm_lib_linear_get_index() is an internal function, i.e. it's not
> supposed to be called from applications.
> 
> In that sense, assert() wouldn't be too bad.   However, the primary
> question is -- would it really catch anything in practice?  What drove
> you to put that assert() at all?
> 
> If a check of the valid formats, then calling snd_pcm_format_linear()
> is the safest.

The reason I added these asserts is that snd_pcm_linear_{get,put}_index()
use result from snd_pcm_format_width() directly to calculate an array
index.
If, for any reason, this function returns an unexpected width a subtle
bug will emerge.

Three reasons that I could think of why an unexpected width would be
returned is a bug in a plugin that uses these functions (currently 9
plugins use them) that fail to properly restrict source / destination
format space to linear formats only, a bug in general format refining
code or somebody adding a format to linear formats mask without
adapting conversion arrays, too.

I know that these may sound like rare occurrences but since this
check is close to zero-cost (it only happens on plugin stack
initialization time and not, for example, at every sample) I think it
is worth the extra time (and one can always compile the library with
NDEBUG to skip it).

> thanks,
> 
> Takashi
> 

Thanks,
Maciej
