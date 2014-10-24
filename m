From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 1/7] ASoC: Intel: Make ADSP memory block
 allocation more generic
Date: Fri, 24 Oct 2014 10:22:03 +0300
Message-ID: <5449FE1B.9000201@linux.intel.com>
References: <1413814012-5619-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <20141021230224.GF2344@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 7644926049C
 for <alsa-devel@alsa-project.org>; Fri, 24 Oct 2014 09:22:06 +0200 (CEST)
In-Reply-To: <20141021230224.GF2344@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Liam

On 10/22/2014 02:02 AM, Mark Brown wrote:
> On Mon, Oct 20, 2014 at 03:06:46PM +0100, Liam Girdwood wrote:
>> Current block allocation is tied to block type and requestor type. Make the
>> allocation more generic by removing the struct module parameter and adding
>> a generic block allocator structure. Also pass in the list that the blocks
>> have to be added too in order to remove dependence on block requestor type.
> I'm having trouble apply this - patch 1 manages to apply with some fuzz
> but patch 5 is failing.  Probably needs refreshing against Vinod's
> recent changes?  I applied everything up to patch 4 (ASoC: Intel: Add
> runtime module support).

For me sound.git for-next head a929d726a507 don't build anymore. I have 
to revert all your four recent patches cd51c82524ff -4. I guess some 
patch order or dependency issue since the first patch doesn't build when 
applied to topic/intel?

-- 
Jarkko
