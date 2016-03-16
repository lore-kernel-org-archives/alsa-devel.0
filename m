From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8825: fix interrupt fails and
 unstable after resume
Date: Wed, 16 Mar 2016 11:45:13 +0800
Message-ID: <56E8D6C9.8000906@nuvoton.com>
References: <1456686105-6885-1-git-send-email-KCHSU0@nuvoton.com>
 <20160301032623.GH18327@sirena.org.uk> <56E1105E.8010604@nuvoton.com>
 <20160315092711.GH2566@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A805260524
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2016 04:45:19 +0100 (CET)
In-Reply-To: <20160315092711.GH2566@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

Hi,

On 3/15/2016 5:27 PM, Mark Brown wrote:
> On Thu, Mar 10, 2016 at 02:12:46PM +0800, John Hsu wrote:
>   
>> On 3/1/2016 11:26 AM, Mark Brown wrote:
>>     
>>> On Mon, Feb 29, 2016 at 03:01:45AM +0800, John Hsu wrote:
>>>       
>
>   
>>>> +static int nau8825_resume_setup(struct nau8825 *nau8825)
>>>> +{
>>>>         
>
>   
>>> I'd expect to see this shared with initial power on?
>>>       
>
>   
>> There is a little things different between resume and initiation.
>> But I think the function could be reused.
>>     
>
> Really?  Bear in mind the device might have lost power over suspend...
>   

Thanks for your remind. I'll design this function based on the concept.
