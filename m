From: Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 05/16] page-flags: define behavior of FS/IO-related flags
 on compound pages
Date: Wed, 25 Mar 2015 11:56:56 -0700 (PDT)
Message-ID: <alpine.LSU.2.11.1503251149290.3915@eggly.anvils>
References: <1426784902-125149-1-git-send-email-kirill.shutemov@linux.intel.com> <1426784902-125149-6-git-send-email-kirill.shutemov@linux.intel.com> <550B15A0.9090308@intel.com> <20150319200252.GA13348@node.dhcp.inet.fi> <alpine.LSU.2.11.1503221613280.2680@eggly.anvils>
 <20150323121726.GB30088@node.dhcp.inet.fi> <alpine.LSU.2.11.1503241406270.1591@eggly.anvils> <20150325102344.GA10471@node.dhcp.inet.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20150325102344.GA10471@node.dhcp.inet.fi>
Sender: owner-linux-mm@kvack.org
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Hugh Dickins <hughd@google.com>, Dave Hansen <dave.hansen@intel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Andrea Arcangeli <aarcange@redhat.com>, Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Steve Capper <steve.capper@linaro.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.cz>, Jerome Marchand <jmarchan@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 25 Mar 2015, Kirill A. Shutemov wrote:
> 
> We only need tail refcounting for THP, so I think this should fix the issue:
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 4a3a38522ab4..9ab432660adb 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -456,7 +456,7 @@ static inline int page_count(struct page *page)
>  
>  static inline bool __compound_tail_refcounted(struct page *page)
>  {
> -       return !PageSlab(page) && !PageHeadHuge(page);
> +       return !PageSlab(page) && !PageHeadHuge(page) && PageAnon(page);
>  }
>  
>  /*

Yes, that should be a good fix for the mapcount issue.
And no coincidence that it's just what I needed too,
when reusing the PG_compound_lock bit: see my 10/24
(which had to rearrange mm.h. not having your 1/16).

Hugh

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
