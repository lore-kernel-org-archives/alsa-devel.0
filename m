From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] HP nx6110 quirks
Date: Sat, 20 Aug 2005 16:00:41 -0400
Message-ID: <1124568042.26949.41.camel@mindpipe>
References: <20050820181730.GA12485@procyon.home>
	 <1124563311.26949.23.camel@mindpipe>  <20050820193431.GB12485@procyon.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050820193431.GB12485@procyon.home>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 2005-08-20 at 23:34 +0400, Sergey Vlasov wrote:
> Then we will need to create virtual controls - the chip has only two
> volume control registers for this, so we will need to make three
> virtual controls for volumes, then combine values and write them to
> the chip.  And this will need to be done inside the driver (otherwise
> where the values of virtual controls will be stored while no ALSA
> programs are running?).  Would this be acceptable? 

Actually I was wrong, this is actually supposed to be handled by the new
abstract mixer layer in alsa-lib.  You're right, it does not make sense
to make each mixer implement it.

I don't think it's well documented yet but AFAIK it should work.

Lee



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
