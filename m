From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH 05/16] page-flags: define behavior of FS/IO-related flags
 on compound pages
Date: Thu, 19 Mar 2015 22:02:52 +0200
Message-ID: <20150319200252.GA13348@node.dhcp.inet.fi>
References: <1426784902-125149-1-git-send-email-kirill.shutemov@linux.intel.com>
 <1426784902-125149-6-git-send-email-kirill.shutemov@linux.intel.com>
 <550B15A0.9090308@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <550B15A0.9090308@intel.com>
Sender: owner-linux-mm@kvack.org
To: Dave Hansen <dave.hansen@intel.com>, Hugh Dickins <hughd@google.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Andrea Arcangeli <aarcange@redhat.com>, Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Steve Capper <steve.capper@linaro.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.cz>, Jerome Marchand <jmarchan@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 19, 2015 at 11:29:52AM -0700, Dave Hansen wrote:
> On 03/19/2015 10:08 AM, Kirill A. Shutemov wrote:
> > The odd exception is PG_dirty: sound uses compound pages and maps them
> > with PTEs. NO_COMPOUND triggers VM_BUG_ON() in set_page_dirty() on
> > handling shared fault. Let's use HEAD for PG_dirty.
> 
> Can we get the sound guys to look at this, btw?  It seems like an odd
> thing that we probably don't want to keep around, right?

CC: +sound guys

I'm not sure what is right fix here. At the time adding __GFP_COMP was a
fix: see f3d48f0373c1.

Other odd part about __GFP_COMP here is that we have ->_mapcount in tail
pages to be used for both: mapcount of the individual page and for gup
pins. __compound_tail_refcounted() doesn't recognize that we don't need
tail page accounting for these pages.

Hugh, I tried to ask you about the situation several times (last time on
the summit). Any comments?

-- 
 Kirill A. Shutemov

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
