From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] HP nx6110 quirks
Date: Sat, 20 Aug 2005 14:41:51 -0400
Message-ID: <1124563311.26949.23.camel@mindpipe>
References: <20050820181730.GA12485@procyon.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050820181730.GA12485@procyon.home>
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

On Sat, 2005-08-20 at 22:17 +0400, Sergey Vlasov wrote:
> 
> Also ac97_quirk=hp_only is needed to make a single Master volume in
> the mixer instead of separate volumes for internal speakers and
> headphones, which just confuses the user. 

The ALSA driver is supposed to expose all the hardware functionality.
It's up to the mixer apps to present it to the user in a sane way.  So
if the hardware supports separate volume controls for the headphones and
internal speakers we should not disable this functionality.  Why not
make three controls, Master, External Speakers and Headphones?

Lee



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
