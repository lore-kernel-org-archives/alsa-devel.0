From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [linux-audio-user] Again on sudden and
 occasional	Jack	crackling sound
Date: Thu, 11 Aug 2005 11:33:34 -0400
Message-ID: <1123774415.6980.18.camel@mindpipe>
References: <42F02BB2.3000201@virgilio.it> <42F62AE8.60604@virgilio.it>
	 <87r7d4xmxm.fsf@localhost.localdomain> <42F7D849.3030000@virgilio.it>
	 <87ll3byh42.fsf@localhost.localdomain>
	 <1123557715.25617.32.camel@localhost.localdomain>
	 <42F8A6AE.6010609@virgilio.it> <7q8xzb5ekw.fsf@io.com>
	 <42F92B60.9020909@virgilio.it>
	 <1123620561.25617.58.camel@localhost.localdomain>
	 <1123639951.21956.5.camel@mindpipe>  <1123702719.24369.24.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1123702719.24369.24.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: A list for linux audio users <linux-audio-user@music.columbia.edu>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2005-08-10 at 15:38 -0400, Lee Revell wrote:
> So in both cases we're operating in mmap mode and ALSA is returning a
> slightly incorrect hardware pointer which leads to crackling.

Another thing to find out is whether this bug is more common when using
sample rates like 44100, 88200, where the number of periods per buffer
is not an integer.

Lee



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
