From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS/sound: DB1200 audio support depends
	on MIPS arch.
Date: Thu, 10 Nov 2011 12:17:42 +0000
Message-ID: <20111110121742.GE21453__4678.35130771181$1320927505$gmane$org@linux-mips.org>
References: <20111110122241.eed1e785e4c015a51b9ef585@canb.auug.org.au>
	<1320924059-4142-1-git-send-email-manuel.lauss@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1320924059-4142-1-git-send-email-manuel.lauss@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 10, 2011 at 12:20:59PM +0100, Manuel Lauss wrote:

> DB1200 audio support should only be visible if MIPS/Alchemy arch is
> selected.  Fixes an x86-allmodconfig build failure in linux-next.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>

Thanks, folded into the offending patch.

  Ralf
