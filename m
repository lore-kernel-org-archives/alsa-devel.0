From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: ALSA and Wine DirectSound question: Fwd from
	wine-patches list
Date: Wed, 10 Aug 2005 15:08:45 -0400
Message-ID: <1123700926.24369.18.camel@mindpipe>
References: <20050810121434.96950.qmail@web52911.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050810121434.96950.qmail@web52911.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Rankin <rankincj@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net, a.villacis@palosanto.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2005-08-10 at 13:14 +0100, Chris Rankin wrote:
> I think the Wine developers are seeking enlightenment from an ALSA Guru. (The "World of Warcraft"
> people seem keen to get this patch working, too ;-).) Can anyone help, please?
> 
> http://www.winehq.org/hypermail/wine-patches/2005/08/0173.html

This sounds a lot like my theory about what is causing the infamous
crackling problem that has been reported with JACK - the ALSA middle
layer is consistently returning an incorrect hardware pointer which
causes a few samples from the other buffer (assuming a double buffering
scheme) to be overwritten.

Lee



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
