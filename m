From: Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH] ASoC: Intel: Skylake: fix dereference
 before NULL check on ebus
Date: Wed, 19 Apr 2017 14:34:33 +0100
Message-ID: <fa93c146-cb7b-cefa-75d3-6507c63200c5@canonical.com>
References: <20170419121613.12353-1-colin.king@canonical.com>
 <20170419133249.ac3sdmn7kqjbxaii@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 85505266A4B
 for <alsa-devel@alsa-project.org>; Wed, 19 Apr 2017 15:34:37 +0200 (CEST)
In-Reply-To: <20170419133249.ac3sdmn7kqjbxaii@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org, Dharageswari R <dharageswari.r@intel.com>, Vinod Koul <vinod.koul@intel.com>, Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>, Jayachandran B <jayachandran.b@intel.com>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>, linux-kernel@vger.kernel.org, Yong Zhi <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org

On 19/04/17 14:32, Dan Carpenter wrote:
> On Wed, Apr 19, 2017 at 01:16:13PM +0100, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> ebus is being NULL checked however it is being dereferenced
>> earlier on the assignment bus = ebus_to_hbus(ebus).  Fix this
>> by moving the assignment to after the NULL check on ebus to
>> avoid a NULL pointer dereference error.
>>
> 
> ebus_to_hbus() doesn't dereference "ebus" it just uses it for pointer
> math.
> 
> #define ebus_to_hbus(ebus)      (&(ebus)->bus)
> 
> If you pass a NULL to there, it returns an offset starting from NULL but
> it doesn't Oops.

Doh, brown paper bag moment for me.

> 
> regards,
> dan carpenter
> 
> 
