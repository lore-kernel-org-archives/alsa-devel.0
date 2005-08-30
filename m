From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: mmap as parameter for ALSA kernel modules
Date: Tue, 30 Aug 2005 12:26:04 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0508301224180.18036-100000@studcom.urz.uni-halle.de>
References: <87zmr25tc0.fsf@mandala.my-fqdn.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <87zmr25tc0.fsf@mandala.my-fqdn.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jhair Tocancipa Triana <jhair_tocancipa@gmx.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jhair Tocancipa Triana wrote:
> Does exist an ALSA kernel module parameter to toggle use of mmap

No.  Applications that use mmap have to access the sound buffer in a
different way, so only the application itself can choose whether to
use mmap or not.


Regards,
Clemens



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
