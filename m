From: Carlo Wood <carlo@alinoe.com>
Subject: Re: OSS layer doesn't ignore xruns.
Date: Wed, 16 Jul 2003 02:11:56 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030716001156.GA10503@alinoe.com>
References: <20030715120100.GA20739@alinoe.com> <Pine.LNX.4.44.0307152022090.27533-200000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307152022090.27533-200000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@perex.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 15, 2003 at 08:31:50PM +0200, Jaroslav Kysela wrote:
> Well, in case of urgent help we have something called as SuSE 
> professional services. You can eventually buy our time, otherwise
> you will have to wait for our free timeslot (if any).

Like you, I volunteer to code Open Source.  In my case 60 hours/week
with zero pay.  No need to rub into my face that you don't get paid.
As I said before, I am not doing this for myself.  There also wasn't
any hurry (except the deadline of the release of kernel 2.6 imho,
for which this better had be fixed) - I just wanted to know if someone
was looking into it.

> I looked to the problem and it seems that the overrun state is handled 
> differently in the OSS API than ALSA implemented. It seems that the stream 
> is not stopped but rather the oldest period (fragment) is discarded.
> 
> The new code (plus some optimization) is in the ALSA CVS tree. The patch 
> is attached to this e-mail.

Thanks for the patch.  I couldn't have wished a better reply ;).

-- 
Carlo Wood <carlo@alinoe.com>


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
