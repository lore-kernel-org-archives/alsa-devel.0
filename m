From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/1] conf/ucm: chtrt5650: Add UCM config
 for chtrt5650
Date: Fri, 4 Jan 2019 11:39:15 -0600
Message-ID: <d1cb1156-3ba8-813d-d119-8aa0b557cb36@linux.intel.com>
References: <20181230053526.14989-1-russell.parker7@gmail.com>
 <1f9d849d-db6f-ae8b-5551-efdb1b13bdea@linux.intel.com>
 <20190104173056.GA9638@celes>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190104173056.GA9638@celes>
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
To: Russell Parker <russell.parker7@gmail.com>
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org, evananderson@thelinuxman.us
List-Id: alsa-devel@alsa-project.org


On 1/4/19 11:30 AM, Russell Parker wrote:
> On Wed, Jan 02, 2019 at 10:14:06AM -0600, Pierre-Louis Bossart wrote:
>> On 12/29/18 11:35 PM, Russell Parker wrote:
>>> Add a UCM configuration for the rt5650 codec. Tested on
>>> a Samsung Chromebook 3. Adapted with minor modifications
>>> from GitHub user evan-a-a's gist:
>>> https://gist.github.com/evan-a-a/86b2a698708074530e2d0ee7c6498767
>>>
>>> Signed-off-by: Russell Parker <russell.parker7@gmail.com>
>> Interesting, thanks!
>>
>> IIRC rt5650 is a low-cost version of rt5645, the machine driver only has a
>> minor difference in the routing map and the controls are largely identical.
>> Could we maybe factor the common codec parts with the include mechanism,
>> similar to what was done for the SOC/platform driver settings?
> I'll take a stab at parsing out the common configuration this weekend.
> Seems like chtrt5645-mono-speaker-analog-mic can also be refactored to
> use the shared code.
Thanks!
>
> Any input on naming the shared directory? The existing shared
> configurations all seem to be from the same codec. Maybe a
> src/conf/ucm/codecs/rt5645-rt5650/ directory is in order.

IIRC there is also an alc3278 that's a low cost version of rt5645, so 
maybe rt5645-common is a more relevant name.
